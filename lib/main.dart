import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/screen/homescreen/view/home_screen.dart';

import 'screen/addscreen/add_screen.dart';
import 'screen/addscreen/update_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/add',
          page: () => AddScreen(),
        ),
        GetPage(
          name: '/update',
          page: () => UpdateScreen(),
        ),
      ],
    ),
  );
}
