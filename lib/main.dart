import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wiki_search/utils/constants/app_constants.dart';
import 'package:wiki_search/utils/constants/color_constants.dart';
import 'package:wiki_search/utils/navigation_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Locks orientation
  //Can be changed at runtime via same method.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  Hive.init(path + AppConstants.HIVE_DB_NAME);

  runApp(
    new MaterialApp(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        accentColor: ColorConstants.PRIMARY,
        accentColorBrightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => NavigationHelper.getHomeViewWithProvider(),
        // '/': (context) => MyApp(),
      },
    ),
  );
}
