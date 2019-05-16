import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:red_packet_demo/red_packet_detail.dart';

///红包详情
Handler redPacketDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RedPacketDetailPage(double.parse(params['bags'].first));
});
