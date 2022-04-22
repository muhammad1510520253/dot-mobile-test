import 'package:dot_mobile_test/model/gallery.dart';
import 'package:dot_mobile_test/model/place.dart';
import 'package:flutter/material.dart';

import 'stacked_images.dart';

class ItemGallery extends StatelessWidget {
  final Gallery item;

  const ItemGallery({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                item.image ?? '',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                item.caption ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              )),
        ),
      ],
    );
  }
}
