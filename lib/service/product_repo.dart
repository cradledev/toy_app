// import 'package:toy_app/model/toy_detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/model/category_model.dart';
import 'package:toy_app/model/category_list_model.dart';
import 'package:toy_app/model/manufacture_model.dart';
import 'package:toy_app/model/manufacture_mapping.dart';
import 'package:toy_app/model/cart_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  // var url = Uri.http('192.168.116.40:5000/', '/api/products', {'q': '{http}'});
  String url =
      "http://23.21.117.81:5000/api/products?Fields=id%2Cname%2Cshort_description%2Cfull_description%2Cprice%2Capproved_rating_sum%2Cimages&PublishedStatus=true";

  Future<List<Product>> getManufacture(String name) async {
    try {
      //Get Manufacture ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      final manufacturer = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/manufacturers?Fields=id%2Cname"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (manufacturer.statusCode != 200) {
        throw Exception('Failed to get products');
      }
      final body = json.decode(manufacturer.body);

      List<Manufacturer> manufacturers = (body['manufacturers'] as List)
          .map((p) => Manufacturer.fromJson(p))
          .toList();
      manufacturers =
          manufacturers.where((element) => element.name == name).toList();
      int manuId = manufacturers[0].id;
      //Get Product IDs from Manufacture-Product-Mapping List
      final response = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/product_manufacturer_mappings?Fields=product_id&ManufacturerId=$manuId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final list_body = json.decode(response.body);
      List<Manumapping> list =
          (list_body['product_manufacturer_mappings'] as List)
              .map((e) => Manumapping.fromJson(e))
              .toList();
      int firstId = list[0].productId;
      String ids = "Ids=$firstId";
      for (int i = 1; i < list.length; i++) {
        int id = list[i].productId;
        ids = ids + "&Ids=$id";
      }
      final productResponse = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/products?$ids&Fields=id%2Cname%2Cshort_description%2Cfull_description%2Cprice%2Capproved_rating_sum%2Cimages&PublishedStatus=true"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final productBody = json.decode(productResponse.body);
      if (productResponse.statusCode == 200) {
        return ((productBody['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList());
      } else {
        throw Exception('Failed to get products');
      }
      // final productBody = json.decode(response.body);
      // if (response.statusCode == 200) {
      //   return ((productBody['products'] as List)
      //       .map((p) => Product.fromJson(p))
      //       .toList());
      // } else {
      //   throw Exception('Failed to get products');
      // }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Product>> getCategory(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      final categoryResponse = await http.get(
        Uri.parse("http://23.21.117.81:5000/api/categories?Fields=id%2Cname"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (categoryResponse.statusCode != 200) {
        throw Exception('Failed to get products');
      }
      final body = json.decode(categoryResponse.body);
      List<Category> categories = (body['categories'] as List)
          .map((p) => Category.fromJson(p))
          .toList();
      categories = categories.where((element) => element.name == name).toList();
      int categoryId = categories[0].id;
      final response = await http.get(
        Uri.parse("$url&CategoryId=$categoryId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final productBody = json.decode(response.body);
      if (response.statusCode == 200) {
        return ((productBody['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList());
      } else {
        throw Exception('Failed to get products');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Product>> getall() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        // if (body["jwt_token"] != null) {
        //   String? token = body["jwt_token"];
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   await prefs.setString('jwt_token', token);
        //   return "success";
        // } else {
        //   return body["status"][0];
        // }
        return ((body['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList());
      } else {
        throw Exception('Failed to get products');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Product>> getSearch(String searchText) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      print(searchText.toLowerCase());
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      List<Product> products =
          (body['products'] as List).map((p) => Product.fromJson(p)).toList();
      products = products
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      if (response.statusCode == 200) {
        // if (body["jwt_token"] != null) {
        //   String? token = body["jwt_token"];
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   await prefs.setString('jwt_token', token);
        //   return "success";
        // } else {
        //   return body["status"][0];
        // }
        return products;
      } else {
        throw Exception('Failed to get products');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CartModel>> getCartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      String? userId = prefs.getString('auth_userid');
      final response = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/shopping_cart_items?Fields=id%2Cproduct%2Cquantity&ShoppingCartType=ShoppingCart&CustomerId=$userId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        return (body['shopping_carts'] as List)
            .map((p) => CartModel.fromJson(p))
            .toList();
      } else {
        throw Exception('Failed to get cart items');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> addCartItem(int productId, int quantity) async {
    try {
      print(quantity);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      String? userId = prefs.getString('auth_userid');
      final response = await http.get(
        Uri.parse("http://23.21.117.81:5000/api/products/$productId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      final decode_product = body['products'][0];

      final cart_response = await http.post(
        Uri.parse("http://23.21.117.81:5000/api/shopping_cart_items"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "ObjectPropertyNameValuePairs": {},
          "shopping_cart_item": {
            "product_attributes": [
              {"value": "string", "id": 0}
            ],
            "customer_entered_price": 0,
            "quantity": quantity,
            "rental_start_date_utc": "2022-01-30T15:06:09.736Z",
            "rental_end_date_utc": "2022-01-31T15:06:09.736Z",
            "created_on_utc": "2022-01-29T15:06:09.736Z",
            "updated_on_utc": "2022-01-29T15:06:09.736Z",
            "shopping_cart_type": "ShoppingCart",
            "product_id": productId,
            "product": decode_product,
            "customer_id": userId,
            "id": 5
          }
        }),
      );
      if (cart_response.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> deleteCartItem(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      final response = await http.delete(
        Uri.parse("http://23.21.117.81:5000/api/shopping_cart_items/$id"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 'success';
      }
      return 'failed';
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CartModel>> getFavouriteItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      String? userId = prefs.getString('auth_userid');
      final response = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/shopping_cart_items?Fields=product%2Cquantity&ShoppingCartType=Wishlist&CustomerId=$userId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        return (body['shopping_carts'] as List)
            .map((p) => CartModel.fromJson(p))
            .toList();
      } else {
        throw Exception('Failed to get favourite items');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setFavouriteItem(int productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      String? userId = prefs.getString('auth_userid');
      final response = await http.get(
        Uri.parse("http://23.21.117.81:5000/api/products/$productId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      final decode_product = body['products'][0];

      final favourite_response = await http.post(
        Uri.parse("http://23.21.117.81:5000/api/shopping_cart_items"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "ObjectPropertyNameValuePairs": {},
          "shopping_cart_item": {
            "product_attributes": [
              {"value": "string", "id": 0}
            ],
            "customer_entered_price": 0,
            "quantity": 1,
            "rental_start_date_utc": "2022-01-30T15:06:09.736Z",
            "rental_end_date_utc": "2022-01-31T15:06:09.736Z",
            "created_on_utc": "2022-01-29T15:06:09.736Z",
            "updated_on_utc": "2022-01-29T15:06:09.736Z",
            "shopping_cart_type": "Wishlist",
            "product_id": productId,
            "product": decode_product,
            "customer_id": userId,
            "id": 5
          }
        }),
      );
      // print(favourite_response.statusCode);
      // print(favourite_response.body);
      if (favourite_response.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CategoryList>> getAllCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("bearer_token");
      final response = await http.get(
        Uri.parse(
            "http://23.21.117.81:5000/api/categories?Fields=name%2Cdescription%2Cimage%2Cid"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = json.decode(response.body);
      List<CategoryList> temp = (body['categories'] as List)
          .map((p) => CategoryList.fromJson(p))
          .toList();
      // print('hi');
      if (response.statusCode == 200) {
        // if (body["jwt_token"] != null) {
        //   String? token = body["jwt_token"];
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   await prefs.setString('jwt_token', token);
        //   return "success";
        // } else {
        //   return body["status"][0];
        // }
        return ((body['categories'] as List)
            .map((p) => CategoryList.fromJson(p))
            .toList());
      } else {
        throw Exception('Failed to get products');
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
