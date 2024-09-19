import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

import '../utils/color.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapmyIndiaMapController _mapController;
  bool isMapLoded = false;

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      isMapLoded = false;
    });
  }

  void _onMapCreated(MapmyIndiaMapController controller) {
    _mapController = controller;
    setState(() {
      isMapLoded = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    MapmyIndiaAccountManager.setMapSDKKey('5c955f149ba9f0dfb0f84f9812af29cf');
    MapmyIndiaAccountManager.setRestAPIKey('5c955f149ba9f0dfb0f84f9812af29cf');
    MapmyIndiaAccountManager.setAtlasClientId(
        "96dHZVzsAut4ARZzJN8LLJuYy85zOLsklLn6wCL9DERIeb57-vjK8g4wYzJ82E_owF_P1SvBW36yuMu9GqJ0CA==");
    MapmyIndiaAccountManager.setAtlasClientSecret(
        "lrFxI-iSEg-Guuz6nLI13-PRCx9-fl6o14e46i4KANHEvrOrK_LdPowCEYBzHtAoKTClRYgKoKnQORQFmwt0h33mfQfywtHl");

    return
      Stack(
        children: [
        Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 210,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.02,
          child: MapmyIndiaMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(30.321684, 90.987289),
              zoom: 14.0,
            ),
            onMapCreated: (map) =>
            {
              _mapController = map,
            },
            onStyleLoadedCallback: () =>
            {
              addMarker(),
              addPolygon(),
            },
            onMapLongClick: (point, latlng) =>
            {
              print(latlng.toString()),
              Fluttertoast.showToast(
                  msg: latlng.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM)
            },
            onMapClick: (point, latlng) =>
            {
              print(latlng.toString()),
              Fluttertoast.showToast(
                  msg: latlng.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM)
            },
          ),
        ),
      ),
    Column(
    children: <Widget>[
    Expanded(
    child: MapmyIndiaMap(
    initialCameraPosition: _kInitialPosition,
    onMapCreated: _onMapCreated,
    )),
    isMapLoded
    ? Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    SizedBox(
    width: 4,
    ),
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    if (_mapController != null) {
    _mapController.moveCamera(CameraUpdate.newLatLngZoom(
    LatLng(22.553147478403194, 77.23388671875),
    14));
    }
    },
    child: Text(
    'Move Camera',
    style: TextStyle(color: Colors.white),
    ),
    color: MyColor.colorPrimaryDark,
    )),
    SizedBox(
    width: 4,
    ),
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    if (_mapController != null) {
    _mapController.easeCamera(CameraUpdate.newLatLngZoom(
    LatLng(28.704268, 77.103045), 14));
    }
    },
    child: Text('Ease Camera',
    style: TextStyle(color: Colors.white)),
    // color: MyColor.colorPrimaryDark,
    )),
    SizedBox(
    width: 4,
    ),
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    if (_mapController != null) {
    _mapController.animateCamera(
    CameraUpdate.newLatLngZoom(
    LatLng(28.698791, 77.121243), 14));
    }
    },
    child: Text(
    'Animate Camera',
    style: TextStyle(color: Colors.white),
    textAlign: TextAlign.center,
    ),
    // color: MyColor.colorPrimaryDark,
    )),
    SizedBox(
    width: 4,
    )
    ],
    )
        : Container(),

    ],

    ),],
    );

  }

  Future<void> addImageFromAsset(String name, String asset) async {
    final ByteData bytes = await rootBundle.load(asset);
    final ui.Codec codec =
    await ui.instantiateImageCodec(bytes.buffer.asUint8List());
    final ui.FrameInfo frame = await codec.getNextFrame();
    final Uint8List imageBytes =
    (await frame.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();

    _mapController.addImage(name, imageBytes);
  }

  void addMarker() async {
    await addImageFromAsset(
      "icon",
      "assets/images/gps.png",
    );
    List<LatLng> latlng = [
      LatLng(28.705436, 77.100462),
      LatLng(28.705191, 77.100784),
      LatLng(28.704765, 77.106794),
      LatLng(28.704194, 77.101171),
      LatLng(28.704083, 77.101066),
      LatLng(28.703900, 77.101318)
    ];
    LatLngBounds latLngBounds = boundsFromLatLngList(latlng);

    // Add multiple markers to the map
    for (LatLng position in latlng) {
      _mapController.addSymbol(SymbolOptions(
        geometry: position, // marker position
        iconImage: "icon", // image asset key
        iconSize: 1.0, // adjust size if needed
      ));
    }
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));

    double iconWidth = 10;
    double iconHeight = 10;

    // double defaultIconSize = 1.0; // default scale
    double iconSize = (iconWidth + iconHeight) / 400;

    _mapController.addSymbol(SymbolOptions(
      geometry: LatLng(28.705436, 77.100462), // marker position
      iconImage: "icon", // image asset key
      iconSize: iconSize,
    ));
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));

    _mapController.addLine(LineOptions(
      geometry: latlng,
      lineColor: "#3bb2d0",
      lineWidth: 3,
    ));
  }

  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  void addPolygon() async {
    List<List<LatLng>> latlng = [
      <LatLng>[
        LatLng(28.703900, 77.101318),
        LatLng(28.703331, 77.102155),
        LatLng(28.703905, 77.102761),
        LatLng(28.704248, 77.102370),
        LatLng(28.703900, 77.101318),
      ]
    ];
    LatLngBounds latLngBounds = boundsFromLatLngList(latlng.first);
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
    _mapController.addFill(FillOptions(
        geometry: latlng,
        fillColor: "#CDDBDD",
        draggable: false,
        fillOutlineColor: "#0492c2"));
  }
}
