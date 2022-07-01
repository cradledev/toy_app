import 'dart:io';
import 'package:flutter/material.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
        return false;
      },
      child: WebView(
        initialUrl: widget.inputurl,
      ),
    );
  }
}
