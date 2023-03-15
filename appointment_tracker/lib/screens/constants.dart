import 'package:flutter/material.dart';

Container kRoundProgressSpinnerWhite = Container(
  width: 24.0,
  height: 24.0,
  padding: EdgeInsets.all(2.0),
  child: CircularProgressIndicator(
    color: Colors.white,
    strokeWidth: 3,
  ),
);

Container kRoundProgressSpinnerGreen = Container(
  width: 40.0,
  height: 40.0,
  padding: EdgeInsets.all(2.0),
  child: CircularProgressIndicator(
    color: Colors.purple[900],
    strokeWidth: 3,
  ),
);

ButtonStyle kSignInButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(5.0),
  fixedSize: MaterialStateProperty.all(Size(130, 30)),
  backgroundColor: MaterialStateProperty.all(Colors.purple[700]),
);

const kSignInButtonTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

const kTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kTextFieldEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.purple, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kTextFieldFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.purple, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kTextFieldHintStyle = TextStyle(
  color: Colors.purple,
  fontWeight: FontWeight.bold,
  fontSize: 12.0,
);

const kTextFieldLabelStyle = TextStyle(
  color: Colors.purple,
  fontWeight: FontWeight.bold,
);
