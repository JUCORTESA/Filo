import 'package:flutter/material.dart';
import 'package:filo/Styles/Color.dart';
import 'package:filo/Styles/CustomTextStyle.dart';
import 'package:filo/Views/Resturant/ResturantDetail.dart';
import 'package:filo/Widgets/CustomOutlineButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


String image = 'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

class ResturantListView extends StatelessWidget{
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
                    MaterialPageRoute(builder: (context) => ResturantDetail(index: index,image: image,title: "Title From",),
                    ),
                );
              },
              child: ResturantListItem(width: width,height: height,index: index,),
            );
          },
          separatorBuilder: (context,index){
            return Container();
          },
          itemCount: 10,
        );
      },
    );
  }
}

class TextSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> _restaurants;

    _restaurants = Firestore.instance
        .collection('restaurant')
        .orderBy('name')
        .snapshots();


//    StreamBuilder(
//        stream: Firestore.instance.collection('{your_collection_name}').snapshots(),
//    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//    if (!snapshot.hasData) return CircularProgressIndicator();
//    return ListView.builder(
//    itemCount: snapshot.data.documents.length,
//    itemBuilder: (BuildContext context, int index) {
//    return new Card(
//    child: new Column(
//    children: <Widget>[
//    new Text(snapshot.data.documents[index].title),
//    new Text(snapshot.data.documents[index].content)
//    ],

    // TODO: implement build
    return Row(
      children: <Widget>[
        Expanded(
          child:
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Burger cafe",style: resturantListTitleText(),),
                Text("Hamburger",style: resturantListSubTitleText()),
          ],
            ),
          ),
        ),
        Container(
          child: CustomOutlineButton(
          onPressed: (){
          },
          textStyle: resturantListButton(),
          highlightColor: primaryColor,
          borderColor: primaryColor,
          text: "Ready in 20Min",
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
  ResturantListItem({this.width,this.height,this.index});

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
          TextSection()
        ],
      ),
    );
  }
}