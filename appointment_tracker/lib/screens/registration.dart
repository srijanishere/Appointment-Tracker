import 'package:appointment_tracker/screens/constants.dart';
import 'package:appointment_tracker/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              'You\'re almost there!',
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
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    setState(() {
                      _showSpinner = false;
                    });
                    // if (newUser != null) {
                    //   Navigator.pushNamed(context, LoginScreen.id);
                    // }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        insetPadding: EdgeInsets.symmetric(
                          vertical: 120.0,
                        ),
                        backgroundColor: Colors.purple[50],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: Center(
                          child: Text('You\'re all set!'),
                        ),
                        content: Column(
                          children: [
                            Lottie.asset(
                              'assets/loading_tick_purple.json',
                              width: 300.0,
                              height: 300.0,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Dashboard.id);
                            },
                            child: Text('Go to dashboard'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple[700]),
                            ),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      _showSpinner = false;
                    });
                    print(e);
                  }
                },
                style: kSignInButtonStyle,
                child: _showSpinner
                    ? kRoundProgressSpinnerWhite
                    : Text(
                        'REGISTER',
                        style: kSignInButtonTextStyle,
                      ),
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
