import 'package:app/controller/adControl.dart';
import 'package:app/controller/controller.dart';
import 'package:app/controller/normalSong.dart';
import 'package:app/controller/multiSong.dart';
import 'package:app/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';
import '../util/themewhite.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<Control>(create: (_)=>Control()),
       ChangeNotifierProvider<NormalSong>(create: (_)=>NormalSong()),
       ChangeNotifierProvider<MultiSong>(create: (_)=>MultiSong()),
       ChangeNotifierProvider<AdControl>(create: (_)=>AdControl())
    ],
            child: DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => ThemeData(
              primarySwatch: white,
              fontFamily:"Pyidaungsu" ,
              textTheme: TextTheme(
                  headline4: TextStyle(color: Colors.black, fontSize: 17),
                  button: TextStyle(
                    color: Colors.black,
                  )),
              brightness: brightness),
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              title: "Khrihfa Hlabu",
              theme: theme,
              home: Splash(),
            );
          },
        )
    );
  }
}
