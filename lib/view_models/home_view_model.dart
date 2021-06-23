import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wiki_search/models/global/response_data_model.dart';
import 'package:wiki_search/models/global/wiki/wiki_query_result_model.dart';
import 'package:wiki_search/services/network_check.dart';
import 'package:wiki_search/utils/api_helper.dart';
import 'package:wiki_search/utils/constants/api_constants.dart';
import 'package:wiki_search/utils/constants/app_constants.dart';
import 'package:wiki_search/widgets/edge_alert.dart';

class HomeViewModel with ChangeNotifier {
  ApiStatus randomApiStatus = ApiStatus.idle;
  ApiStatus searchedApiStatus = ApiStatus.idle;

  WikiQueryResultModel? searchedData;
  WikiQueryResultModel? randomData;

  TextEditingController searchBarTextFieldController = TextEditingController();

  getRandomWikiPages(BuildContext context) async {
    Uri _requestUri = Uri.parse(ApiConstants.SERVER_BASE_URL + ApiConstants.GET_RANDOM_PAGES);

    randomApiStatus = ApiStatus.loading;
    notifyListeners();

    ResponseData _response = await ApiHelper().getRequest(context, _requestUri, showLoader: true, showLog: true, responseName: "Random");

    if (_response.okAndContainsData) {
      randomData = WikiQueryResultModel.fromJson(_response.data);

      randomApiStatus = ApiStatus.completed;
      notifyListeners();
    } else {}
  }

  searchWikiPage(BuildContext context) async {
    var box = await Hive.openBox(AppConstants.HIVE_DB_NAME);
    if (validateSearchTextField(context)) {
      if (await NetworkCheck.check()) {
        Uri _requestUri = Uri.parse(ApiConstants.SERVER_BASE_URL + ApiConstants.SEARCH_TERM + searchBarTextFieldController.text.trim());

        searchedApiStatus = ApiStatus.loading;
        notifyListeners();

        ResponseData _response =
            await ApiHelper().getRequest(context, _requestUri, showLoader: true, showLog: true, responseName: "Random", showError: false);

        if (_response.okAndContainsData) {
          if (_response.data["query"] != null && _response.data["query"]["pages"] != null) {
            searchedData = WikiQueryResultModel.fromJson(_response.data);

            //caching search term with raw response
            box.put(searchBarTextFieldController.text.trim(), _response.rawResponseBody);
            searchedApiStatus = ApiStatus.completed;
            notifyListeners();
          } else {
            searchedData = null;
            searchedApiStatus = ApiStatus.noData;
            notifyListeners();
          }
        } else {
          EdgeAlert.show(context,
              title: 'Oops',
              description: "Something went wrong. Please try again",
              gravity: EdgeAlert.TOP,
              icon: Icons.error,
              backgroundColor: Colors.red);
        }
      } else {
        //checking if term is cached
        String? _cachedResponse = box.get(searchBarTextFieldController.text.trim());
        if (_cachedResponse != null) {
          EdgeAlert.show(context,
              title: 'Oops',
              description: "No working internet connection found. Showing cached data",
              gravity: EdgeAlert.TOP,
              icon: Icons.error,
              backgroundColor: Colors.grey);
          searchedData = WikiQueryResultModel.fromJson(jsonDecode(_cachedResponse));

          searchedApiStatus = ApiStatus.completed;
          notifyListeners();
        } else {
          EdgeAlert.show(context,
              title: 'Oops',
              description: "No working internet connection found. Since you searched this term first we haven't cached it yet",
              gravity: EdgeAlert.TOP,
              icon: Icons.error,
              duration: 5,
              backgroundColor: Colors.red);
          randomApiStatus = ApiStatus.noNetwork;
          notifyListeners();
        }
      }
    }
  }

  bool validateSearchTextField(BuildContext context) {
    if (searchBarTextFieldController.text.trim().isEmpty) {
      EdgeAlert.show(context,
          title: 'Oops', description: "Search term can't be blank", gravity: EdgeAlert.TOP, icon: Icons.error, backgroundColor: Colors.red);
      return false;
    }

    return true;
  }
}
