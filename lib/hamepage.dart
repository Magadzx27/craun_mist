import 'dart:convert';
import 'package:craun_mist/CombinedTemperatureChart.dart';
import 'package:craun_mist/loginpage.dart';
import 'package:craun_mist/registrationpage.dart';
import 'package:http/http.dart' as http;
import 'package:craun_mist/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class homePage extends StatefulWidget {
  const homePage({super.key,});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
    var response1 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=temp1&id=140000'));
    var response2 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=temp2&id=140000'));
    var response3 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=humi1&id=140000'));
    var response4 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=humi2&id=140000'));

    if (response1.statusCode == 200 &&
        response2.statusCode == 200 &&
        response3.statusCode == 200 &&
        response4.statusCode == 200) {
      setState(() {
        temp1Data = List.from(jsonDecode(response1.body));
        temp2Data = List.from(jsonDecode(response2.body));
        humi1Data = List.from(jsonDecode(response3.body));
        humi2Data = List.from(jsonDecode(response4.body));
      });
    }
  }

  Future<void> fetchData2() async {
    var response5 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=temp3&id=140000'));
    var response6 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=temp4&id=140000'));
    var response7 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=humi3&id=140000'));
    var response8 = await http.get(Uri.parse(
        'http://craun.ddns.net/pages/dataloggingraph.php?node=humi4&id=140000'));

    if (response5.statusCode == 200 &&
        response6.statusCode == 200 &&
        response7.statusCode == 200 &&
        response8.statusCode == 200) {
      setState(() {
        temp3Data = List.from(jsonDecode(response5.body));
        temp4Data = List.from(jsonDecode(response6.body));
        humi3Data = List.from(jsonDecode(response7.body));
        humi4Data = List.from(jsonDecode(response8.body));
      });
    }
  }
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    final List<Widget> _screens = [
      temp_screen(
          temp1Data: temp1Data,
          temp2Data: temp2Data,
          humi1Data: humi1Data,
          humi2Data: humi2Data,
          temp3Data: temp3Data,
          temp4Data: temp4Data,
          humi3Data: humi3Data,
          humi4Data: humi4Data),

      const Login(),
      const Registrration(),
      // const Screen4()

      // Add more screen widgets as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mist Chamber'),
      ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.orangeAccent,
          items: const <Widget>[
            Icon(Icons.home, color: Colors.blueAccent),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.thumb_up_alt_outlined, color: Colors.blueAccent),
            ),
            Icon(Icons.calendar_month_outlined, color: Colors.blueAccent),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle_rounded, color: Colors.blueAccent),
            ),
          ],
          index: _selectedIndex,
          onTap: _onNavItemTapped,
        ),
      body: _screens[_selectedIndex],
    );
  }
}

class temp_screen extends StatefulWidget {
  const temp_screen({
    super.key,
    required this.temp1Data,
    required this.temp2Data,
    required this.humi1Data,
    required this.humi2Data,
    required this.temp3Data,
    required this.temp4Data,
    required this.humi3Data,
    required this.humi4Data,
  });

  final List<Map<String, dynamic>> temp1Data;
  final List<Map<String, dynamic>> temp2Data;
  final List<Map<String, dynamic>> humi1Data;
  final List<Map<String, dynamic>> humi2Data;
  final List<Map<String, dynamic>> temp3Data;
  final List<Map<String, dynamic>> temp4Data;
  final List<Map<String, dynamic>> humi3Data;
  final List<Map<String, dynamic>> humi4Data;

  @override
  State<temp_screen> createState() => _temp_screenState();
}

class _temp_screenState extends State<temp_screen> {
  // double? temperature;

  // void temp_average() {
  //   print(widget.temp1Data);
  //   print("Calculating average temperature...");
  //   if (widget.temp1Data.isNotEmpty) {
  //     double totalTemperature = 0.0;
  //     for (int i = 1; i < widget.temp1Data.length; i++) {
  //       totalTemperature += widget.temp1Data[i]['DATA'];
  //     }
  //     temperature = totalTemperature / widget.temp1Data.length;
  //     print("Average temperature calculated: $temperature");
  //     setState(() {}); // Update the UI after calculating the average
  //   } else {
  //     print('no data');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // temp_average();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Last Updated 1 seconds ago',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
          ReusableCard(
            chamber: 'Chamber 1',
            temp: 'Temperature: ${widget.temp1Data[3]['DATA']}°c',
            humidity: 'Humidity: ${widget.humi1Data[3]['DATA']}%',
          ),
          ReusableCard(
              chamber: 'Chamber 2',
              temp: 'Temperature: ${widget.temp2Data[3]['DATA']}°c',
              humidity: 'Humidity: ${widget.humi2Data[3]['DATA']}%'
          ),
          ReusableCard(
              chamber: 'Chamber 3',
              temp: 'Temperature: ${widget.temp3Data[3]['DATA']}°c',
              humidity: 'Humidity: ${widget.humi3Data[3]['DATA']}%'
          ),
          ReusableCard(
              chamber: 'Chamber 4',
              temp: 'Temperature: ${widget.temp4Data[3]['DATA']}°c',
              humidity: 'Humidity: ${widget.humi4Data[3]['DATA']}%'
          ),
          widget.temp1Data.isNotEmpty &&
              widget.temp2Data.isNotEmpty &&
              widget.humi1Data.isNotEmpty &&
              widget.humi2Data.isNotEmpty
              ? CombinedTemperatureChart(
            temp1Data: widget.temp1Data,
            temp2Data: widget.temp2Data,
            humi1Data: widget.humi1Data,
            humi2Data: widget.humi2Data,
            heading: 'Chamber 1 & 2',
            chamberNumber: 'Chamber 1 & 2',
            legend1: 'Temperature 1',
            legend2: 'Temperature 2',
            legend3: 'Humidity 1',
            legend4: 'Humidity 2',
            colors: const [
              Colors.orange,
              Colors.purple,
            ],
          )              : const Center(
            child: CircularProgressIndicator(),
      ),
          widget.temp3Data.isNotEmpty &&
              widget.temp4Data.isNotEmpty &&
              widget.humi3Data.isNotEmpty &&
              widget.humi4Data.isNotEmpty
              ? CombinedTemperatureChart(
            temp1Data: widget.temp3Data,
            temp2Data: widget.temp4Data,
            humi1Data: widget.humi3Data,
            humi2Data: widget.humi4Data,
            heading: 'Chamber 3 & 4',
            chamberNumber: 'Chamber 3 & 4',
            legend1: 'Temperature 3',
            legend2: 'Temperature 4',
            legend3: 'Humidity 3',
            legend4: 'Humidity 4',
            colors: const [
              Colors.orange,
              Colors.purple,
            ],
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
      ],

      ),
    );
  }
}
