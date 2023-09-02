import 'dart:convert';
import 'package:craun_mist/screen/TempScreen.dart';
import 'package:craun_mist/screen/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'loginpage.dart';
import 'registrationpage.dart';

// ignore: camel_case_types
class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationWrapper();
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool isAuthenticated = false;
  int _selectedIndex = 0;

  List<Map<String, dynamic>> temp1Data = [];
  List<Map<String, dynamic>> temp2Data = [];
  List<Map<String, dynamic>> humi1Data = [];
  List<Map<String, dynamic>> humi2Data = [];
  List<Map<String, dynamic>> temp3Data = [];
  List<Map<String, dynamic>> temp4Data = [];
  List<Map<String, dynamic>> humi3Data = [];
  List<Map<String, dynamic>> humi4Data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
  }

  Future<void> fetchData() async {
    final urls = ['temp1', 'temp2', 'humi1', 'humi2'];
    final responses = await Future.wait(urls.map((url) => http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=$url&id=140000'))));

    final validResponses =
        responses.where((response) => response.statusCode == 200).toList();

    if (validResponses.length == responses.length) {
      setState(() {
        temp1Data = List.from(jsonDecode(validResponses[0].body));
        temp2Data = List.from(jsonDecode(validResponses[1].body));
        humi1Data = List.from(jsonDecode(validResponses[2].body));
        humi2Data = List.from(jsonDecode(validResponses[3].body));
      });
    }
  }

  Future<void> fetchData2() async {
    final urls = ['temp3', 'temp4', 'humi3', 'humi4'];
    final responses = await Future.wait(urls.map((url) => http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=$url&id=140000'))));

    final validResponses =
        responses.where((response) => response.statusCode == 200).toList();

    if (validResponses.length == responses.length) {
      setState(() {
        temp3Data = List.from(jsonDecode(validResponses[0].body));
        temp4Data = List.from(jsonDecode(validResponses[1].body));
        humi3Data = List.from(jsonDecode(validResponses[2].body));
        humi4Data = List.from(jsonDecode(validResponses[3].body));
      });
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isTemperatureAbove25() {
    for (var dataPoint in [
      ...temp1Data,
      ...temp2Data,
      ...temp3Data,
      ...temp4Data,
    ]) {
      final dynamic temperatureValue = dataPoint['DATA'];
      if (temperatureValue != null && temperatureValue is num) {
        final double temperature = temperatureValue.toDouble();
        if (temperature > 10) {
          return true; // At least one temperature is above 25°C
        }
      }
    }

    return false; // No temperature is above 25°C
  }

  @override
  Widget build(BuildContext context) {
    final List _screens = [
      TempScreen(
        temp1Data: temp1Data,
        temp2Data: temp2Data,
        humi1Data: humi1Data,
        humi2Data: humi2Data,
        temp3Data: temp3Data,
        temp4Data: temp4Data,
        humi3Data: humi3Data,
        humi4Data: humi4Data,
      ),

      LoginScreen(),
      const RegistrationScreen(),
      const profilePage(),
      // Add more screen widgets as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mist Chamber'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.orangeAccent,
        items: const <Widget>[
          Icon(Icons.home, color: Colors.lightBlueAccent),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.thumb_up_alt_outlined,
                color: Colors.lightBlueAccent),
          ),
          Icon(Icons.calendar_month_outlined, color: Colors.lightBlueAccent),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle_rounded,
                color: Colors.lightBlueAccent),
          ),
        ],
        index: _selectedIndex,
        onTap: _onNavItemTapped,
      ),
      body: _screens[_selectedIndex],
    );
  }
}
