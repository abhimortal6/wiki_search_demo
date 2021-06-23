import 'package:wiki_search/models/global/wiki/wiki_thumbnail_model.dart';

class WikiTermsModel {
  List<String>? description;

  WikiTermsModel({this.description});

  factory WikiTermsModel.fromJson(
    Map<String, dynamic> parsedJson,
  ) {
    return WikiTermsModel(
      description:
          parsedJson['description'] != null ? List<String>.from(parsedJson['description'].map((description) => description)) : null,
    );
  }
}
