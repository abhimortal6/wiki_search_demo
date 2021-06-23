class ApiConstants {
  //Base url
  static const String SERVER_BASE_URL = "https://en.wikipedia.org/w/api.php";

  static const String GET_RANDOM_PAGES =
      "?action=query&format=json&prop=pageimages%7Cpageterms&generator=random&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&grnlimit=10&wbptterms=description";
  static const String SEARCH_TERM =
      "?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=";
}

enum ApiStatus { idle, started, completed, loading, searching, empty, failed, timeout, noNetwork }
