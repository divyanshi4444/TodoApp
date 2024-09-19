import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MapClickEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapClickEventState();
  }

}

class MapClickEventState extends State {
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(28.457523, 77.026344,),
    zoom: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Map Click',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.2, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: MapmyIndiaMap(
        initialCameraPosition: _kInitialPosition,
        onMapClick: (point, latlng) =>{
          print(latlng.toString()),
          Fluttertoast.showToast(msg: latlng.toString(), toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM)
        },

      ),
    );
  }

}