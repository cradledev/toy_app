import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  final String _endpoint = "http://147.182.244.82:80/api/v1";

  final String selectedLang = "selectedLang";
  Map _user;
  String _token = '';
  SharedPreferences _sp;
  String _city = "";
  String _address = "";
  String _index = "";
  String _cartTotalPrice = "";
  //get
  get endpoint => _endpoint;
  get user => _user;
  get sp => _sp;
  get token => _token;
  get cartTotalPrice => _cartTotalPrice;

  get city => _city;
  get address => _address;
  get index => _index;
  // set
  set user(value) {
    _user = value;
    notifyListeners();
  }

  set sp(value) {
    _sp = value;
    notifyListeners();
  }

  set token(value) {
    _token = value;
    notifyListeners();
  }

  set city(value) {
    _city = value;
    notifyListeners();
  }

  set address(value) {
    _address = value;
    notifyListeners();
  }

  set index(value) {
    _index = value;
    notifyListeners();
  }

  set cartTotalPrice(value) {
    _cartTotalPrice = value;
    notifyListeners();
  }

  void notifyToast({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void notifyToastDanger({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void notifyToastSuccess({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  Future<String> loadInterestJsonFile(String assetsPath) async {
    return rootBundle.loadString(assetsPath);
  }

  Future<http.Response> post(url, payload) async {
    var response = await http.post(url, body: payload, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*'
    });

    return response;
  }

  Future<http.Response> postAuth(url, payload) async {
    var response = await http.post(url, body: payload, headers: {
      "accept": "application/json",
      'Authorization': 'Bearer ' + token
    });
    return response;
  }

  Future<http.Response> get(url, {context}) async {
    var response = await http.get(url, headers: {"accept": "application/json"});
    return response;
  }

  Future<http.Response> getAuth(url) async {
    var response = await http.get(url, headers: {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  String formatDate(date) {
    return date.toString().split(' ')[0];
  }

  String formatTime(time) {
    return time.toString().split(':')[0] + ':' + time.toString().split(':')[1];
  }

  Future setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(selectedLang, languageCode);
    notifyListeners();
  }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(selectedLang) ?? 'en';
    return Locale(languageCode);
  }
}
