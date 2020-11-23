import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camping_fanatics/app_localizations.dart';
import 'package:camping_fanatics/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
            child: Text(
          AppLocalizations.of(context).translate("splashTitle"),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        )),
        SizedBox(
          width: 50,
          height: 50,
        ),
        Container(
          height: 175,
          child: Image(image: AssetImage('assets/images/camping.png')),
        ),
      ],
    )));
  }

  startTimer() {
    var duration = Duration(milliseconds: 3000);
    return Timer(duration, redirect);
  }

  redirect() async {
    Navigator.of(context).pushReplacementNamed(Routes.main);
  }
}
