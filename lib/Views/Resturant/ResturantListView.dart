import 'package:flutter/material.dart';
import 'package:filo/Styles/Color.dart';
import 'package:filo/Styles/CustomTextStyle.dart';
import 'package:filo/Views/Resturant/ResturantDetail.dart';
import 'package:filo/Widgets/CustomOutlineButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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



String image = 'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

class ResturantListView extends StatelessWidget{

  const ResturantListView({
    Key key,
    @required this.documents,
    @required this.initialPosition,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (context,constraint){

        double height = constraint.biggest.height;
        double width = constraint.biggest.width;
        return ListView.separated(
          key: PageStorageKey("list_data"),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResturantDetail(
                    index: index,
                    image: image,
                    title: documents[index]["name"],
                    documents: documents[index],
                  ),
                  ),
                );
              },
              child: ResturantListItem(
                width: width,
                height: height,
                index: index,
                documents: documents[index],
              ),
            );
          },
          separatorBuilder: (context,index){
            return Container();
          },
          itemCount: documents.length,
        );
      },
    );
  }
}

class TextSection extends StatelessWidget{

  const TextSection({
    @required this.documents,
  });

  final DocumentSnapshot documents;


  @override
  Widget build(BuildContext context) {

    print(documents["name"]);
    // TODO: implement build
    return Row(
      children: <Widget>[
        Expanded(
          child:
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(documents["name"],style: resturantListTitleText(),),
                Text(documents["address"],style: resturantListSubTitleText()),
              ],
            ),
          ),
        ),
        Container(
          child: CustomOutlineButton(
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
                        print("onSubmitPressed: rating = $rating");
                      },
                    );
                  }
              );
            },
            textStyle: resturantListButton(),
            highlightColor: primaryColor,
            borderColor: primaryColor,
            text: "Agregar Review",
          ),
        ),
      ],
    );
  }
}

class ResturantListItem extends StatelessWidget{

  double height;
  double width;
  int index;
  final DocumentSnapshot documents;

  ResturantListItem({this.width,this.height,this.index, this.documents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: height/3,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Hero(
                tag: index,
                child: Container(
                  width: width-20,
                  child: Image.network(image,fit: BoxFit.fitWidth,),
                ),
              )
          ),
          TextSection(
            documents: documents,
          )
        ],
      ),
    );
  }
}