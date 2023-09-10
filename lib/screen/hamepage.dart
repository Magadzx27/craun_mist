import 'dart:convert';
import 'package:craun_mist/screen/SettingPage.dart';
import 'package:craun_mist/screen/TempScreen.dart';
import 'package:craun_mist/screen/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'loginpage.dart';
import 'registrationpage.dart';
import 'dart:core';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return const AuthenticationWrapper();
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key, Key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool isAuthenticated = false;
  int notificationCount = 0; // Initialize notification count
  int _selectedIndex = 0;

  Timer? notificationTimer;
  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
    notificationTimer = Timer.periodic(Duration(minutes: 30), (timer) {
      if (isTemperatureAbove20(temp1Data) ||
          isTemperatureAbove20(temp2Data) ||
          isTemperatureAbove20(temp3Data) ||
          isTemperatureAbove20(temp4Data)) {
        showTemperatureNotification();
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    notificationTimer?.cancel();
    super.dispose();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications(BuildContext context) async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Replace with your app's icon

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // No need for onSelectNotification in newer versions
      onDidReceiveNotificationResponse: (payload) async {
        // Handle the notification tap here
        if (payload != null) {
          // Do something when the notification is tapped
        }
      },
    );
  }

  Future<void> showTemperatureNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'you_can_name_it_whatever',
      'flutterfcm',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('mix'),
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    if (isTemperatureAbove20(temp1Data)) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Temperature Alert!',
        'Temperature is above 30°C',
        platformChannelSpecifics,
        payload: 'TemperatureAlert',
      );
      setState(() {
        notificationCount++;
      });
    }
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> temp1Data = [];
  List<Map<String, dynamic>> temp2Data = [];
  List<Map<String, dynamic>> humi1Data = [];
  List<Map<String, dynamic>> humi2Data = [];
  List<Map<String, dynamic>> temp3Data = [];
  List<Map<String, dynamic>> temp4Data = [];
  List<Map<String, dynamic>> humi3Data = [];
  List<Map<String, dynamic>> humi4Data = [];

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
      showTemperatureNotification();
      // Check for temperature and send a notification
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
      showTemperatureNotification();
      // Check for temperature and send a notification
    }
  }

  bool isTemperatureAbove20(List<Map<String, dynamic>> data) {
    for (var dataPoint in data.take(2)) {
      final dynamic temperatureValue = dataPoint['DATA'];
      print(temperatureValue);
      if (temperatureValue != null) {
        final double temperature = double.parse(temperatureValue);
        print(temperature);
        if (temperature > 20.0) {
          return true; // At least one of the last two temperatures is above 20°C
        }
      }
    }

    return false; // None of the last two temperatures is above 20°C
  }

  @override
  Widget build(BuildContext context) {
    initializeNotifications(context);
    final List<Widget> _screens = [
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ),
              );
            },
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
