// ignore: file_names
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    // Set the initial value of the text field to the widget's value.
    _textEditingController.text = widget.value.toString();
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
                          // This bool value toggles the switch.
                          value: widget.enable,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
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
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(const Size(80, 40)),
                          child: TextFormField(
                            controller: _textEditingController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
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
                                        onPressed: () {
                                          setState(() {
                                            widget.value = double.parse(
                                                _textEditingController.text);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 10.0,
                          ),
                          label: const Text('Edit'), // <-- Text
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Last Update : 2023-09-09 13:29:28',
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

  @override
  void initState() {
    super.initState();
    // Set the initial value of the text field to the widget's value.
    _textEditingController.text = widget.value.toString();
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
                          // This bool value toggles the switch.
                          value: widget.enable,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
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
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(const Size(80, 40)),
                          child: TextFormField(
                            controller: _textEditingController,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
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
                                        onPressed: () {
                                          setState(() {
                                            widget.value = double.parse(
                                                _textEditingController.text);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 10.0,
                          ),
                          label: const Text('Edit'), // <-- Text
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Last Update : 2023-09-09 13:29:28',
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
