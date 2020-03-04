import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';




class ResturantMapView extends StatefulWidget {
  // first position for map view
  final LatLng first = LatLng(4.653056, -74.055232);

  @override
  _ResturantMapView createState()  =>  _ResturantMapView() ; // creating an instance of map view
 }


class _ResturantMapView extends  State<ResturantMapView>{

  permiss(BuildContext context)  {
  // TODO: implement permissions
  }


  @override
  Widget build(BuildContext context)  {
    permiss(context);

    // TODO: implement build
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.first,
        zoom: 16,
      ),
      markers: _createMarkers(),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
    );
  }
  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(Marker(
      markerId: MarkerId("first"),
      position: widget.first,
      infoWindow: InfoWindow(title: "holberton school"),
    )
    );
    return tmp;
  }


}