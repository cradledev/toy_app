import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toy_app/helper/constant.dart';
import 'package:toy_app/model/user_model.dart';

class UserService {
  Future<Map<String, dynamic>> passwordChange(Map list) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString("token") ?? '';

      final response = await http.post(
        Uri.parse("$apiEndPoint/Customer/ChangePassword"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "old_password": list['old_password'],
          "new_password": list['new_password'],
          "confirm_new_password": list['confirm_new_password'],
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return {'ok': true, 'message': jsonDecode(response.body)};
      } else {
        return {'ok': false, 'message': jsonDecode(response.body)};
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<String> userinfoChange(Map list, Map userBio) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString("token") ?? '';
      String email = list['email'];
      final response = await http.post(
        Uri.parse("$apiEndPoint/Customer/Info"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "model": {
            "email": list['userEmail'] ?? email,
            "email_to_revalidate": null,
            "check_username_availability_enabled": true,
            "allow_users_to_change_usernames": true,
            "usernames_enabled": true,
            "username": list['userEmail'] ?? email,
            "gender_enabled": false,
            "gender": null,
            "first_name_enabled": true,
            "first_name": list['firstname'],
            "first_name_required": false,
            "last_name_enabled": true,
            "last_name": list['lastname'],
            "last_name_required": false,
            "date_of_birth_enabled": false,
            "date_of_birth_day": 0,
            "date_of_birth_month": 0,
            "date_of_birth_year": 0,
            "date_of_birth_required": false,
            "company_enabled": false,
            "company_required": false,
            "company": "string",
            "street_address_enabled": true,
            "street_address_required": false,
            "street_address": list['address1'],
            "street_address2_enabled": false,
            "street_address2_required": false,
            "street_address2": "string",
            "zip_postal_code_enabled": false,
            "zip_postal_code_required": false,
            "zip_postal_code": null,
            "city_enabled": true,
            "city_required": false,
            "city": list['city'],
            "county_enabled": false,
            "county_required": false,
            "county": "string",
            "country_enabled": true,
            "country_required": false,
            "country_id": list['country_id'],
            "available_countries": [
              {
                "disabled": true,
                "group": {"disabled": true, "name": "string"},
                "selected": true,
                "text": "string",
                "value": "string"
              }
            ],
            "state_province_enabled": false,
            "state_province_required": false,
            "state_province_id": 0,
            "available_states": [],
            "phone_enabled": true,
            "phone_required": false,
            "phone": list['phone'],
            "fax_enabled": false,
            "fax_required": false,
            "fax": null,
            "newsletter_enabled": true,
            "newsletter": true,
            "signature_enabled": false,
            "signature": "string",
            "time_zone_id": null,
            "allow_customers_to_set_time_zone": false,
            "available_time_zones": [
              {
                "disabled": true,
                "group": {"disabled": true, "name": "string"},
                "selected": true,
                "text": "string",
                "value": "string"
              }
            ],
            "vat_number": null,
            "vat_number_status_note": "Unknown",
            "display_vat_number": false,
            "associated_external_auth_records": [],
            "number_of_external_authentication_providers": 0,
            "allow_customers_to_remove_associations": true,
            "customer_attributes": [
              {
                "name": "bio",
                "is_required": false,
                "default_value": list['bio'],
                "attribute_control_type": "Textbox",
                "values": [
                  {
                    "name": "string",
                    "is_pre_selected": true,
                    "id": 0,
                    "custom_properties": {
                      "additionalProp1": "string",
                      "additionalProp2": "string",
                      "additionalProp3": "string"
                    }
                  }
                ],
                "id": userBio == null ? 0 :  userBio['id'],
                "custom_properties": {}
              }
            ],
            "gdpr_consents": [],
            "custom_properties": {}
          },
          "form": {'customer_attribute_1': list['bio']},
        }),
      );
      if (response.statusCode == 200) {
        await _prefs.setString('path', list['avatar']);
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  // visit as a guest
  Future<UserModel> onVisitAsGuest(Map _payloads) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString("token") ?? '';
      var response = await http.post(Uri.parse("$apiEndPoint/Authenticate/GetToken"), body: jsonEncode(_payloads), headers: customHeaders);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        body['is_guest'] = true;
        body['username'] = _payloads['username'];
        body['email'] = _payloads['email'];
        _prefs.setString('user', jsonEncode(body));
        UserModel _guest = UserModel.fromJson(body);
        return _guest;
      } else {
        throw Exception("Bad Request.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // login
  Future<Map<String, dynamic>> onLogin(Map _payloads) async {
    try {
      var response = await http.post(Uri.parse("$apiEndPoint/Authenticate/GetToken"), body: jsonEncode(_payloads), headers: customHeaders);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        body['is_guest'] = false;
        body['email'] = _payloads['email'];
        return body;
      } else {
        throw Exception("Bad Request.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // get token 
  Future<String> getToken(Map _payloads) async {
    try {
      var response = await http.post(Uri.parse("$apiEndPoint/Authenticate/GetToken"), body: jsonEncode(_payloads), headers: customHeaders);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body['token'];
      } else {
        throw Exception("Bad Request.");
      }
    } catch (e) {
      rethrow;
    }
  }

  // on sign up 
  // login
  Future<bool> onSignup(Map _payloads, String _token) async {
    try {
      customHeaders['Authorization'] = "Bearer $_token";
      var response = await http.post(Uri.parse("$apiEndPoint/Customer/Register?returnUrl=false"), body: jsonEncode(_payloads), headers: customHeaders);
      print(response);
      if (response.statusCode == 302) {
        return true;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  // logout
  Future<bool> onLogout(String _token) async {
    try {
      customHeaders['Authorization'] = "Bearer $_token";
      var response = await http.get(Uri.parse("$apiEndPoint/Customer/Logout"), headers: customHeaders);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Bad Request.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
