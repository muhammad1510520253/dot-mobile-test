import 'package:dot_mobile_test/view/screen/login_screen.dart';
import 'package:dot_mobile_test/view/screen/splash_screen.dart';
import 'package:dot_mobile_test/view_model/gallery_view_model.dart';
import 'package:dot_mobile_test/view_model/place_view_model.dart';
import 'package:dot_mobile_test/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/widget/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlaceViewModel()),
        ChangeNotifierProvider.value(value: GalleryViewModel()),
        ChangeNotifierProvider.value(value: UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Dot Mobile Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const BottomNavigation(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
