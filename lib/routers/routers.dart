
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';

  static String redPacketDetailPage = '/redPacketDetail';
  static defineRouter(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('======Router Error======');
    });

    router.define(redPacketDetailPage,handler: redPacketDetailHandler);

  }
}
