import 'package:dot_mobile_test/model/services/base_service.dart';
import 'package:dot_mobile_test/model/user.dart';
import 'package:flutter/cupertino.dart';

import '../model/apis/api_response.dart';
import '../model/user.dart';

class UserViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching data');

  Data? _user;

  ApiResponse get response {
    return _apiResponse;
  }

  Data? get user {
    return _user;
  }

  Future<void> getUser() async {
    try {
      UserModel user =
          UserModel.fromJson(await BaseService().getResponse("user.json"));
      _apiResponse = ApiResponse.completed(user.data);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
