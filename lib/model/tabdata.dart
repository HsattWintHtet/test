import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/customicon.dart';

class Tabdata {
  final String title;
  final IconData icon;

  Tabdata({this.title, this.icon});
}

List<Tabdata> tabs = <Tabdata>[
  Tabdata(title: 'Contents', icon: MyFlutterApp.book_open),
  Tabdata(title: 'Bookmarks', icon: MyFlutterApp.collections_bookmark),
];
