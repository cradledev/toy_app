import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/home.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MyFatoorah extends StatefulWidget {
  MyFatoorah({Key key, this.inputurl}) : super(key: key);
  String inputurl;
  @override
  MyFatoorahState createState() => MyFatoorahState();
}

class MyFatoorahState extends State<MyFatoorah> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    // return WillPopScope(
    //   onWillPop: () async {
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Home()),
    //         (route) => false);
    //     return false;
    //   },
    //   child: WebView(
    //     initialUrl: widget.inputurl,
    //   ),
    // );
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: Image.asset(
            'assets/img/LoginRegistration/header.png',
            // height: height * 0.1,
            width: width * 0.5,
            fit: BoxFit.cover,
          ),
          leadingAction: () {
            Navigator.pushNamed(context, '/home');
            // Navigator.pop(context);
          },
        ),
        body: WebView(
          initialUrl: widget.inputurl,
        ),
      ),
    );
  }
}
