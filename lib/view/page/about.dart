import 'package:app/util/customicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 28.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Text(
                "Khrihfa Hlabu App cu Mobile Phone in hman khawhnak ding caah tuah a si."),
            SizedBox(
              height: 15,
            ),
            Text(
                "Copy Right hi CACC ta bak a si i CACC nih nan hmang kho lo an kan ti tu ahcun aho cio poh nih hmanlo in hrawh ding a si te lai tiah nawl kan duh hna"),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 400,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "Pehtlaihnak",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Container(
              height: 168,
              width: 400,
              child: ListView(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => launch("tel:09965777399"),
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("09965777399"),
                    ),
                  ),
                  FlatButton(
                    onPressed: () =>
                        launch("mailto:rampengthang2014@gmail.com"),
                    child: ListTile(
                      leading: Icon(Icons.mail),
                      title: Text("rampengthang2014@gmail.com"),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => launch("http://www.chinitfree.com"),
                    child: ListTile(
                      leading: Icon(MyFlutterApp.chrome),
                      title: Text("http://www.chinitfree.com"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}