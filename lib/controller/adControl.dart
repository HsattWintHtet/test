import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

class AdControl extends ChangeNotifier {
  factory AdControl() {
    if (_this == null) _this = AdControl._();
    return _this;
  }
  static AdControl _this;
  AdControl._() : super();

  showbanner() {
    // createBannerAdUnitId()
    bannerAd
      ..load()
      ..show(
        anchorOffset: 80.0,
        anchorType: AnchorType.top,
      );
      notifyListeners();
  }

    showInter() {
    createInterstitialAd()
      ..load()
      ..show();
  }
   void closeBanner()async{
    // createBannerAdUnitId()?.dispose();
   await bannerAd?.dispose();
    // ignore: unnecessary_statements
    bannerAd == null;
  }

  String getAppId() {
    if (Platform.isIOS) {
      return "ca-app-pub-8032453967263891~9118748177";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8032453967263891~1572959323";
    }
    return null;
  }

  String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return "ca-app-pub-8032453967263891/5179503167";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8032453967263891/5145017606";
    }
    return null;
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      // adUnitId: getInterstitialAdUnitId(),
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }
BannerAd bannerAd = BannerAd(adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      } );
  // BannerAd createBannerAdUnitId() {
  //   return BannerAd(
  //     // adUnitId: getBannerAdUnitId(),
  //     adUnitId: BannerAd.testAdUnitId,
  //     size: AdSize.banner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event is $event");
  //     },
  //   );
  // }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return "ca-app-pub-8032453967263891/3339614362";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8032453967263891/1381387636";
    }
    return null;
  }

 static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    // birthday: DateTime.now(),
    childDirected: false,
    // designedForFamilies: false,
    // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  );
}
