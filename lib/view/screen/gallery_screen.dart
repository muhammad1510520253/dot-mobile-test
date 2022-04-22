import 'package:dot_mobile_test/model/gallery.dart';
import 'package:dot_mobile_test/view_model/gallery_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/apis/api_response.dart';
import '../widget/item_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<GalleryViewModel>(context, listen: false).getGallery();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<GalleryViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gallery",
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
        List<Gallery>? data = apiResponse.data as List<Gallery>?;
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
                            Provider.of<GalleryViewModel>(context,
                                    listen: false)
                                .getGallerySearch(value);
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
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(5), child: listItem(data)),
            ),
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

  Widget listItem(List<Gallery>? gallery) {
    if (gallery != null && gallery.isNotEmpty) {
      return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: gallery.length,
          itemBuilder: (BuildContext ctx, index) {
            Gallery item = gallery[index];
            return ItemGallery(item: item);
          });
    }
    return const Center(
      child: Text('No data'),
    );
  }
}
