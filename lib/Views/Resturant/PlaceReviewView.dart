import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:filo/Widgets/CustomDivider.dart';
import 'package:filo/Widgets/CustomRatingBar.dart';
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



class PlaceReviewView extends StatefulWidget {
  PlaceReviewView({this.documents});
  final DocumentSnapshot documents;

  @override
  _Review createState()  =>  _Review() ;
}
class _Review extends State<PlaceReviewView> {
  Stream<QuerySnapshot> _reviews;
  Firestore fireStore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _reviews = Firestore.instance
        .collection('restaurant').document(widget.documents.documentID)
        .collection('reviews')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: StreamBuilder<QuerySnapshot>(
        stream: _reviews,
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
          ReviewF(
            reviews : snapshot.data.documents,
            documents: widget.documents,
          )
        ],

      );
    },
        ),
    );
  }
}
class ReviewF extends StatelessWidget {
  ReviewF({this.documents, this.reviews});
  final DocumentSnapshot documents;
  final List<DocumentSnapshot> reviews;

  @override
    Widget build(BuildContext context) {
    int sumatotal = 0;
    reviews.forEach((doc) => sumatotal += doc["review"]);
    double promedio = (sumatotal/reviews.length);
    // TODO: implement build
    return Container(
      child:  Column(
        children: <Widget>[
          CustomDivider(
            color: Colors.grey[200],
          ),
           Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(reviews.length.toString() + " reviews",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  CustomRatingBar(size: promedio,)
                ],
              ),
            ),
          ),
          CustomDivider(
            color: Colors.grey[200],
          ),
          Expanded(
            child: Container(
              child: PlaceReviewList(reviews: reviews),
            ),
          )
        ],
      ),
    );
  }
  _reviewsQ(String id) async {
      Firestore.instance
          .collection('restaurant').document(id).collection('reviews').snapshots();
  }
}

class PlaceReviewList extends StatelessWidget{
  PlaceReviewList({this.reviews});
  final List<DocumentSnapshot> reviews;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context,index){
          return PlaceReviewListItem(review: reviews[index]);
        },
        separatorBuilder: (context,index){
          return SizedBox(height: 20.0,);
        },
        itemCount: reviews.length,
    );
  }
}

class PlaceReviewListItem extends StatelessWidget{
  PlaceReviewListItem({this.review});
  final DocumentSnapshot review;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Container(

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                  child: Image.network("https://www.w3schools.com/howto/img_avatar.png"),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 40.0,
                width: 40.0,
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Anonymous",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                      Text("---------",style: TextStyle(fontSize: 13.0),)
                    ],
                  ),
                )
              ),
              CustomRatingBar(size: review["review"].toDouble(),)
            ],
          ),
          Text(_textIf(review["review"]),
            style: TextStyle(fontSize: 13),
            maxLines: 3,
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
  _textIf(int number){
    if (number == 1)
      return "I need a bath";
    if (number == 2)
      return "I need a bath";
    if (number == 3)
      return "Acceptable ";
    if (number == 4)
      return "Fine, but you can't repeat juice!";
    if (number == 5)
      return "Super recommended";
          
    
  }
}