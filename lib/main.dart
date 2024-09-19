import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/screens/carousel_screen.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:todoapp/screens/homepage.dart';
import 'package:todoapp/screens/map_click_screen.dart';
import 'package:todoapp/screens/map_screen.dart';

void main() async{
  //init the hive
 await Hive.initFlutter();

 //open a box
 var box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        hintColor: Theme.of(context).primaryColorDark,
        useMaterial3: true,
      ),
      home: const MapScreen(),
    routes: <String, WidgetBuilder>{
    '/MapScreen': (BuildContext context) => MapScreen(),
    '/MapClick': (BuildContext context) => MapClickEvent(),
    // '/AddPolyline':(BuildContext context) => AddPolylineWidget(),
}
    );
  }
}
