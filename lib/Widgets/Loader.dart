import 'package:flutter/material.dart';

Widget LoaderWidget() {
  return Container(
    child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            strokeWidth: 3.0)),
    color: Colors.white54,
  );
}
