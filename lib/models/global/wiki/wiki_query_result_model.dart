import 'package:wiki_search/models/global/wiki/wiki_page_model.dart';

class WikiQueryResultModel {
  List<WikiPageModel>? pages;

  WikiQueryResultModel({this.pages});

  factory WikiQueryResultModel.fromJson(
    Map<String, dynamic> parsedJson,
  ) {
    return WikiQueryResultModel(
      pages: parsedJson['query']['pages'] != null
          ? List<WikiPageModel>.from(parsedJson['query']['pages'].map((page) => new WikiPageModel.fromJson(page)))
          : null,
    );
  }
}
