import '../controller/adControl.dart';
import 'package:app/util/draweselection.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'defaultappbar.dart';
import 'page/about.dart';
import 'page/first.dart';
import 'page/second.dart';
import 'page/third.dart';
import '../controller/controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {
  DrawerSelection _drawerSelection = DrawerSelection.first;
  String appBarTitle = "Khrihfa Hlabu";
  Widget currentPage;
  InterstitialAd _interstitialAd;
  // BannerAd bannerAd;
  final control =new Control();
  final adControl = new AdControl();

  @override
  void initState() {
    print("Hell");
   

    super.initState();
    control.controller = TabController(length: 2, vsync: this);
    control.controller.addListener((){
      setState(() {      
      });
    });
    currentPage = First();
    setState(() {
     control.createListfirst();
     control.createListsecond();
      control.getShare();
    });
    control.firstShowdata = control.firstItemList;
    control.secondShowData = control.secondItemList;
      // FirebaseAdMob.instance.initialize(appId: adControl.getAppId());
    _interstitialAd = adControl.createInterstitialAd()..load();
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //  adControl.bannerAd..isLoaded().then((loaded){
    //   if(loaded && this.mounted){
        // adControl.closeBanner();
    //   }
    // });
    //      bannerAd?.dispose();
    //  bannerAd = null;
     print("Home didCha");
  }

  @override
  void dispose() {
   
    _interstitialAd.dispose();
    super.dispose();
    control.controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: DefaultAppBar(
          title: appBarTitle,
          drawerSelection: _drawerSelection,
        ),
        body: currentPage,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/menu-background.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.first
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.first
                          ? Colors.white
                          : Colors.transparent,
                  colorBrightness: Brightness.light,
                  onPressed: () {
                     _interstitialAd.dispose();
                      _interstitialAd = adControl.createInterstitialAd();
                      _interstitialAd..load()..show();
                    currentPage = First();
                    Navigator.pop(context);
                   control.getDrawerSelection(DrawerSelection.first);
                    _drawerSelection = DrawerSelection.first;
                   control.controller.animateTo(0);
                    setState(() {
                      appBarTitle = "Khrihfa Hlabu";
                     control.isBookMark = false;
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Khrihfa Hlabu",
                          style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.first
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.first
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.first,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.second
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.second
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                      _interstitialAd.dispose();
                      _interstitialAd = adControl.createInterstitialAd();
                      _interstitialAd..load()..show();
                    currentPage = Second();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.second;
                  control.getDrawerSelection(DrawerSelection.second);
                    control.controller.animateTo(0);
                    setState(() {
                      appBarTitle = "Chawnghlang Relnak";
                       control.isBookMark = false;
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Chawnghlang Relnak",
                          style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.second
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.second
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.second,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.third
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.third
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                     _interstitialAd.dispose();
                      _interstitialAd = adControl.createInterstitialAd();
                      _interstitialAd..load()..show();
                    currentPage = Third();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.third;
                    setState(() {
                      appBarTitle = "Daily Bible Chin";
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Daily Bible Chin",
                         style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.third
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.third
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.third,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.about
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.about
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                     _interstitialAd.dispose();
                      _interstitialAd = adControl.createInterstitialAd();
                      _interstitialAd..load()..show();
                    currentPage = About();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.about;
                    setState(() {
                      appBarTitle = "About";
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "About",
                        style:  Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.about
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.about
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.about,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
