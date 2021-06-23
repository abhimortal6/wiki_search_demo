import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiki_search/models/global/wiki/wiki_page_model.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget({this.wikiPageModel});

  final WikiPageModel? wikiPageModel;

  @override
  Widget build(BuildContext context) {
    String? _thumbUrl;
    String? _description;
    if (wikiPageModel!.thumbnail != null) _thumbUrl = wikiPageModel!.thumbnail!.source;

    if (wikiPageModel!.terms != null) _description = wikiPageModel!.terms!.description!.first;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: GestureDetector(
        onTapUp: (t) {
          launch("https://en.wikipedia.org/?curid=${wikiPageModel!.pageId!}");
        },
        child: Card(
          child: Container(
            height: 80,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: _thumbUrl != null ? CachedNetworkImage(imageUrl: _thumbUrl) : Image.asset("assets/images/logos/wiki_logo.png"),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          wikiPageModel!.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          "Description: ",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Container(
                          height: 45,
                          child: Text(
                            _description ?? "",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
