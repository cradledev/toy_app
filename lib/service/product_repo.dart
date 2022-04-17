// import 'package:toy_app/model/toy_detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/model/category_model.dart';
import 'package:toy_app/model/category_list_model.dart';
import 'package:toy_app/model/manufacture_model.dart';
import 'package:toy_app/model/manufacture_mapping.dart';
import 'package:toy_app/model/cart_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/helper/constant.dart';
import 'package:toy_app/model/product.dart';

class ProductService {
  // var url = Uri.http('192.168.116.40:5000/', '/api/products', {'q': '{http}'});
  String url =
      "http://23.21.117.81:5000/api/products?Fields=id%2Cname%2Cshort_description%2Cfull_description%2Cprice%2Capproved_rating_sum%2Cimages&PublishedStatus=true";

  Future<List<Product>> getManufacture(String name) async {
    try {
      //Get Manufacture ID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("bearer_token");
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
      String token = prefs.getString("bearer_token");
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
      String token = prefs.getString("bearer_token");
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
      String token = prefs.getString("bearer_token");
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

  Future<List<CartModel>> getCartItems(String userId) async {
    try {
      final response = await http.get(
        Uri.parse("$apiEndPoint/orders/getCart/$userId"),
        headers: customHeaders,
      );
      final body = json.decode(response.body);
      if (body['ok']) {
        return (body['orderItems'] as List)
            .map((p) => CartModel.fromJson(p))
            .toList();
      } else {
        throw Exception('Failed to get cart items');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> addCartItem(
      String productId, int quantity, double price, String _clientID) async {
    try {
      print(quantity);
      final cartResponse = await http.post(
        Uri.parse("$apiEndPoint/orders/addCart"),
        headers: customHeaders,
        body: jsonEncode({
          'productId': productId,
          'qty': quantity,
          'price': price,
          'userId': _clientID
        }),
      );
      var body = jsonDecode(cartResponse.body);
      if (body['ok']) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> deleteCartItem(String userId, String productId) async {
    try {
      final response = await http.post(
          Uri.parse("$apiEndPoint/orders/removeCartItem"),
          headers: customHeaders,
          body: jsonEncode({'productId': productId, 'userId': userId}));
      var body = jsonDecode(response.body);
      if (body['ok']) {
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
      String token = prefs.getString("bearer_token");
      String userId = prefs.getString('auth_userid');
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

  Future<int> getCartByProductId(String userId, String productId) async {
    try {
      final response = await http.post(
          Uri.parse("$apiEndPoint/orders/getCartByProductId"),
          headers: customHeaders,
          body: jsonEncode({'productId': productId, 'userId': userId}));
      var body = jsonDecode(response.body);
      if (body['ok']) {
        return int.parse(body['qty'].toString());
      }
      return int.parse(0.toString());
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setFavouriteItem(String userId, String productId) async {
    try {
      final response = await http.post(Uri.parse("$apiEndPoint/wishlist"),
          headers: customHeaders,
          body: jsonEncode({'productId': productId, 'userId': userId}));
      var body = jsonDecode(response.body);
      if (body['ok']) {
        return "success";
      } else {
        return "something went wrong.";
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<List<CategoryList>> getAllCategories(page, perPage) async {
    try {
      final response = await http.post(
          Uri.parse("$apiEndPoint/categories/allCategories"),
          body: jsonEncode({"page": page, "perPage": perPage}),
          headers: customHeaders);
      final body = json.decode(response.body);

      if (body['ok'] == true) {
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

  // get new arrival products
  static Future<List<ProductModel>> getNewArrival(page, perPage) async {
    var response = await http.post(
        Uri.parse("$apiEndPoint/products/newarrival"),
        body: jsonEncode({"page": page, "perPage": perPage}),
        headers: customHeaders);
    var body = jsonDecode(response.body);
    // print(body['total']);
    var arrivalList = (body['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
    arrivalList ??= List<ProductModel>.empty();
    return arrivalList;
  }

  // get recommend products
  static Future<List<ProductModel>> getRecommendProduct(page, perPage) async {
    var response = await http.post(
        Uri.parse("$apiEndPoint/products/getRecommendProducts"),
        body: jsonEncode({"page": page, "perPage": perPage}),
        headers: customHeaders);
    var body = jsonDecode(response.body);
    // print(body['total']);
    var arrivalList = (body['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
    arrivalList ??= List<ProductModel>.empty();
    return arrivalList;
  }

  // get products by category slug name
  static Future<List<ProductModel>> getProductsByCategorySlug(
      page, perPage, String slug) async {
    print(slug.toLowerCase());
    var response = await http.post(
        Uri.parse("$apiEndPoint/products/getProductsByCategroySlug"),
        body: jsonEncode(
            {"page": page, "perPage": perPage, "slug": slug.toLowerCase()}),
        headers: customHeaders);
    var body = jsonDecode(response.body);
    print(body['total']);
    var categoryProductList = (body['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
    categoryProductList ??= List<ProductModel>.empty();

    return categoryProductList;
  }

  static Future<List<ProductModel>> searchProductsByName(
      page, perPage, String slug) async {
    var response = await http.post(
        Uri.parse("$apiEndPoint/products/searchProduct"),
        body: jsonEncode({"page": page, "perPage": perPage, "q": slug}),
        headers: customHeaders);
    var body = jsonDecode(response.body);
    print(body['total']);
    var productList = (body['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
    productList ??= List<ProductModel>.empty();

    return productList;
  }
}
