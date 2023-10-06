// ignore: depend_on_referenced_packages
import 'package:craun_mist/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleSetting extends StatefulWidget {
  // final String name;
  // final String time;
  // final int duration;
  // final bool enable;
  const ScheduleSetting({
    super.key,
  });

  @override
  State<ScheduleSetting> createState() => _ScheduleSettingState();
}

class _ScheduleSettingState extends State<ScheduleSetting> {
  TextEditingController timeInput = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now(); // Initialize with the current time

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now(); // Initialize with the current time

    // Use Future.delayed to ensure this code runs after initState.
    Future.delayed(Duration.zero, () {
      updateTimeInputText();
    });
  }

  void updateTimeInputText() {
    if (selectedTime != null) {
      timeInput.text = selectedTime.format(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        updateTimeInputText();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1, 1, 20, 1),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(200, 1, 1, 1),
                            child: Switch(
                              // This bool value toggles the switch.
                              value: true,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                // setState(() {
                                //   widget.enable = value;
                                // });
                              },
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                                bottomLeft: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0)),
                          ),
                          labelText: 'Schedule Name',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 1, 1, 1),
                        child: Row(
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 190,
                            ),
                            Text(
                              'Duration',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: timeInput,
                              style: const TextStyle(color: Colors.black),
                              onTap: () {
                                _selectTime(context);
                              },
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                      bottomLeft: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                      bottomLeft: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(60, 30, 20, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text(
                                'Save',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 20, 10),
                            child: ElevatedButton(
                              child: const Text(
                                'Concal',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
