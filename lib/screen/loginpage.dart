import 'package:flutter/material.dart';
import 'package:craun_mist/rounded_button.dart';
import 'registrationpage.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  // final _auth = FirebaseAuth.instance;
  // late String email;
  // late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 48.0,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                ),

                labelText: 'Email',
                // The MaterialStateProperty's value is a text style that is orange
                // by default, but the theme's error color if the input decorator
                // is in its error state.
                labelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.blue;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  },
                ),
              ),
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                ),
                labelText: 'Password',
                // The MaterialStateProperty's value is a text style that is orange
                // by default, but the theme's error color if the input decorator
                // is in its error state.
                labelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.blue;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  },
                ),
              ),
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const SizedBox(
              height: 5,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'If you do not have account',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationScreen()));
                    },
                    child: const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
