import 'package:dot_mobile_test/model/place.dart';
import 'package:dot_mobile_test/view_model/place_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/apis/api_response.dart';
import '../widget/item_place.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key? key}) : super(key: key);

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PlaceViewModel>(context, listen: false).getPlace();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<PlaceViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Place",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _body(apiResponse),
    );
  }

  Widget _body(ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        Data? data = apiResponse.data as Data?;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(50),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                          controller: _searchController,
                          onChanged: (value) {
                            Provider.of<PlaceViewModel>(context, listen: false)
                                .getPlaceSearch(value);
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                              hintText: 'Search...',
                              hintTextDirection: TextDirection.ltr)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: listItem(data)),
          ],
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

  Widget listItem(Data? place) {
    if (place != null && place.content != null) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: place.content!.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          Content content = place.content![index];
          return InkWell(
            onTap: () {},
            child: ItemPlace(
              content: content,
            ),
          );
        },
      );
    }
    return const Center(
      child: Text('No data'),
    );
  }
}
