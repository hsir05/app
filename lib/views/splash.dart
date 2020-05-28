import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import '../routers/application.dart';
import 'package:fluro/fluro.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  
  @override
  _SplashPageState createState() => _SplashPageState();
}
  
class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _initSplash();
  }
  
  void _initSplash() {
    Future.delayed(new Duration(milliseconds: 2000), () {
        Application.router.navigateTo(context, "/", clearStack: true, transition: TransitionType.fadeIn);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        child: Image.asset('assets/splash.jpg', fit: BoxFit.cover),
      )
    );
  }
}