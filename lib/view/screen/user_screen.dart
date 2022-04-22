import 'package:dot_mobile_test/model/user.dart';
import 'package:dot_mobile_test/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/apis/api_response.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<UserViewModel>(context, listen: false).getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<UserViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: _body(apiResponse),
    );
  }

  Widget _body(ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        Data? data = apiResponse.data as Data?;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data!.avatar!),
                      ),
                    ),
                    Container(height: 15),
                    Text(data.username!, style: const TextStyle(fontSize: 20)),
                    Container(height: 5),
                    Text(data.fullname!, style: const TextStyle(fontSize: 15)),
                    Container(height: 5),
                    Text(data.email!, style: const TextStyle(fontSize: 15)),
                    Container(height: 5),
                    Text(data.phone!, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        );
      case Status.ERROR:
        return Center(
          child: Text(apiResponse.message ?? 'Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('initial state'),
        );
    }
  }
}
