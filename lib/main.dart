import 'package:flutter/material.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/ui/home_screen.dart';
import 'package:get/get.dart';

import 'bindings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.homeScreen,
      getPages: _getPages(),
    );
  }


  _getPages() {
    return [
      GetPage(
          name: Routes.homeScreen, page: () =>  const HomeScreen(),binding: HomeBindings()),
    ];
  }
}
