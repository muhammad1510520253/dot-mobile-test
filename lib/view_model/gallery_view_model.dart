import 'package:dot_mobile_test/model/services/base_service.dart';
import 'package:dot_mobile_test/model/gallery.dart';
import '../model/apis/api_response.dart';
import 'package:flutter/cupertino.dart';
import '../model/gallery.dart';

class GalleryViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching data');

  List<Gallery>? _gallerySearch;
  List<Gallery>? _gallery;

  ApiResponse get response {
    return _apiResponse;
  }

  List<Gallery>? get gallery {
    return _gallery;
  }

  Future<void> getGallery() async {
    try {
      GalleryModel gallery = GalleryModel.fromJson(
          await BaseService().getResponse("gallery.json"));
      _gallery = gallery.data;
      _apiResponse = ApiResponse.completed(gallery.data);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> getGallerySearch(String keyword) async {
    try {
      if (keyword.isNotEmpty) {
        _gallerySearch = [];
        for (Gallery gallery in _gallery ?? []) {
          if (gallery.caption!.toLowerCase().contains(keyword.toLowerCase())) {
            _gallerySearch!.add(gallery);
          }
        }
      }
      _apiResponse =
          ApiResponse.completed(keyword.isNotEmpty ? _gallerySearch : _gallery);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
