import 'package:app/database/hymnsdatabasehelp.dart';
import 'package:app/database/responsivedatabasehelper.dart';
import 'package:app/util/draweselection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/data.dart';

class Control extends ChangeNotifier {
  FirstDatabaseHelper firstdatabaseHelper = FirstDatabaseHelper();
  SecondDatabaseHelper secondDatabaseHelper = SecondDatabaseHelper();
  List<Data> firstBMList = List<Data>();
  List<Data> secondBMList = List<Data>();
  List<Data> firstItemList = List<Data>();
  List<Data> firstShowdata;
  List<Data> secondItemList = List<Data>();
  List<Data> secondShowData;
  List<Data> get firstList => firstShowdata;
  List<Data> get secondList => secondShowData;
  List<String> firstBookmark = [];
  List<String> secondBookmark = [];
  TabController controller;
 bool isBookMark = false;

  DrawerSelection drawerSelect = DrawerSelection.first;
  factory Control() {
    if (_this == null) _this = Control._();
    return _this;
  }
  static Control _this;
  Control._() : super();

  getDrawerSelection(DrawerSelection drawerSelection) {
    drawerSelect = drawerSelection;
  }

    void getShare()async{
      final prefs = await SharedPreferences.getInstance();
      final myFirstList = prefs.getStringList('my_first') ?? [];
      final mySecondList = prefs.getStringList('my_second') ?? [];
      firstBookmark.clear();
      secondBookmark.clear();
      firstBookmark.addAll(myFirstList);
      secondBookmark.addAll(mySecondList);
    }

  void createListfirst() async {
    List items = await firstdatabaseHelper.getAllData();
    firstItemList.clear();
    items.forEach((item) {
      firstItemList.add(Data.fromMap(item));
      notifyListeners();
    });
  }

  void createListsecond() async {
    List items = await secondDatabaseHelper.getAllData();
    items.forEach((item) {
      secondItemList.add(Data.fromMap(item));
      notifyListeners();
    });
  }

  void onSearchChange(String value) {
    if (value.isNotEmpty || value.length != 0) {
      if (drawerSelect == DrawerSelection.first) {
        firstShowdata = firstItemList.where((first) {
          var title = first.title.toLowerCase();
          var id = first.id.toString().toLowerCase();
          return title.contains(value.toLowerCase()) ||
              id.contains(value.toLowerCase());
        }).toList();
        notifyListeners();
      } else {
        secondShowData = secondItemList.where((second) {
          var title = second.title.toLowerCase();
          var id = second.id.toString().toLowerCase();
          return title.contains(value.toLowerCase()) ||
              id.contains(value.toLowerCase());
        }).toList();
        notifyListeners();
      }
    } else {
      firstShowdata = firstItemList;
      secondShowData = secondItemList;
      notifyListeners();
    }
  }

  // Bookmark //
  firstBookMark(int id, String title, int bookmark) async {
    final first = await SharedPreferences.getInstance();
    int index;
    Data data = Data(id, "$title", bookmark);
   await firstdatabaseHelper.getBookMarkResult(id);
    int getId = await firstdatabaseHelper.getBookMarkId(id);
    if (getId != id) {
      await firstdatabaseHelper.savebookMark(id);
      firstBMList.add(data);
      firstBookmark.add(id.toString());
      first.setStringList('my_first', firstBookmark);
      notifyListeners();
    } else {
      for (var i = 0; i < firstBMList.length; i++) {
        if (firstBMList[i].id == id) {
          index = i;
        }
      }
      
      firstBookmark.remove(id.toString());
      firstBMList.remove(firstBMList[index]);
      await firstdatabaseHelper.removebookMark(id);
      first.setStringList('my_first', firstBookmark);
      notifyListeners();
    }
  }


  secondBookMark(int id, String title, int bookmark) async {
    final second = await SharedPreferences.getInstance();
    int index;
    Data data = Data(id, "$title", bookmark);
    int getId = await secondDatabaseHelper.getBookMarkId(id);
    if (getId != id) {
      await secondDatabaseHelper.savebookMark(id);
      secondBMList.add(data);
      secondBookmark.add(id.toString());
      second.setStringList('my_second', secondBookmark);
      notifyListeners();
    } else {
      for (var i = 0; i < secondBMList.length; i++) {
        if (secondBMList[i].id == id) {
          index = i;
        }
      }
      secondBookmark.remove(id.toString());
      secondBMList.remove(secondBMList[index]);
      await secondDatabaseHelper.removebookMark(id);
      second.setStringList('my_second', secondBookmark);
      notifyListeners();
    }
  }

  Future<void> createFirstBMList() async {
    List items = await firstdatabaseHelper.getBookMark();
    firstBMList.clear();
    if (items != null) {
      items.forEach((item) {
        firstBMList.add(Data.fromMap(item));
        notifyListeners();
      });
    }
  }

  Future<void> createSecondBMList() async {
    List items = await secondDatabaseHelper.getBookMark();
    secondBMList.clear();
    if (items != null) {
      items.forEach((item) {
        secondBMList.add(Data.fromMap(item));
        notifyListeners();
      });
    }
  }

  firstSlideDelete(int id) async {
    int index;
    for (var i = 0; i < firstBMList.length; i++) {
        if (firstBMList[i].id == id) {
          index = i;
        }
      }
     final first = await SharedPreferences.getInstance();
    
    firstBMList.remove(firstBMList[index]);
      await firstdatabaseHelper.removebookMark(id);
      firstBookmark.remove(id.toString());
      first.setStringList('my_first', firstBookmark);
    notifyListeners();
  }

  secondSlideDelete(int id) async {
    int index;
    for (var i = 0; i < secondBMList.length; i++) {
        if (secondBMList[i].id == id) {
          index = i;
        }
      }
         final second = await SharedPreferences.getInstance();

    secondBookmark.remove(id.toString());
 second.setStringList('my_second', secondBookmark);

      secondBMList.remove(secondBMList[index]);
      await secondDatabaseHelper.removebookMark(id);
     
      notifyListeners();
  }
}
