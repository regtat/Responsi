import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_page.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_kesehatan/helpers/user_info.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/login_page.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const DataNutrisiPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Kesehatan',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}