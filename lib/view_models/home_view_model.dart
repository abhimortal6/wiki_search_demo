import 'package:flutter/material.dart';
import 'package:wiki_search/models/global/response_data_model.dart';
import 'package:wiki_search/models/global/wiki/wiki_query_result_model.dart';
import 'package:wiki_search/utils/api_helper.dart';
import 'package:wiki_search/utils/constants/api_constants.dart';

class HomeViewModel with ChangeNotifier {
  ApiStatus apiStatus = ApiStatus.idle;

  WikiQueryResultModel? _searchedData;
  WikiQueryResultModel? _randomData;

  TextEditingController searchBarTextFieldController = TextEditingController();

  getRandomWikiPages(BuildContext context) async {
    Uri _requestUri = Uri.parse(ApiConstants.SERVER_BASE_URL + ApiConstants.GET_RANDOM_PAGES);

    apiStatus = ApiStatus.loading;
    notifyListeners();

    ResponseData _response = await ApiHelper().getRequest(context, _requestUri, showLoader: true, showLog: true, responseName: "Random");

    if (_response.okAndContainsData) {
      _randomData = WikiQueryResultModel.fromJson(_response.data);

      print(_randomData!.pages![0].title);
      apiStatus = ApiStatus.completed;
      notifyListeners();
    } else {}
  }
}
