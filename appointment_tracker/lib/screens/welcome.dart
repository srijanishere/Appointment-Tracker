import 'package:appointment_tracker/screens/intermediate.dart';
import 'package:appointment_tracker/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'constants.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = false;

  void _onSubmit() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(
      Duration(seconds: 2),
      () {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamed(context, IntermediateScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'upper-bar',
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Purple-2.jpeg'),
                  fit: BoxFit.cover,
                ),
                // color: Colors.purple,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: isPotrait
                ? const EdgeInsets.symmetric(
                    vertical: 60.0,
                    horizontal: 30.0,
                  )
                : const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 25.0,
                  ),
            child: Column(
              children: [
                Text(
                  'Keeping track of your appointments has never been easier!',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _isLoading ? null : _onSubmit();
                  },
                  icon: _isLoading
                      ? kRoundProgressSpinnerWhite
                      : const Icon(Icons.check),
                  label: Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
