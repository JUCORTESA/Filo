import 'package:flutter/material.dart';
import 'package:filo/Styles/Color.dart';
import 'package:filo/Styles/CustomTextStyle.dart';
import 'package:filo/Views/Resturant/ResturantListMapView.dart';
import 'dart:ui' as ui;
import 'ResturantListView.dart';
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


class ResturantList extends StatefulWidget{

  final LatLng first = LatLng(4.653056, -74.055232);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResturantListState();
  }
}

class ResturantListState extends State<ResturantList> with TickerProviderStateMixin{


  int activeView = 0;
  EdgeInsets padding = EdgeInsets.symmetric(horizontal:10.0,vertical: 15.0);
  double fromBottom = 0;
  Animation animation;
  AnimationController animationController;
  Animation offset;
  TabController tabController;
  //////
  Stream<QuerySnapshot> _restaurants;
  final Completer<GoogleMapController> _mapController = Completer();
  Firestore fireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  ///////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restaurants = Firestore.instance
        .collection('restaurant')
        .orderBy('name')
        .snapshots();
    tabController = TabController(vsync: this,length: 2,initialIndex: 0);
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.0,end: 250.0)
                .animate(CurvedAnimation(parent: animationController,curve: Curves.ease));



    offset = Tween<Offset>(begin: Offset(0.0,1.0), end: Offset(0.0, 0.0))
        .animate(animationController);

    animation.addListener((){
      setState(() {
      });
    });
    offset.addListener((){
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _restaurants,
          builder: (context, snapshot)
    {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (!snapshot.hasData) {
        return Center(child: const Text('Loading...'));
      }
      return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                isScrollable: false,
                unselectedLabelColor: greyColor,
                labelColor: primaryColor,
                tabs: <Widget>[
                  Tab(
                    child: Text("Resturant List"),
                  ),
                  Tab(
                    child: Text("Resturant Map"),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    ResturantListView(
                      documents: snapshot.data.documents,
                      initialPosition: widget.first,
                      mapController: _mapController,
                    ),
                    ResturantMapView()
                  ],
                ),
              )

            ],
          ),
          getBlurWidget(),
          Positioned(
              bottom: animation.value,
              child: Align(
                alignment: Alignment.center,
                child: SafeArea(
                  bottom: (animation.value == 0) ? true : false,
                  minimum: EdgeInsets.only(bottom: 10.0),
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: () {
                            if (fromBottom == 100) {
                              animationController.reverse();
                              setState(() {
                                fromBottom = 0;
                              });
                            } else {
                              setState(() {
                                fromBottom = 100;
                              });
                              animationController.forward();
                            }
                          },
                          child: Icon(Icons.filter_list),
                        ),
                      )
                  ),
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
                position: offset,
                child: Container(
                  height: 250.0,
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Filters", style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors
                                .grey[200]))),
                      ),
                      Expanded(
                        child: Container(
                          child: Wrap(
                            children: <Widget>[
                              getFilterWidgetIcon(Icons.local_pizza),
                              getFilterWidgetIcon(Icons.local_pizza),
                              getFilterWidgetIcon(Icons.local_pizza),
                              getFilterWidgetIcon(Icons.local_pizza),
                              getFilterWidgetIcon(Icons.local_pizza),
                              getFilterWidgetIcon(Icons.local_pizza)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
          )
        ],

      );
      },
      ),
    );
  }

  ///
  /// Return Filter section icon UI
  ///
  getFilterWidgetIcon(IconData icon){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
      child: Icon(icon,size: 60.0,),
    );
  }
  ///
  /// Blur widget while open filter
  ///
  getBlurWidget(){
    return (animation.value > 0) ? GestureDetector(
      onTap: (){
        print("TAP OUT SIDE");
        animationController.reverse();
        setState(() {
          fromBottom = 0;
        });
      },
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ) : Container();
  }
}