import 'package:flutter/material.dart';
/////
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:permission/permission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_maps_webservice/places.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rating_dialog/rating_dialog.dart';
/////


class PlaceDetailView extends StatelessWidget{
  PlaceDetailView({this.documents});
  final DocumentSnapshot documents;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(documents['description']),
    );
  }
}