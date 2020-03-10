import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:permission/permission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_maps_webservice/places.dart';
import 'dart:async';
import 'api_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
//
Location location = new Location();
LocationData _locationData;
//


//final _placesApiClient = GoogleMapsPlaces(apiKey: googleMapsApiKey);

class ResturantMapView extends StatefulWidget {
  // first position for map view
  final LatLng first = LatLng(4.653056, -74.055232);


  @override
  _ResturantMapView createState()  =>  _ResturantMapView() ; // creating an instance of map view
 }

 class _ResturantMapView extends State<ResturantMapView> {
   Stream<QuerySnapshot> _restaurants;
   final Completer<GoogleMapController> _mapController = Completer();
   Firestore fireStore = Firestore.instance;
   Geoflutterfire geo = Geoflutterfire();


   @override
   void initState() {

     super.initState();
     _restaurants = Firestore.instance
         .collection('restaurant')
         .orderBy('name')
         .snapshots();
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
         stream: _restaurants,
         builder: (context, snapshot) {
           if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           }
           if (!snapshot.hasData) {
             return Center(child: const Text('Loading...'));
           }

           return Stack(
             children: [
               StoreMap(
                 documents: snapshot.data.documents,
                 initialPosition: widget.first,
                 mapController: _mapController,
               ),
               FlatButton(
                   child: Icon(Icons.pin_drop),
                   color: Colors.green,
                   onPressed: () => _addMarker()
               ),
             ],
           );
         },
       ),
     );
   }
   _addMarker() async {
     _locationData = await location.getLocation();

     GeoFirePoint point = geo.point(latitude: _locationData.latitude, longitude: _locationData.longitude);
     return fireStore.collection('restaurant').add({
       'location': point.geoPoint,
       'name': 'Yay I can be queried!',
       'address': 'calle falsa 123',
       'numero': 1,
     });


   }

}

class StoreMap extends StatelessWidget {



  const StoreMap({
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

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 15,
      ),
      myLocationEnabled: true,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
      ].toSet(),
      markers: documents
          .map((document) => Marker(
        markerId: MarkerId(document['name'] as String),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(
          document['location'].latitude as double,
          document['location'].longitude as double,
        ),
        infoWindow: InfoWindow(
          title: document['name'] as String,
          snippet: document['address'] as String,
        ),
      ))
          .toSet(),
      onMapCreated: (mapController) {
        this.mapController.complete(mapController);
      },
    );
  }
}



//_animateToUser() async {
//  _locationData = await location.getLocation();
//
//  print(_locationData.latitude);
//  print(_locationData.longitude);
//  final latiTude = _locationData.latitude;
//  return latiTude;
//}

//class _ResturantMapView extends  State<ResturantMapView>{
//
//  permiss(BuildContext context)  {
//  // TODO: implement permissions
//
//  }
//
//
//  @override
//  Widget build(BuildContext context)  {
//    permiss(context);
//
//    // TODO: implement build
//    return GoogleMap(
//      initialCameraPosition: CameraPosition(
//        target: widget.first,
//        zoom: 16,
//      ),
//      markers: _createMarkers(),
//      myLocationButtonEnabled: true,
//      myLocationEnabled: true,
//    );
//  }
//  Set<Marker> _createMarkers() {
//
//
//
//    var tmp = Set<Marker>();
//
//    tmp.add(Marker(
//      markerId: MarkerId("first"),
//      position: widget.first,
//      infoWindow: InfoWindow(title: "holberton school"),
//    )
//    );
//    return tmp;
//  }


