import '../../controller/adControl.dart';
import 'package:app/util/customicon.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import '../../controller/controller.dart';
import 'package:provider/provider.dart';

class SecondDetail extends StatefulWidget {
  final int id;
  final String title;
  final int bookmark;
  const SecondDetail({Key key, this.id, this.title, this.bookmark})
      : super(key: key);

  @override
  _SecondDetailState createState() => _SecondDetailState();
}

class _SecondDetailState extends State<SecondDetail> {
  final adControl = AdControl();
  double fontSize = 10.0;
  String _text;
  BannerAd _bannerAd;
  @override
  void initState() {
    super.initState();
    Control().getShare();
    getText();
    // _bannerAd = adControl.createBannerAdUnitId()..load();
  }

  getText() async {
    String text = await rootBundle
        .loadString('assets/database/responsive/${widget.id}.html');
    setState(() {
      _text = text;
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: adControl.getAppId())
        .then((response) {
      _bannerAd
        ..load()
        ..show(anchorOffset: 80.0, anchorType: AnchorType.top);
    });
    final bm = Provider.of<Control>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id}"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Theme.of(context).brightness == Brightness.light
                      ? Icon(Icons.brightness_2)
                      : Icon(Icons.wb_sunny),
                  onPressed: () {
                    DynamicTheme.of(context).setBrightness(
                        Theme.of(context).brightness == Brightness.light
                            ? Brightness.dark
                            : Brightness.light);
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(MyFlutterApp.format_font_size_increase),
                  onPressed: () {
                    setState(() {
                      fontSize++;
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(MyFlutterApp.format_font_size_decrease),
                  onPressed: () {
                    setState(() {
                      fontSize--;
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    Control().secondBookMark(
                        widget.id, widget.title, widget.bookmark);
                  },
                  color: bm.secondBookmark.contains(widget.id.toString())
                      ? Colors.greenAccent
                      : Theme.of(context).appBarTheme.color,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Html(
                data: _text,
                customTextAlign: (dom.Node node) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "h4":
                        return TextAlign.center;
                    }
                  }
                  return null;
                },
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "h4":
                        return baseStyle.merge(
                          TextStyle(
                              fontSize: fontSize + 3,
                              fontWeight: FontWeight.bold,
                              height: 1.0),
                        );

                      case "b":
                        return baseStyle.merge(TextStyle(
                            fontSize: fontSize, fontWeight: FontWeight.bold));

                      case "p":
                        return baseStyle.merge(TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w400,
                            height: 1.2));
                    }
                  }

                  return baseStyle;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
