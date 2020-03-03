import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:filo/Widgets/CustomDivider.dart';
import 'package:filo/Widgets/CustomRatingBar.dart';

class PlaceReviewView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                  Text("25 reviews",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  CustomRatingBar(size: 2.0,)
                ],
              ),
            ),
          ),
          CustomDivider(
            color: Colors.grey[200],
          ),
          Expanded(
            child: Container(
              child: PlaceReviewList(),
            ),
          )
        ],
      ),
    );
  }
}

class PlaceReviewList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context,index){
          return PlaceReviewListItem();
        },
        separatorBuilder: (context,index){
          return SizedBox(height: 20.0,);
        },
        itemCount: 10
    );
  }
}

class PlaceReviewListItem extends StatelessWidget{
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
                      Text("User name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                      Text("July 20th,2019",style: TextStyle(fontSize: 13.0),)
                    ],
                  ),
                )
              ),
              CustomRatingBar(size: 3,)
            ],
          ),
          Text("Sisas estuvo chimba el almuerzo",
            style: TextStyle(fontSize: 13),
            maxLines: 3,
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}