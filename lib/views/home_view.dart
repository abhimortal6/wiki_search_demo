import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wiki_search/utils/constants/api_constants.dart';
import 'package:wiki_search/utils/constants/app_constants.dart';
import 'package:wiki_search/view_models/home_view_model.dart';
import 'package:wiki_search/widgets/anim_searchbar.dart';
import 'package:wiki_search/widgets/edge_alert.dart';
import 'package:wiki_search/widgets/list_tile_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel? _homeViewModel;
  late Size _size;

  @override
  Widget build(BuildContext context) {
    if (_homeViewModel == null) {
      _homeViewModel = Provider.of<HomeViewModel>(context);
      _size = MediaQuery.of(context).size;
      _homeViewModel!.getRandomWikiPages(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.APP_NAME,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    _homeViewModel!.searchedApiStatus == ApiStatus.completed
                        ? "Search Result for \"${_homeViewModel!.searchBarTextFieldController.text.trim()}\""
                        : _homeViewModel!.searchedApiStatus == ApiStatus.noData
                            ? "Cannot found anything for \"${_homeViewModel!.searchBarTextFieldController.text.trim()}\""
                            : "Some Random Articles",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (_homeViewModel!.randomData != null)
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ListView.builder(
                    itemCount: _homeViewModel!.searchedData != null
                        ? _homeViewModel!.searchedData!.pages!.length
                        : _homeViewModel!.randomData!.pages!.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTileWidget(
                        wikiPageModel: _homeViewModel!.searchedData != null
                            ? _homeViewModel!.searchedData!.pages![index]
                            : _homeViewModel!.randomData!.pages![index],
                      );
                    },
                  ),
                ),
              Positioned(
                bottom: 10,
                right: 20,
                child: AnimSearchBar(
                  width: _size.width - 40,
                  onSuffixTap: () => _homeViewModel!.searchWikiPage(context),
                  textController: _homeViewModel!.searchBarTextFieldController,
                  rtl: true,
                  suffixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ],
          ),
        ));
  }
}
