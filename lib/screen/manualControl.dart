import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class ManualControlPage extends StatefulWidget {
  const ManualControlPage({super.key});

  @override
  State<ManualControlPage> createState() => _ManualControlPageState();
}

class LogEntry {
  String node;
  String action;
  String logTime;

  LogEntry(this.node, this.action, this.logTime);
}

class _ManualControlPageState extends State<ManualControlPage> {
  bool mainPump = true;
  bool valve1 = false;
  bool fan1 = false;
  bool valve2 = false;
  bool fan2 = false;
  bool valve3 = false;
  bool fan3 = false;
  bool valve4 = false;
  bool fan4 = false;
  List<LogEntry> historyLog = [];
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 20,
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
                            child: Text(
                              'Main Pump: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100, 20, 20, 20),
                            child: Switch(
                              // This bool value toggles the switch.
                              value: mainPump,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                setState(() {
                                  mainPump = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 20,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 20,
                            clipBehavior: Clip.hardEdge,
                            color: Colors.lightBlueAccent,
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Chamber 1 & 2 ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Valve 1:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(170, 1, 1, 1),
                                child: Switch(
                                  value: valve1,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleValve(1, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Fan 1:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(190, 1, 1, 1),
                                child: Switch(
                                  value: fan1,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleFan(1, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Valve 2:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(170, 1, 1, 1),
                                child: Switch(
                                  value: valve2,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleValve(2, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Fan 2:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(190, 1, 1, 1),
                                child: Switch(
                                  value: fan2,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleFan(2, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 20,
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 20,
                            clipBehavior: Clip.hardEdge,
                            color: Colors.lightBlueAccent,
                            child: const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Chamber 3 & 4 ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Valve 3:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(170, 1, 1, 1),
                                child: Switch(
                                  value: valve3,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleValve(3, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Fan 3:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(190, 1, 1, 1),
                                child: Switch(
                                  value: fan3,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleFan(3, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Valve 4:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(170, 1, 1, 1),
                                child: Switch(
                                  value: valve4,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleValve(4, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                child: Text(
                                  'Fan 4:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(190, 1, 1, 1),
                                child: Switch(
                                  value: fan4,
                                  activeColor: Colors.red,
                                  onChanged: (bool value) {
                                    toggleFan(4, value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
              child: SizedBox(
                width: double.infinity,
                child: Column(children: [
                  Text(
                    "Control History Log",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  border: const TableBorder(horizontalInside: BorderSide()),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Node',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Stuate',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Log Time',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  rows: historyLog.map((entry) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            entry.node,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(Text(
                          entry.action,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                          Text(
                            entry.logTime,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            entry.logTime,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  }).toList()),
            )
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
            //   child: Column(
            //     children: [
            //       const Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
            //             child: Text(
            //               'Node',
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
            //             child: Text(
            //               'Stuate',
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.all(8),
            //             child: Text(
            //               'Log Time',
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Colors.white,
            //         ),
            //         child: Column(
            //           children: historyLog.map((entry) {
            //             return Row(
            //               children: [
            //                 const SizedBox(
            //                   width: 10,
            //                 ),

            //                 Padding(
            //                   padding: const EdgeInsets.fromLTRB(5, 5, 1, 1),
            //                   child: Text(
            //                     entry.node,
            //                     style: const TextStyle(
            //                         color: Colors.black,
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.fromLTRB(5, 5, 1, 1),
            //                   child: Text(
            //                     entry.action,
            //                     style: const TextStyle(
            //                         color: Colors.black,
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.fromLTRB(5, 5, 1, 1),
            //                   child: Text(
            //                     entry.logTime,
            //                     style: const TextStyle(
            //                         color: Colors.black,
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //                 // const SizedBox(
            //                 //   width: 10,
            //                 // ),
            //                 // Text(
            //                 //   entry.logTime,
            //                 //   style: const TextStyle(
            //                 //       color: Colors.black,
            //                 //       fontSize: 10,
            //                 //       fontWeight: FontWeight.bold),
            //                 // ),
            //               ],
            //             );
            //           }).toList(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        )
      ],
    );
  }

  String calculateTimeDifference(List<Map<String, dynamic>> data) {
    if (data.isNotEmpty) {
      final lastDataTimestamp = DateTime.parse(data.first['TS']);
      final currentTime = DateTime.now();
      final difference = currentTime.difference(lastDataTimestamp);

      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    } else {
      return 'N/A';
    }
  }

  void logHistory(String node, String action, String logTime) {
    setState(() {
      historyLog.insert(0, LogEntry(node, action, logTime));
    });
  }

  void toggleValve(int valveNumber, bool value) {
    final nodeName = 'Valve $valveNumber';
    final status = value ? '--> on' : '--> off';
    final logTime = formatDateTime(DateTime.now());

    setState(() {
      switch (valveNumber) {
        case 1:
          valve1 = value;
          break;
        case 2:
          valve2 = value;
          break;
        case 3:
          valve3 = value;
          break;
        case 4:
          valve4 = value;
          break;
        default:
          // Handle other cases if needed
          break;
      }
      logHistory(nodeName, '$nodeName $status', logTime);
    });
  }

  void toggleFan(int fanNumber, bool value) {
    final nodeName = 'Fan $fanNumber';
    final status = value ? '--> on' : '--> off';
    final logTime = formatDateTime(DateTime.now());
    setState(() {
      switch (fanNumber) {
        case 1:
          fan1 = value;
        case 2:
          fan2 = value;
        case 3:
          fan3 = value;
        case 4:
          fan4 = value;
          break;
        default:
      }
      logHistory(nodeName, '$nodeName $status', logTime);
    });
  }
}
