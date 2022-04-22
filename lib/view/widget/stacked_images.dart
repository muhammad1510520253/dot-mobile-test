import 'dart:math';

import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;

  const PhotoGrid({required this.imageUrls, this.maxImages = 2, Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 50,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return Image.network(
            imageUrl,
            fit: BoxFit.cover,
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(imageUrl, fit: BoxFit.cover),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  child: Text(
                    '+' +
                        (widget.imageUrls.length - widget.maxImages).toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }
      } else {
        return Image.network(
          imageUrl,
          fit: BoxFit.cover,
        );
      }
    });
  }
}
