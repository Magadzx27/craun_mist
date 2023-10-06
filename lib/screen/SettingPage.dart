// ignore: file_names
import 'package:craun_mist/TemperatureHumiProvider.dart';
import 'package:craun_mist/reusableSetting_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => TemperatureHumiProvider(),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusabSettingleCardTemp(
                enable: true,
                temp: 'Temp1',
              ),
              ReusabSettingleCardHumi(
                enable: true,
                humi: 'Humi1',
              ),
              ReusabSettingleCardTemp(
                enable: true,
                temp: 'Temp2',
              ),
              ReusabSettingleCardHumi(
                enable: true,
                humi: 'Humi2',
              ),
              ReusabSettingleCardTemp(
                enable: true,
                temp: 'Temp3',
              ),
              ReusabSettingleCardHumi(
                enable: true,
                humi: 'Humi3',
              ),
              ReusabSettingleCardTemp(
                enable: true,
                temp: 'Temp4',
              ),
              ReusabSettingleCardHumi(
                enable: true,
                humi: 'Humi4',
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
