import 'package:flutter/material.dart';
import 'package:filo/Styles/Color.dart';
import 'package:filo/Styles/CustomTextStyle.dart';
import 'package:filo/Views/Resturant/MenuView.dart';
import 'package:filo/Views/Resturant/PlaceDetailsView.dart';
import 'package:filo/Views/Resturant/PlaceReviewView.dart';
import 'package:filo/Widgets/CustomOutlineButton.dart';
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

Firestore fireStore = Firestore.instance;

class ResturantDetail extends StatefulWidget{

  const ResturantDetail({
    @required this.documents,
    @required this.index,
    @required this.image,
    @required this.title,
  });

  final DocumentSnapshot documents;
  final int index;
  final String image;
  final String title;



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResturantDetailState(documents: documents);
  }
}

class ResturantDetailState extends State<ResturantDetail> with SingleTickerProviderStateMixin{
  ResturantDetailState({this.documents});
  TabController tabController;
  final DocumentSnapshot documents;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3,vsync: this,initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: primaryColor,
          actions: <Widget>[
            InkResponse(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height/3.5,
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                child: Hero(
                  tag: widget.index,
                  child: Image.network(widget.image),
                )
            ),
            CustomOutlineButton(
              onPressed: (){
                showDialog(
                context: context,
                barrierDismissible: true, // set to false if you want to force a rating
                builder: (context) {
                  return RatingDialog(
                    icon: Image(
                    image: new AssetImage('pictures/images/logo.png')),
                    title: "Califica el Restaurante",
                    description:
                    "Seleciona la puntuacion que le das al Restaurante",
                    submitButton: "SUBMIT",
                    positiveComment: "Una chimba :)",
                    negativeComment: "Necesito a ublime :(",
                    accentColor: Colors.red,
                    onSubmitPressed: (int rating) {
                      _addReview(documents, rating);
                    print("onSubmitPressed: rating = $rating");
                    },
                  );
                }
                );
                },
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
              textStyle: resturantListButton().copyWith(fontSize: 16.0),
              highlightColor: primaryColor,
              borderColor: primaryColor,
              text: "Agregar Review",
            ),
            Expanded(
              child: DetailTabView(
                tabController: tabController,
              documents: widget.documents,),
            )
          ],
        )
    );
  }

  _addReview(DocumentSnapshot documents, int rating) async {
    return fireStore.collection('restaurant').document(documents.documentID).collection('reviews').add({'review':rating});

  }
}

class DetailTabView extends StatelessWidget{
  TabController tabController;

  DetailTabView({this.tabController, this.documents});

  final DocumentSnapshot documents;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          child: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide.none
            ),
            labelStyle: TextStyle(color: primaryColor),
            unselectedLabelColor: greyColor,
            labelColor: primaryColor,
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(toUpper("Food menu"),style: detailsTabTitle(),),
              ),
              Tab(
                child: Text(toUpper("Place detail"),style: detailsTabTitle(),),
              ),
              Tab(
                child: Text(toUpper("Place review"),style: detailsTabTitle(),),
              )
            ],
          ),
          color: Colors.white,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              MenuView(price:documents["price"]),
              PlaceDetailView(documents:documents),
              PlaceReviewView(documents:documents)
            ],
          ),
        )
      ],
    );
  }
}