import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_packet_demo/routers/application.dart';
import 'package:fluro/fluro.dart';

/// ignore: must_be_immutable
class RedPacketDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Material(
      ///创建透明层
      type: MaterialType.transparency,

      ///透明类型
      child: Center(
        child: RedPacketPage(),
      ),
    );
  }
}

class RedPacketPage extends StatefulWidget {
  @override
  _RedPacketPageState createState() => _RedPacketPageState();
}

class _RedPacketPageState extends State<RedPacketPage> {
  bool showGif = false;
  bool dismiss = false;
  double bags = 2.33;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    if (dismiss) {
      return DismissWidget(bags);
    } else {
      return _normalWidget();
    }
  }

  Widget _normalWidget() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(70), right: ScreenUtil().setWidth(70)),
      child: Column(children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setWidth(700),
                  child: Container(),
                ),
                Container(
                  child: Image.asset(
                    "assets/red_packet_bottom.png",
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
            Image.asset(
              "assets/red_packet_top.png",
              fit: BoxFit.fitHeight,
              height: ScreenUtil().setWidth(740),
            ),
            showGif
                ? Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(740)),
                    child: Center(
                      child: Center(
                        child: Image.asset(
                          "assets/open_red_packet.gif",
                          width: 100,
                          scale: 1,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(740)),
                    child: Center(
                      child: IconButton(
                        icon: Image.asset(
                          "assets/open_icon.png",
                          // width: 100,
                          // scale: 1,
                        ),
                        iconSize: 100,
                        onPressed: () {
                          _takeRedPacket();
                        },
                      ),
                    ),
                  ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(
            child: FlatButton(
              child: Image.asset(
                "assets/close_icon.png",
                width: ScreenUtil().setWidth(68),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ]),
    );
  }

  void _takeRedPacket() async {
    setState(() {
      showGif = true;
    });
    Future.delayed(Duration(seconds:1),(){
      setState(() {
        dismiss = true;
      });
    });
      
  }
}

class DismissWidget extends StatefulWidget {
  final double bags;
  DismissWidget(this.bags);
  @override
  _DismissWidgetState createState() => _DismissWidgetState();
}

class _DismissWidgetState extends State<DismissWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation topParentAnimation;
  Animation bottomParentAnimation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            if (animationController.isCompleted) {
              Navigator.pop(context);
              Application.router.navigateTo(
                  context, "/redPacketDetail?bags=${widget.bags}",
                  transition: TransitionType.fadeIn);
            }
          });
    topParentAnimation = Tween(begin: 0.0, end: -1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    bottomParentAnimation = Tween(begin: 0.0, end: 1.5).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Center(
      // margin: EdgeInsets.only(left: 35, right: 35),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.translationValues(
                    0.0, bottomParentAnimation.value * height / 3, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setWidth(700),
                      child: Container(),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/red_packet_bottom.png",
                        width: bottomParentAnimation.value * width <
                                (width - ScreenUtil().setWidth(140))
                            ? (width - ScreenUtil().setWidth(140))
                            : bottomParentAnimation.value * width,
                        // height: 422,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Transform(
                  transform: Matrix4.translationValues(
                      0.0, topParentAnimation.value * height / 2, 0.0),
                  child: Center(
                    child: Image.asset(
                      "assets/red_packet_top.png",
                      width: bottomParentAnimation.value * width <
                              (width - ScreenUtil().setWidth(140))
                          ? (width - ScreenUtil().setWidth(140))
                          : bottomParentAnimation.value * width,
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
