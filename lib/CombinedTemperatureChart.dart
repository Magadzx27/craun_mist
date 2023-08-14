import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fl_chart/fl_chart.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class CombinedTemperatureChart extends StatelessWidget {
  final List<Map<String, dynamic>> temp1Data;
  final List<Map<String, dynamic>> temp2Data;
  final List<Map<String, dynamic>> humi2Data;
  final List<Map<String, dynamic>> humi1Data;
  final List<Color> colors;
  final String heading;
  final String chamberNumber;
  final String legend1;
  final String legend2;
  final String legend3;
  final String legend4;

  const CombinedTemperatureChart({
    Key? key,
    required this.temp1Data,
    required this.temp2Data,
    required this.humi1Data,
    required this.humi2Data,
    required this.colors,
    required this.heading,
    required this.chamberNumber,
    required this.legend1,
    required this.legend2,
    required this.legend3,
    required this.legend4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> allTimestamps = [];
    allTimestamps.addAll(temp1Data.map((data) => DateTime.parse(data['TS'])));
    allTimestamps.addAll(temp2Data.map((data) => DateTime.parse(data['TS'])));
    allTimestamps.addAll(humi1Data.map((data) => DateTime.parse(data['TS'])));
    allTimestamps.addAll(humi2Data.map((data) => DateTime.parse(data['TS'])));
    allTimestamps.sort();

    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shadowColor: Colors.black,
            color: const Color.fromARGB(255, 243, 243, 243),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        heading,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 217, 243, 243),
                          borderRadius: BorderRadius.circular(10.0), // Round corners
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 156, 143)
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                              const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          currentDate,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildLegendRow(Colors.blue, legend1),
                      _buildLegendRow(Colors.green, legend2)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildLegendRow(
                          const Color.fromARGB(255, 20, 44, 21), legend3),
                      _buildLegendRow(
                          const Color.fromARGB(255, 23, 124, 26), legend4),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 400,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: allTimestamps.length.toDouble() - 1,
                        minY: 0,
                        maxY: 100,
                        backgroundColor:
                        const Color.fromARGB(255, 222, 247, 213),
                        titlesData: FlTitlesData(
                          topTitles: SideTitles(showTitles: false),
                          rightTitles: SideTitles(
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              );
                            },
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < allTimestamps.length) {
                                DateTime timestamp = allTimestamps[index];
                                return DateFormat.jm().format(timestamp);
                              }
                              return '';
                            },
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                                color: Colors.black,
                              );
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) {
                              int index = value.toInt();
                              if (index < temp1Data.length && index >= 0) {
                                String dataValue = temp1Data[index]
                                ['DATA']; // Use your API data here
                                return dataValue;
                              }
                              return '';
                            },
                            margin: 20,
                            reservedSize: 50,
                            interval: 10,
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              );
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        gridData: FlGridData(
                          show: true,
                        ),
                        lineBarsData: [
                          _buildLineChartData(temp1Data, Colors.blue),
                          _buildLineChartData(temp2Data, Colors.green),
                          _buildLineChartData(humi1Data,
                              const Color.fromARGB(255, 20, 44, 21)),
                          _buildLineChartData(humi2Data,
                              const Color.fromARGB(255, 23, 124, 26)),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.blue,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots
                                  .map((LineBarSpot touchedSpot) {
                                int index = touchedSpot.spotIndex;

                                if (index >= 0 && index < temp1Data.length) {
                                  String temp1 =
                                      '${temp1Data[index]['DATA']}°C\n${temp1Data[index]['TS']}';
                                  String temp2 =
                                      '${temp2Data[index]['DATA']}°C\n${temp2Data[index]['TS']}';

                                  String humi1 =
                                      '${humi1Data[index]['DATA']}%RH\n${humi1Data[index]['TS']}';
                                  String humi2 =
                                      '${humi2Data[index]['DATA']}%RH\n${humi2Data[index]['TS']}';

                                  String allInfo =
                                      '$temp1\n$temp2\n$humi1\n$humi2';
                                  return LineTooltipItem(allInfo,
                                      const TextStyle(color: Colors.white));
                                } else {
                                  return LineTooltipItem('',
                                      const TextStyle(color: Colors.white));
                                }
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black45),
          const Row(
            children: [
              Column(
                children: [
                  Text(
                    'DOWNLOAD AS PDF',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'DOWNLOAD AS CSV',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String label) {
    return Row(
      children: [
        _buildLegendDot(color),
        const SizedBox(width: 8),
        _buildLegendText(label),
        const SizedBox(width: 20),
      ],
    );
  }

  LineChartBarData _buildLineChartData(
      List<Map<String, dynamic>> data, Color color) {
    return LineChartBarData(
      spots: _createSpots(data),
      isCurved: true,
      colors: [color],
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  List<FlSpot> _createSpots(List<Map<String, dynamic>> data) {
    List<FlSpot> spots = [];
    double xInterval = (temp1Data.length - 1) / (data.length - 1);

    // Adjust this value to add space between spots
    double spaceBetweenSpots = 1.7; // Change this value as needed

    for (var i = 0; i < data.length; i++) {
      double x = xInterval * i + spaceBetweenSpots * i;
      double y = double.parse(data[i]['DATA']);
      spots.add(FlSpot(x, y));
    }
    return spots;
  }

  Widget _buildLegendDot(Color color) {
    return Container(
      width: 40,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
      ),
    );
  }

  Widget _buildLegendText(String label) {
    return Text(
      label,
      style: const TextStyle(color: Colors.black),
    );
  }
}
