import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:littlemomo/admin/admin_dashboard.dart';
import 'package:littlemomo/admin/login.dart';
import 'package:littlemomo/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Momo',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 4,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
