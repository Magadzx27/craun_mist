import 'package:craun_mist/ScheduleSetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  void _navigateToChamber(int chamberNumber) {
    // You can replace the following line with your navigation logic for each chamber.
    // For now, it just shows a snackbar with the chamber number.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigated to Chamber $chamberNumber'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 1),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _navigateToChamber(1);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Chamber 1',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToChamber(2);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Chamber 2',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToChamber(3);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Chamber 3',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToChamber(4);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Chamber 4',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
              ScheduleSetting(),
            ],
          ),
        ],
      ),
    );
  }
}
