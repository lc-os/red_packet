import 'package:flutter/material.dart';
import 'package:red_packet_demo/home.dart';
import 'package:red_packet_demo/routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:red_packet_demo/routers/routers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.defineRouter(router);
    Application.router = router;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
