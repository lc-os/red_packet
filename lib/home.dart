import 'package:flutter/material.dart';
import 'package:red_packet_demo/compound.dart';

class HomePage extends StatelessWidget {
  final List<IconData> list = [
    Icons.check_circle,
    Icons.flash_on,
    Icons.access_time,
    Icons.error_outline,
    Icons.ac_unit,
    // Icons.fast_forward,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedFab(list),
      ),
    );
  }
}
