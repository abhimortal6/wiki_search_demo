import 'package:wiki_search/models/global/wiki/wiki_terms_model.dart';
import 'package:wiki_search/models/global/wiki/wiki_thumbnail_model.dart';

class WikiPageModel {
  int? pageId;
  String? title;
  WikiThumbnailModel? thumbnail;
  WikiTermsModel? terms;

  WikiPageModel({this.pageId, this.title, this.thumbnail, this.terms});

  factory WikiPageModel.fromJson(
    Map<String, dynamic> parsedJson,
  ) {
    return WikiPageModel(
      pageId: parsedJson['pageid'] != null ? parsedJson['pageid'] : null,
      title: parsedJson['title'] != null ? parsedJson['title'] : null,
      thumbnail: parsedJson['thumbnail'] != null ? WikiThumbnailModel.fromJson(parsedJson['thumbnail']) : null,
      terms: parsedJson['terms'] != null ? WikiTermsModel.fromJson(parsedJson['terms']) : null,
    );
  }
}
