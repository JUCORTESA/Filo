import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filo/Views/Resturant/ResturantList.dart';
import 'package:filo/Views/Home/Home.dart';
import 'package:filo/Styles/Color.dart';
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
/////

Location location = new Location();
LocationData _locationData;
final _formKey = GlobalKey<FormState>();
final myName = TextEditingController();
final myPrice = TextEditingController();
final myDescription = TextEditingController();

Firestore fireStore = Firestore.instance;
Geoflutterfire geo = Geoflutterfire();

class Welcome extends StatelessWidget {
  FirebaseUser user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Welcome({this.user});

  logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Lo más cerca"),
        backgroundColor: primaryColor,
        actions: <Widget>[
          InkResponse(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: myName,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Nombre Restaurante',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: myPrice,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Precio del corrientazo',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: myDescription,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Descripcion del sitio',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            color: Colors.blue,
                                            child: Text("Agregar Restaurante"),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                _addMarker();;
                                                // cerrar ventana
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ]
                )
            ),
          )
        ],
      ),
      drawer: drawer(),
      body: ResturantList(),
    );
  }


  Drawer drawer() {
    return Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text("Fi-Lo",
                  style: TextStyle(color: primaryColor, fontSize: 30.0),),
              ),
              drawerMenu(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Bogotá, Colombia", style: TextStyle(
                          fontSize: titleText, color: secondryColor),),
                      SizedBox(height: 5.0,),
                      Text("Change", style: TextStyle(
                          color: primaryColor, fontSize: normalText),),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget drawerMenu() {
    return Column(
      children: <Widget>[
        drawerList(active: true, icon: Icons.home, name: "Home", id: "HOME"),
        drawerList(active: false,
            icon: Icons.notifications_none,
            name: "Offers",
            id: "OFFER"),
        drawerList(
            active: false, icon: Icons.person, name: "Profile", id: "PROFILE"),
        drawerList(active: false,
            icon: Icons.power_settings_new,
            name: "Log Out",
            id: "LOGOUT"),
      ],
    );
  }

  Widget drawerList({String name, IconData icon, bool active, String id}) {
    return InkWell(
      onTap: () {
        if (id == "LOGOUT") {
          logout(_scaffoldKey.currentContext);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Icon(icon, color: active ? primaryColor : secondryColor,
              size: titleText,),
            SizedBox(width: 10.0,),
            Text(name, style: TextStyle(
                color: active ? primaryColor : secondryColor,
                fontSize: titleText),)
          ],
        ),
      ),
    );
  }

  _addMarker() async {
    _locationData = await location.getLocation();

    GeoFirePoint point = geo.point(
        latitude: _locationData.latitude, longitude: _locationData.longitude);


    return fireStore.collection('restaurant').add({
      'location': point.geoPoint,
      'name': myName.text,
      'price': myPrice.text,
      'description': myDescription.text,
    });

  }

}
