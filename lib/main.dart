import 'package:flutter/material.dart';
import 'package:flutterapp7/home_page.dart';

void main() async{
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: HomePage(),
    );
  }
}

