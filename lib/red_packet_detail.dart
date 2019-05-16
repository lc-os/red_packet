import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils.dart';
import 'package:red_packet_demo/routers/application.dart';

class RedPacketDetailPage extends StatelessWidget {
  final double bags;
  RedPacketDetailPage(this.bags);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/red_packet_bg.png",
                  width: ScreenUtil.screenWidthDp,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/back_action_yellow.png',
                      width: 10,
                      height: 17,
                    ),
                    onPressed: () {
                      Application.router.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top +
                          ScreenUtil().setWidth(100)),
                  // color: Colors.yellow,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "红包",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            color: stringColor("F0CC9B"),
                          ),
                        ),
                        Text(
                          "恭喜发财，大吉大利",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: stringColor("F0CC9B"),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(90),
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              bags != null
                                  ? bags.toString()
                                  : "0.00",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(100),
                                color: stringColor("F0CC9B"),
                              ),
                            ),
                            Text(
                              "元",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(36),
                                color: stringColor("F0CC9B"),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "已存入余额，可直接提现",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: stringColor("F0CC9B"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(165)),
              child: Center(
                  child: Image.asset(
                "assets/red_packet_detail_icon.png",
                width: ScreenUtil().setWidth(150),
                height: ScreenUtil().setHeight(106),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
