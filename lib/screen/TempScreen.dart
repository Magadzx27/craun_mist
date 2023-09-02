import 'package:craun_mist/reusable_card.dart';
import 'package:flutter/material.dart';

import '../CombinedTemperatureChart.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({
    Key? key,
    required this.temp1Data,
    required this.temp2Data,
    required this.humi1Data,
    required this.humi2Data,
    required this.temp3Data,
    required this.temp4Data,
    required this.humi3Data,
    required this.humi4Data,
  }) : super(key: key);

  final List<Map<String, dynamic>> temp1Data;
  final List<Map<String, dynamic>> temp2Data;
  final List<Map<String, dynamic>> humi1Data;
  final List<Map<String, dynamic>> humi2Data;
  final List<Map<String, dynamic>> temp3Data;
  final List<Map<String, dynamic>> temp4Data;
  final List<Map<String, dynamic>> humi3Data;
  final List<Map<String, dynamic>> humi4Data;

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  List<Map<String, dynamic>> limitChartData(
    List<Map<String, dynamic>> data,
    int limit,
  ) {
    if (data.length <= limit) {
      return data;
    }
    return data.sublist(data.length - limit);
  }

  Widget _buildCombinedTemperatureChart(
    List<Map<String, dynamic>> tempData1,
    List<Map<String, dynamic>> tempData2,
    List<Map<String, dynamic>> humiData1,
    List<Map<String, dynamic>> humiData2,
    String heading,
    String chamberNumber,
    String legend1,
    String legend2,
    String legend3,
    String legend4,
    List<Color> colors,
  ) {
    if (tempData1.isNotEmpty &&
        tempData2.isNotEmpty &&
        humiData1.isNotEmpty &&
        humiData2.isNotEmpty) {
      return CombinedTemperatureChart(
        temp1Data: tempData1,
        temp2Data: tempData2,
        humi1Data: humiData1,
        humi2Data: humiData2,
        heading: heading,
        chamberNumber: chamberNumber,
        legend1: legend1,
        legend2: legend2,
        legend3: legend3,
        legend4: legend4,
        colors: colors,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widgets for showing temperature and humidity cards
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
              temp: widget.temp1Data.length > 3
                  ? 'Temperature: ${widget.temp1Data[3]['DATA']}°c'
                  : 'Temperature: N/A',
              humidity: widget.humi1Data.length > 3
                  ? 'Humidity: ${widget.humi1Data[3]['DATA']}%'
                  : 'Humidity: N/A',
            ),
            ReusableCard(
              chamber: 'Chamber 2',
              temp: widget.temp2Data.length > 3
                  ? 'Temperature: ${widget.temp2Data[3]['DATA']}°c'
                  : 'Temperature: N/A',
              humidity: widget.humi2Data.length > 3
                  ? 'Humidity: ${widget.humi2Data[3]['DATA']}%'
                  : 'Humidity: N/A',
            ),
            ReusableCard(
              chamber: 'Chamber 3',
              temp: widget.temp3Data.length > 3
                  ? 'Temperature: ${widget.temp3Data[3]['DATA']}°c'
                  : 'Temperature: N/A',
              humidity: widget.humi3Data.length > 3
                  ? 'Humidity: ${widget.humi3Data[3]['DATA']}%'
                  : 'Humidity: N/A',
            ),
            ReusableCard(
              chamber: 'Chamber 4',
              temp: widget.temp4Data.length > 3
                  ? 'Temperature: ${widget.temp4Data[3]['DATA']}°c'
                  : 'Temperature: N/A',
              humidity: widget.humi4Data.length > 3
                  ? 'Humidity: ${widget.humi4Data[3]['DATA']}%'
                  : 'Humidity: N/A',
            ),
          ],
        ),
        _buildCombinedTemperatureChart(
          limitChartData(widget.temp1Data, 150),
          limitChartData(widget.temp2Data, 150),
          limitChartData(widget.humi1Data, 150),
          limitChartData(widget.humi2Data, 150),
          'Chamber 1 & 2',
          'Chamber 1 & 2',
          'Temperature 1',
          'Temperature 2',
          'Humidity 1',
          'Humidity 2',
          [Colors.orange, Colors.purple],
        ),
        _buildCombinedTemperatureChart(
          limitChartData(widget.temp3Data, 300),
          limitChartData(widget.temp4Data, 300),
          limitChartData(widget.humi3Data, 300),
          limitChartData(widget.humi4Data, 300),
          'Chamber 3 & 4',
          'Chamber 3 & 4',
          'Temperature 3',
          'Temperature 4',
          'Humidity 3',
          'Humidity 4',
          [Colors.blue, Colors.red],
        ),
      ],
    );
  }
}
