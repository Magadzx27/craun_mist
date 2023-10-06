// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ReusabSettingleCardTemp extends StatefulWidget {
  late String temp;
  late bool enable;
  late double value = 0.0;
  ReusabSettingleCardTemp({Key? key, required this.temp, required this.enable})
      : super(key: key);

  @override
  State<ReusabSettingleCardTemp> createState() =>
      _ReusabSettingleCardTempState();
}

class _ReusabSettingleCardTempState extends State<ReusabSettingleCardTemp> {
  final TextEditingController _textEditingController = TextEditingController();
  DateTime? lastUpdatedTimestamp;
  @override
  void initState() {
    super.initState();
    // Set the initial value of the text field to the widget's value.
    _loadSavedValue();
  }

  _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool savedEnable = prefs.getBool(widget.temp + '_enable') ??
        false; // Load the switch state
    double savedValue = prefs.getDouble(widget.temp) ?? 0.0;
    String? timestamp = prefs.getString(widget.temp + '_timestamp');

    DateTime? savedTimestamp;
    if (timestamp != null) {
      savedTimestamp = DateFormat.yMd().add_Hms().parse(timestamp);
    }
    setState(() {
      widget.value = savedValue;
      widget.enable = savedEnable; // Set the switch state
      _textEditingController.text = savedValue.toString();
      lastUpdatedTimestamp = savedTimestamp;
    });
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "Threshold",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    Switch(
                      value: widget.enable,
                      activeColor: Colors.red,
                      onChanged: (bool value) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool(widget.temp + '_enable',
                            value); // Save the new state
                        setState(() {
                          widget.enable = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.temp,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "Value: ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AbsorbPointer(
                      absorbing: !widget
                          .enable, // Disable interaction if widget.enable is false.
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(const Size(80, 40)),
                        child: TextFormField(
                          controller: _textEditingController,
                          style: TextStyle(
                            color: widget.enable
                                ? Colors.black
                                : Colors
                                    .grey, // Disable text color when widget.enable is false.
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: widget.enable
                                    ? Colors.black
                                    : Colors
                                        .grey, // Disable border color when widget.enable is false.
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: widget.enable
                                    ? Colors.black
                                    : Colors
                                        .grey, // Disable border color when widget.enable is false.
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: widget.enable
                          ? () async {
                              _textEditingController.text =
                                  widget.value.toString();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        "Edit Value",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      content: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        controller: _textEditingController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Save'),
                                          onPressed: () async {
                                            double newValue = double.parse(
                                                _textEditingController.text);
                                            setState(() {
                                              widget.value = newValue;
                                              lastUpdatedTimestamp =
                                                  DateTime.now();
                                            });

                                            // Save the updated value to SharedPreferences
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setDouble(
                                                widget.temp, newValue);
                                            prefs.setString(
                                                widget.temp + '_timestamp',
                                                DateFormat.yMd()
                                                    .add_Hms()
                                                    .format(DateTime.now()));

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          : null,
                      icon: const Icon(
                        Icons.edit,
                        size: 10.0,
                      ),
                      label: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Last Update :${DateFormat.yMd().add_Hms().format(lastUpdatedTimestamp ?? DateTime.now())}',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'Update By: Admin',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusabSettingleCardHumi extends StatefulWidget {
  late String humi;
  late bool enable;
  late double value = 0.0;
  ReusabSettingleCardHumi(
      {super.key, required this.humi, required this.enable});

  @override
  State<ReusabSettingleCardHumi> createState() =>
      _ReusabSettingleCardHumiState();
}

class _ReusabSettingleCardHumiState extends State<ReusabSettingleCardHumi> {
  final TextEditingController _textEditingController = TextEditingController();
  DateTime? lastUpdatedTimestamp;
  @override
  void initState() {
    super.initState();
    // Set the initial value of the text field to the widget's value.
    _loadSavedValue();
  }

  _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedValue = prefs.getDouble(widget.humi) ?? 0.0;
    String? timestamp = prefs.getString(widget.humi + '_timestamp');
    bool savedEnable = prefs.getBool(widget.humi + '_enable') ?? false;

    DateTime? savedTimestamp;
    if (timestamp != null) {
      savedTimestamp = DateFormat.yMd().add_Hms().parse(timestamp);
    }
    setState(() {
      widget.value = savedValue;
      widget.enable = savedEnable;
      _textEditingController.text = savedValue.toString();
      lastUpdatedTimestamp = savedTimestamp;
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Setting',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Text(
                          'Threshold',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Switch(
                          value: widget.enable,
                          activeColor: Colors.red,
                          onChanged: (bool value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool(widget.humi + '_enable',
                                value); // Save the new state
                            setState(() {
                              widget.enable = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.humi,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const Text(
                          'Value: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AbsorbPointer(
                          absorbing: !widget
                              .enable, // Disable interaction if widget.enable is false.
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tight(const Size(80, 40)),
                            child: TextFormField(
                              controller: _textEditingController,
                              style: TextStyle(
                                color: widget.enable
                                    ? Colors.black
                                    : Colors
                                        .grey, // Disable text color when widget.enable is false.
                                fontSize: 17,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.enable
                                        ? Colors.black
                                        : Colors
                                            .grey, // Disable border color when widget.enable is false.
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: widget.enable
                                        ? Colors.black
                                        : Colors
                                            .grey, // Disable border color when widget.enable is false.
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: widget.enable
                              ? () async {
                                  _textEditingController.text =
                                      widget.value.toString();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text(
                                            "Edit Value",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: TextFormField(
                                            style:
                                                TextStyle(color: Colors.black),
                                            controller: _textEditingController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Save'),
                                              onPressed: () async {
                                                double newValue = double.parse(
                                                    _textEditingController
                                                        .text);
                                                setState(() {
                                                  widget.value = newValue;
                                                });

                                                // Save the updated value to SharedPreferences
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setDouble(
                                                    widget.humi, newValue);

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              : null,
                          icon: const Icon(
                            Icons.edit,
                            size: 10.0,
                          ),
                          label: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Last Update :${DateFormat.yMd().add_Hms().format(lastUpdatedTimestamp ?? DateTime.now())}',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Update By: Admin',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
