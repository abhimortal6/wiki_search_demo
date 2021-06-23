class WikiThumbnailModel {
  int? height;
  int? width;
  String? source;

  WikiThumbnailModel({this.height, this.width, this.source});

  factory WikiThumbnailModel.fromJson(
    Map<String, dynamic> parsedJson,
  ) {
    return WikiThumbnailModel(
      height: parsedJson['height'] != null ? parsedJson['height'] : null,
      width: parsedJson['width'] != null ? parsedJson['width'] : null,
      source: parsedJson['source'] != null ? parsedJson['source'] : null,
    );
  }
}
