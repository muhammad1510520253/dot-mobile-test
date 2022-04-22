import 'package:dot_mobile_test/model/place.dart';
import 'package:dot_mobile_test/model/services/base_service.dart';
import 'package:flutter/cupertino.dart';

import '../model/apis/api_response.dart';

class PlaceViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching data');

  Data? _placeSearch;
  Data? _place;

  ApiResponse get response {
    return _apiResponse;
  }

  Data? get place {
    return _place;
  }

  Future<void> getPlace() async {
    try {
      PlaceModel? place =
          PlaceModel.fromJson(await BaseService().getResponse("place.json"));
      _place = place.data;
      _apiResponse = ApiResponse.completed(place.data);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> getPlaceSearch(String keyword) async {
    try {
      if (keyword.isNotEmpty) {
        _placeSearch = Data(content: []);
        for (Content content in _place?.content ?? []) {
          if (content.title!.toLowerCase().contains(keyword.toLowerCase())) {
            _placeSearch!.content!.add(content);
          }
        }
      }
      _apiResponse =
          ApiResponse.completed(keyword.isNotEmpty ? _placeSearch : _place);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
