import 'package:dot_mobile_test/view/screen/gallery_screen.dart';
import 'package:dot_mobile_test/view/screen/place_screen.dart';
import 'package:dot_mobile_test/view/screen/user_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> pages = [
    const PlaceScreen(),
    const GalleryScreen(),
    const UserScreen()
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => setPage(0),
                  icon: Icon(
                    Icons.add_location_rounded,
                    color: currentPageIndex == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => setPage(1),
                  icon: Icon(
                    Icons.apps_sharp,
                    color: currentPageIndex == 1
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => setPage(2),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: currentPageIndex == 2
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void setPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
}
