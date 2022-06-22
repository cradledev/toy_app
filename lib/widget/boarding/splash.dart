import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/model/user_model.dart';
import 'package:toy_app/provider/index.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin {
  // Appstate setting
  AppState appState;
  AnimationController animationController;
  Animation<double> animation;
  startTime() async {
    var _duration = const Duration(seconds: 6);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    appState.getLocalStorage('user').then((value) {
      Map _user = value.isNotEmpty ? jsonDecode(value) : null;
      if (_user == null) {
        Navigator.of(context).pushReplacementNamed('/onboarding');
      } else {
        appState.user = UserModel.fromJson(_user);
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }).catchError((error) {
      print(error);
    });
    
  }

  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff283488),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/splash/header.png',
                width: animation.value *
                    (MediaQuery.of(context).size.width * 0.95),
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
