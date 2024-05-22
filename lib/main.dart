import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projekmobile/bottom_navbar.dart';
import 'package:projekmobile/login_page.dart';
import 'models/shared_preference.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initiateLocalDB();
  SharedPreference().getLoginStatus().then((status) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            fontFamily: 'Poppins',
          // primaryColor: Colors.black26,
          primarySwatch: Colors.blue,
        ),
        home: status ? Nav() : LoginPage()
    ));
  });
  // runApp(const MyApp());
}



void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  await Hive.openBox<DataModel>("data");
}
