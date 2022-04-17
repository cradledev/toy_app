// import 'package:toy_app/model/toy_detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toy_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toy_app/helper/constant.dart';

class UserService {
  Future<String> getToken() async {
    try {
      var responnse = await http.post(
        Uri.parse("http://23.21.117.81:5000/token"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "guest": false,
          "username": "devvaleria@protonmail.com",
          "password": "123123123",
          "remember_me": true
        }),
      );
      final body = json.decode(responnse.body);
      String token = body["access_token"];
      print("token =====================================");
      print(token);
      return token;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> login(String userEmail, String userPassword) async {
    try {
      // var responnse = await http.post(
      //   "http://23.21.117.81:5000/api/"
      // )
      String token = await getToken();
      final response = await http.get(
        Uri.parse("http://23.21.117.81:5000/api/customers?Limit=100"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      List<UserModel> users = (body['customers'] as List)
          .map((p) => UserModel.fromJson(p))
          .toList();
      users = users
          .where((element) =>
              element.userName == userEmail &&
              element.active == true &&
              element.pass == userPassword)
          .toList();
      if (users.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearer_token', token);
        await prefs.setString('auth_name', userEmail);
        await prefs.setString('auth_userid', users[0].id.toString());
        await prefs.setString('first_name', users[0].firstName);
        await prefs.setString('last_name', users[0].lastName);
        await prefs.setString('bio', users[0].bio);
        await prefs.setString('path', users[0].path);
        await prefs.setString('customerId', users[0].customerId);
        await prefs.setString('password', users[0].pass);
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> userinfoChange(List<String> list) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('bearer_token');
      String id = prefs.getString('auth_userid');
      String email = prefs.getString('auth_name');
      String customerId = prefs.getString('customerId');
      String pass = prefs.getString('password');
      int ids = int.parse(id);
      final response = await http.put(
        Uri.parse("http://23.21.117.81:5000/api/customers/$id"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "ObjectPropertyNameValuePairs": {},
          "customer": {
            "billing_address": {
              "first_name": list[0],
              "last_name": list[1],
              "email": email,
              "company": "",
              "country_id": 237,
              "country": "United States of America",
              "state_province_id": 41,
              "city": "NewYork",
              "address1": "NewYork",
              "address2": "NewYork",
              "zip_postal_code": "123",
              "phone_number": "123",
              "fax_number": "123",
              "customer_attributes": "123",
              "created_on_utc": "2022-02-07T04:21:33.362Z",
              "province": "123",
              "id": 5
            },
            "shipping_address": {
              "first_name": list[0],
              "last_name": list[1],
              "email": email,
              "company": "",
              "country_id": 237,
              "country": "United States of America",
              "state_province_id": 41,
              "city": "NewYork",
              "address1": "NewYork",
              "address2": "NewYork",
              "zip_postal_code": "123",
              "phone_number": "123",
              "fax_number": "123",
              "customer_attributes": "123",
              "created_on_utc": "2022-02-07T04:21:33.362Z",
              "province": "123",
              "id": 5
            },
            "addresses": [
              {
                "first_name": list[0],
                "last_name": list[1],
                "email": email,
                "company": "",
                "country_id": 237,
                "country": "United States of America",
                "state_province_id": 41,
                "city": "NewYork",
                "address1": "NewYork",
                "address2": "NewYork",
                "zip_postal_code": "123",
                "phone_number": "123",
                "fax_number": "123",
                "customer_attributes": "123",
                "created_on_utc": "2022-02-07T04:21:33.362Z",
                "province": "123",
                "id": 5
              }
            ],
            "customer_guid": customerId,
            "username": email,
            "email": email,
            "first_name": list[0],
            "last_name": list[1],
            "language_id": 1,
            "currency_id": 1,
            "date_of_birth": "2022-02-07T04:21:33.362Z",
            "gender": "male",
            "admin_comment": list[2],
            "is_tax_exempt": false,
            "has_shopping_cart_items": false,
            "active": true,
            "deleted": false,
            "is_system_account": false,
            "system_name": list[3],
            "last_ip_address": pass,
            "created_on_utc": "2022-02-07T04:21:33.362Z",
            "last_login_date_utc": "2022-02-07T04:21:33.362Z",
            "last_activity_date_utc": "2022-02-07T04:21:33.362Z",
            "registered_in_store_id": 1,
            "subscribed_to_newsletter": true,
            "role_ids": [3],
            "id": ids
          }
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        await prefs.setString('first_name', list[0]);
        await prefs.setString('last_name', list[1]);
        await prefs.setString('bio', list[2]);
        await prefs.setString('path', list[3]);
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> register(List<String> info) async {
    try {
      String token = await getToken();
      final response = await http.post(
        Uri.parse("http://23.21.117.81:5000/api/customers"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "ObjectPropertyNameValuePairs": {},
          "customer": {
            "billing_address": {
              "first_name": info[0],
              "last_name": info[1],
              "email": info[2],
              "company": "",
              "country_id": 237,
              "country": "United States of America",
              "state_province_id": 41,
              "city": "NewYork",
              "address1": "NewYork",
              "address2": "NewYork",
              "zip_postal_code": "123",
              "phone_number": "123",
              "fax_number": "123",
              "customer_attributes": "123",
              "created_on_utc": "2022-02-07T04:21:33.362Z",
              "province": "123",
              "id": 5
            },
            "shipping_address": {
              "first_name": info[0],
              "last_name": info[1],
              "email": info[2],
              "company": "",
              "country_id": 237,
              "country": "United States of America",
              "state_province_id": 41,
              "city": "NewYork",
              "address1": "NewYork",
              "address2": "NewYork",
              "zip_postal_code": "123",
              "phone_number": "123",
              "fax_number": "123",
              "customer_attributes": "123",
              "created_on_utc": "2022-02-07T04:21:33.362Z",
              "province": "123",
              "id": 5
            },
            "addresses": [
              {
                "first_name": info[0],
                "last_name": info[1],
                "email": info[2],
                "company": "",
                "country_id": 237,
                "country": "United States of America",
                "state_province_id": 41,
                "city": "NewYork",
                "address1": "NewYork",
                "address2": "NewYork",
                "zip_postal_code": "123",
                "phone_number": "123",
                "fax_number": "123",
                "customer_attributes": "123",
                "created_on_utc": "2022-02-07T04:21:33.362Z",
                "province": "123",
                "id": 5
              }
            ],
            "customer_guid": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "username": info[2],
            "email": info[2],
            "first_name": info[0],
            "last_name": info[1],
            "password": info[3],
            "language_id": 1,
            "currency_id": 1,
            "date_of_birth": "2022-02-07T04:21:33.362Z",
            "gender": "male",
            "admin_comment": "",
            "is_tax_exempt": false,
            "has_shopping_cart_items": false,
            "active": true,
            "deleted": false,
            "is_system_account": false,
            "system_name": "",
            "last_ip_address": info[3],
            "created_on_utc": "2022-02-07T04:21:33.362Z",
            "last_login_date_utc": "2022-02-07T04:21:33.362Z",
            "last_activity_date_utc": "2022-02-07T04:21:33.362Z",
            "registered_in_store_id": 1,
            "subscribed_to_newsletter": true,
            "role_ids": [3],
            "id": 4
          }
        }),
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        int id = body['customers'][0]['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('bearer_token', token);
        await prefs.setString('auth_name', info[2]);
        await prefs.setString('auth_userid', id.toString());
        await prefs.setString('first_name', info[0]);
        await prefs.setString('last_name', info[1]);
        await prefs.setString('pass', info[3]);
        await prefs.setString('path', '');
        return 'success';
      }
      return 'failed';
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
