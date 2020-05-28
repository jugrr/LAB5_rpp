import 'dart:async';
import 'package:flutter/material.dart';
import 'package:labfive/API/CatAPI.dart';
import 'package:labfive/models/Cats.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {

  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double sideLength = 50;
  BreedList br;
  @override
  void initState() {
    super.initState();
    splash().then(
      (status){  
        if(status){
          replaceMain(br);
        }
        else{
          print('b');
        }
      }
    );
  }




Future<bool> splash() async{
  print('AAAAAAAAAAAAAAAAAA');
  try {
    List<dynamic> list = await CatAPI().getCatBreeds();
    br = BreedList.fromJson(list);
        if(br.breeds.length != null){
          
          return true;
        }
        else 
          return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

replaceMain(BreedList b) {
  Navigator.of(context).pushReplacement(createRoute(b));
  //Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => MainApp(data : b)));
}


Route createRoute(BreedList b){
  return PageRouteBuilder( transitionDuration: Duration(milliseconds: 750),pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(br: b),
    transitionsBuilder: (context, animation, secondaryAniomation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOutExpo;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition( 
        position: animation.drive(tween),
        child: child
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: 
    Container(
      child: 
          Opacity(
            opacity: 0.865,
            child: Image.asset("assets/wallpapersden.com_android-robot-glass_1440x2880.jpg")
          ), 
    ),
  );
}
}