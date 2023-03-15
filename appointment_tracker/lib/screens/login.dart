import 'package:appointment_tracker/screens/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _showSpinner = false;
  bool _isPasswordHidden = true;

  void _checkValidEmail(String s) {
    bool check = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(s);
    if (check) {
      setState(() {
        _isValidEmail = true;
      });
    } else {
      _isValidEmail = false;
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Hero(
              tag: 'upper-bar',
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/Purple-2.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: isPotrait
                ? const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 35.0,
                  )
                : const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
            child: Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
          Icon(
            Icons.check_circle,
            color: Colors.lightGreen,
            size: 40.0,
          ),
          SizedBox(height: isPotrait ? 30.0 : 10.0),
          SizedBox(
            width: isPotrait ? 350.0 : 600.0,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              maxLines: null,
              cursorColor: Colors.purple,
              onChanged: (value) {
                email = value;
                setState(() {
                  _checkValidEmail(email);
                });
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                suffixIcon: _isValidEmail
                    ? Icon(Icons.check, color: Colors.green)
                    : Icon(Icons.check, color: Colors.grey[100]),
                hintText: 'EMAIL ID',
                hintStyle: kTextFieldHintStyle,
                label: Icon(
                  Icons.email_outlined,
                  color: Colors.purple,
                  size: 30.0,
                ),
                labelStyle: kTextFieldLabelStyle,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: kTextFieldBorder,
                enabledBorder: kTextFieldEnabledBorder,
                focusedBorder: kTextFieldFocusedBorder,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          SizedBox(
            width: isPotrait ? 350.0 : 600.0,
            child: TextField(
              cursorColor: Colors.purple,
              obscureText: _isPasswordHidden,
              onChanged: (value) {
                password = value;
                if (password.length == 6) {
                  setState(() {
                    _isValidPassword = true;
                  });
                } else if (password.length < 6) {
                  setState(() {
                    _isValidPassword = false;
                  });
                }
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_rounded,
                    color: Colors.purple,
                  ),
                ),
                hintText: 'PASSWORD',
                hintStyle: kTextFieldHintStyle,
                label: Icon(
                  Icons.lock,
                  color: Colors.purple,
                  size: 30.0,
                ),
                labelStyle: kTextFieldLabelStyle,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: kTextFieldBorder,
                enabledBorder: kTextFieldEnabledBorder,
                focusedBorder: kTextFieldFocusedBorder,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    final currentUser = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    setState(() {
                      _showSpinner = false;
                    });
                    if (currentUser != null) {
                      Navigator.pushNamed(context, Dashboard.id);
                    }
                  } catch (e) {
                    setState(() {
                      _showSpinner = false;
                    });
                    print(e);
                  }
                },
                child: _showSpinner
                    ? kRoundProgressSpinnerWhite
                    : Text(
                        'LOGIN',
                        style: kSignInButtonTextStyle,
                      ),
                style: kSignInButtonStyle,
              ),
              SizedBox(
                width: 20.0,
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: kSignInButtonStyle,
                child: Text(
                  'CANCEL',
                  style: kSignInButtonTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
