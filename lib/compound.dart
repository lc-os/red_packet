import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:red_packet_demo/red_packet.dart';

class AnimatedFab extends StatefulWidget {
  final List dataSource;
  final VoidCallback onClick;

  const AnimatedFab(this.dataSource, {Key key, this.onClick}) : super(key: key);

  @override
  _AnimatedFabState createState() => new _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.yellow, end: Colors.yellow[800])
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    expandedSize = MediaQuery.of(context).size.width - 20;
    return new SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Stack(
            alignment: Alignment.center,
            children: _dataSourceWidgets(),
            // _buildExpandedBackground(),
            //   _buildOption(Icons.check_circle, 0.0),
            //   _buildOption(Icons.flash_on, -math.pi / 2),
            //   _buildOption(Icons.access_time, math.pi / 2),
            //   _buildOption(Icons.error_outline, math.pi),
            //   _buildFabCore(),
          );
        },
      ),
    );
  }

  List<Widget> _dataSourceWidgets() {
    List<Widget> items = [];
    items.add(_buildExpandedBackground());
    widget.dataSource.forEach((item) {
      items.add(_buildOption(
          item,
          2 *
              math.pi *
              widget.dataSource.indexOf(item) /
              widget.dataSource.length));
    });
    items.add(_buildFabCore());
    return items;
  }

  Widget _buildOption(IconData icon, double angle) {
    if (_animationController.isDismissed) {
      return Container();
    }
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: _onIconClick,
            icon: new Transform.rotate(
              angle: -angle,
              child: new Icon(
                icon,
                color: Colors.white,
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedBackground() {
    // double size =
        // hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: expandedSize,
      width: expandedSize,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    );
  }

  Widget _buildFabCore() {
    // double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FlatButton(
      onPressed: _onFabTap,
      child: Text("合成"),
      // new Transform(
      //   alignment: Alignment.center,
      //   transform: new Matrix4.identity()..scale(1.0, scaleFactor),
      //   child: new Icon(
      //     _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
      //     color: Colors.white,
      //     size: 26.0,
      //   ),
      // ),
      // backgroundColor: _colorAnimation.value,
      color: Colors.orange,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RedPacketDialog();
        });
    // if (_animationController.isDismissed) {
    //   open();
    // } else {
    //   close();
    // }
  }

  _onIconClick() {
    widget.onClick();
    close();
  }
}
