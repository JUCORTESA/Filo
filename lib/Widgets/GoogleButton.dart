import 'package:filo/Modal/GoogleAuthentication.dart';
import 'package:filo/Views/Home/Home.dart';
import 'package:filo/Views/Welcome/Welcome.dart';
import 'package:flutter/material.dart';


Widget signInButton() {
  return OutlineButton(
    splashColor: Colors.grey,

    onPressed: () {
        signInWithGoogle().whenComplete(() {
          runApp(MaterialApp(home: Welcome()));
      });
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("pictures/images/google_logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Log In with Google',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
