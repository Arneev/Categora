import 'package:categora/helpers/toast.dart';
import 'package:categora/services/Database.dart';
import 'package:categora/services/Router.dart';
import 'package:categora/style.dart';
import 'package:categora/ui/categories/categories.view.dart';
import 'package:categora/ui/login/login.view.dart';
import 'package:categora/ui/registration/registration.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './helpers/log.dart';
import 'constants/route_name.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      onGenerateRoute: generateRoute,
      title: 'Categora',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Database.user == null) ? LoginView() : CategoriesView();
  }
}
