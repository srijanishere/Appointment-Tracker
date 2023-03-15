import 'package:appointment_tracker/screens/login.dart';
import 'package:appointment_tracker/screens/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class IntermediateScreen extends StatefulWidget {
  static const String id = 'intermediate_screen';
  const IntermediateScreen({Key? key}) : super(key: key);

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  bool _isButtonActive1 = false;
  bool _isButtonActive2 = false;
  bool _isLoading = false;

  void _onSubmit(String route) {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(
      Duration(seconds: 1, milliseconds: 500),
      () {
        setState(() {
          _isLoading = false;
          _isButtonActive1 = false;
          _isButtonActive2 = false;
        });
        Navigator.pushNamed(context, route);
      },
    );
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
                      vertical: 30.0,
                    )
                  : const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    'Just a few more steps!',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: _isLoading
                          ? kRoundProgressSpinnerGreen
                          : Icon(
                              Icons.check_circle_rounded,
                              color: Colors.lightGreen,
                              size: 40,
                            )),
                ],
              )),
          Flexible(
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: isPotrait
                          ? const EdgeInsets.only(
                              left: 12, top: 40, right: 12, bottom: 60)
                          : const EdgeInsets.only(
                              left: 5, top: 20, right: 5, bottom: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/Purple-3.jpeg'),
                                fit: BoxFit.cover,
                              ),
                              // color: Color(0xFFe7cef2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CupertinoSwitch(
                                value: _isButtonActive1,
                                trackColor: Colors.grey[700],
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonActive1 = value;
                                    if (_isButtonActive1) {
                                      _isButtonActive2 = false;
                                    }
                                  });
                                  if (_isButtonActive1) {
                                    _isLoading
                                        ? null
                                        : _onSubmit(LoginScreen.id);
                                  }
                                },
                                activeColor: Colors.purple[900],
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: isPotrait
                          ? const EdgeInsets.only(
                              left: 12, top: 40, right: 12, bottom: 60)
                          : const EdgeInsets.only(
                              left: 5, top: 20, right: 5, bottom: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              // color: Color(0xFFe7cef2),
                              image: DecorationImage(
                                image: AssetImage('images/Purple-3.jpeg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGN UP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CupertinoSwitch(
                                value: _isButtonActive2,
                                trackColor: Colors.grey[700],
                                onChanged: (value) {
                                  setState(() {
                                    _isButtonActive2 = value;
                                    if (_isButtonActive2) {
                                      _isButtonActive1 = false;
                                    }
                                  });
                                  if (_isButtonActive2) {
                                    _isLoading
                                        ? null
                                        : _onSubmit(RegistrationScreen.id);
                                  }
                                },
                                activeColor: Colors.purple[900],
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              size: 30,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(110.0))),
              fixedSize: MaterialStateProperty.all(Size(120, 40)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            label: Text('Return'),
          ),
        ],
      ),
    );
  }
}
