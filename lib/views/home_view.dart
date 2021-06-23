import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiki_search/utils/constants/app_constants.dart';
import 'package:wiki_search/utils/constants/color_constants.dart';
import 'package:wiki_search/view_models/home_view_model.dart';
import 'package:wiki_search/widgets/anim_searchbar.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(onPressed: () {
          _homeViewModel!.getRandomWikiPages(context);
        }),
        body: Container(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  children: [],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: AnimSearchBar(
                  width: _size.width - 40,
                  onSuffixTap: () {},
                  textController: _homeViewModel!.searchBarTextFieldController,
                  rtl: true,
                  autoFocus: true,
                  suffixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ],
          ),
        ));
  }
}
