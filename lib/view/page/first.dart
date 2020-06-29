import 'package:app/controller/controller.dart';
import 'package:app/model/data.dart';
import 'package:app/view/tab/firsttab1.dart';
import 'package:app/view/tab/firsttab2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../util/draweselection.dart';

class First extends StatefulWidget {
  final DrawerSelection drawerSelection;
  final List<Data> data;
  final List<Data> item;
  const First({Key key, this.drawerSelection, this.data, this.item})
      : super(key: key);
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final control = new Control();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller:control.controller ,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[FirstTab1(), FirstTab2()]),
    );
  }
}
