import 'package:craun_mist/hamepage.dart';
import 'package:flutter/material.dart';
// import 'input_page.dart';

// ignore: prefer_const_constructors
void main() => runApp(mainPage());

// ignore: camel_case_types
class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.blueAccent,
              ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white))),
      home: homePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
