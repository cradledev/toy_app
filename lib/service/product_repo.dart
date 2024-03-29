// import 'package:toy_app/model/toy_detail.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/model/category_list_model.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/helper/constant.dart';
import 'package:toy_app/model/product_detail_model.dart';
import 'package:toy_app/model/produt_model.dart';

class ProductService {
  Future<Map<String, dynamic>> getCartItems() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      customHeaders["Authorization"] = "Bearer $_token";
      var response = await http.get(Uri.parse("$apiEndPoint/ShoppingCart/Cart"),
          headers: customHeaders);
      var _body = jsonDecode(response.body);
      List<CartModel> cartItemList = [];
      if ((_body['items'] as List).isNotEmpty) {
        cartItemList =
            (_body['items'] as List).map((e) => CartModel.fromJson(e)).toList();
      }

      // cartItemList ?? List<ProductModel>.empty();
      var orderTotalModel = await getOrderTotalModelForShoppingCart();
      return {'cartItemList': cartItemList, 'orderTotalModel': orderTotalModel};
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setshippingdress(String _fname, String _lname, String _mail,
      String _address, String _city, String _postcode) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var res = await http.post(
        Uri.parse("$apiEndPoint/Checkout/NewBillingAddress"),
        body: jsonEncode({
          "model": {
            "existing_addresses": [
              {
                "first_name": "string",
                "last_name": "string",
                "email": "string",
                "company_enabled": true,
                "company_required": true,
                "company": "string",
                "country_enabled": true,
                "country_id": 0,
                "country_name": "string",
                "state_province_enabled": true,
                "state_province_id": 0,
                "state_province_name": "string",
                "county_enabled": true,
                "county_required": true,
                "county": "string",
                "city_enabled": true,
                "city_required": true,
                "city": "string",
                "street_address_enabled": true,
                "street_address_required": true,
                "address1": "string",
                "street_address2_enabled": true,
                "street_address2_required": true,
                "address2": "string",
                "zip_postal_code_enabled": true,
                "zip_postal_code_required": true,
                "zip_postal_code": "string",
                "phone_enabled": true,
                "phone_required": true,
                "phone_number": "string",
                "fax_enabled": true,
                "fax_required": true,
                "fax_number": "string",
                "available_countries": [
                  {
                    "disabled": true,
                    "group": {"disabled": true, "name": "string"},
                    "selected": true,
                    "text": "string",
                    "value": "string"
                  }
                ],
                "available_states": [
                  {
                    "disabled": true,
                    "group": {"disabled": true, "name": "string"},
                    "selected": true,
                    "text": "string",
                    "value": "string"
                  }
                ],
                "formatted_custom_address_attributes": "string",
                "custom_address_attributes": [
                  {
                    "name": "string",
                    "is_required": true,
                    "default_value": "string",
                    "attribute_control_type": "DropdownList",
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
                    "id": 0,
                    "custom_properties": {
                      "additionalProp1": "string",
                      "additionalProp2": "string",
                      "additionalProp3": "string"
                    }
                  }
                ],
                "id": 0,
                "custom_properties": {
                  "additionalProp1": "string",
                  "additionalProp2": "string",
                  "additionalProp3": "string"
                }
              }
            ],
            "invalid_existing_addresses": [
              {
                "first_name": "string",
                "last_name": "string",
                "email": "string",
                "company_enabled": true,
                "company_required": true,
                "company": "string",
                "country_enabled": true,
                "country_id": 0,
                "country_name": "string",
                "state_province_enabled": true,
                "state_province_id": 0,
                "state_province_name": "string",
                "county_enabled": true,
                "county_required": true,
                "county": "string",
                "city_enabled": true,
                "city_required": true,
                "city": "string",
                "street_address_enabled": true,
                "street_address_required": true,
                "address1": "string",
                "street_address2_enabled": true,
                "street_address2_required": true,
                "address2": "string",
                "zip_postal_code_enabled": true,
                "zip_postal_code_required": true,
                "zip_postal_code": "string",
                "phone_enabled": true,
                "phone_required": true,
                "phone_number": "string",
                "fax_enabled": true,
                "fax_required": true,
                "fax_number": "string",
                "available_countries": [
                  {
                    "disabled": true,
                    "group": {"disabled": true, "name": "string"},
                    "selected": true,
                    "text": "string",
                    "value": "string"
                  }
                ],
                "available_states": [
                  {
                    "disabled": true,
                    "group": {"disabled": true, "name": "string"},
                    "selected": true,
                    "text": "string",
                    "value": "string"
                  }
                ],
                "formatted_custom_address_attributes": "string",
                "custom_address_attributes": [
                  {
                    "name": "string",
                    "is_required": true,
                    "default_value": "string",
                    "attribute_control_type": "DropdownList",
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
                    "id": 0,
                    "custom_properties": {
                      "additionalProp1": "string",
                      "additionalProp2": "string",
                      "additionalProp3": "string"
                    }
                  }
                ],
                "id": 0,
                "custom_properties": {
                  "additionalProp1": "string",
                  "additionalProp2": "string",
                  "additionalProp3": "string"
                }
              }
            ],
            "billing_new_address": {
              "first_name": _fname,
              "last_name": _lname,
              "email": _mail,
              "company_enabled": true,
              "company_required": true,
              "company": "",
              "country_enabled": true,
              "country_id": 243,
              "country_name": "Saudi Arabia",
              "state_province_enabled": false,
              "state_province_id": null,
              "state_province_name": "",
              "county_enabled": false,
              "county_required": false,
              "county": "Saudi Arabia",
              "city_enabled": true,
              "city_required": true,
              "city": _city,
              "street_address_enabled": true,
              "street_address_required": true,
              "address1": _address,
              "street_address2_enabled": false,
              "street_address2_required": false,
              "address2": "",
              "zip_postal_code_enabled": true,
              "zip_postal_code_required": true,
              "zip_postal_code": _postcode,
              "phone_enabled": true,
              "phone_required": true,
              "phone_number": "",
              "fax_enabled": true,
              "fax_required": true,
              "fax_number": "",
              "available_countries": [
                {
                  "disabled": true,
                  "group": {"disabled": true, "name": "string"},
                  "selected": true,
                  "text": "string",
                  "value": "string"
                }
              ],
              "available_states": [
                {
                  "disabled": true,
                  "group": {"disabled": true, "name": "string"},
                  "selected": true,
                  "text": "string",
                  "value": "string"
                }
              ],
              "formatted_custom_address_attributes": "string",
              "custom_address_attributes": [
                {
                  "name": "string",
                  "is_required": true,
                  "default_value": "string",
                  "attribute_control_type": "DropdownList",
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
                  "id": 0,
                  "custom_properties": {
                    "additionalProp1": "string",
                    "additionalProp2": "string",
                    "additionalProp3": "string"
                  }
                }
              ],
              "id": 0,
              "custom_properties": {
                "additionalProp1": "string",
                "additionalProp2": "string",
                "additionalProp3": "string"
              }
            },
            "ship_to_same_address": true,
            "ship_to_same_address_allowed": true,
            "new_address_preselected": true,
            "custom_properties": {
              "additionalProp1": "string",
              "additionalProp2": "string",
              "additionalProp3": "string"
            }
          },
          "form": {
            "additionalProp1": "string",
            "additionalProp2": "string",
            "additionalProp3": "string"
          }
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      if (res.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setPaymentMethod(String paymethond) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var res = await http.post(
        Uri.parse(
            "$apiEndPoint/Checkout/SelectPaymentMethod?paymentMethod=$paymethond"),
        body: jsonEncode({
          "payment_methods": [
            {
              "payment_method_system_name": paymethond,
              "name": "string",
              "description": "string",
              "fee": "string",
              "selected": true,
              "logo_url": "string",
              "custom_properties": {
                "additionalProp1": "string",
                "additionalProp2": "string",
                "additionalProp3": "string"
              }
            }
          ],
          "display_reward_points": true,
          "reward_points_balance": 0,
          "reward_points_amount": "string",
          "reward_points_enough_to_pay_for_order": true,
          "use_reward_points": true,
          "custom_properties": {
            "additionalProp1": "string",
            "additionalProp2": "string",
            "additionalProp3": "string"
          }
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );

      if (res.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> confirmOrder() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var res = await http.get(
        Uri.parse("$apiEndPoint/Checkout/ConfirmOrder"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_payment_url'];
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setFavouriteItem(
      int _clientID, int productId, int quantity) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var cartResponse = await http.post(
        Uri.parse(
            "$backendEndpoint/ShoppingCartItem/AddToCart/$_clientID/$productId/0?shoppingCartType=Wishlist&customerEnteredPrice=0&quantity=$quantity&addRequiredProducts=true"),
        body: jsonEncode("string"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );

      if (cartResponse.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<CartModel>> getFavouriteItems(int _pCustomerId) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var response = await http.get(
        Uri.parse(
            "$backendEndpoint/ShoppingCartItem/GetShoppingCart/$_pCustomerId?shoppingCartType=Wishlist&storeId=0"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      var _body = jsonDecode(response.body);
      List<CartModel> cartItemList = [];
      if ((_body as List).isNotEmpty) {
        for (var item in _body) {
          var productDetail = await getProductDetailById(item['product_id']);
          var _json = {
            'id': item['id'],
            'unit_price': "p${productDetail.price.toString()}",
            'quantity': item['quantity'],
            'product_id': productDetail.id,
            'product_name': productDetail.name,
            'picture': {'image_url': productDetail.image}
          };
          var tmp = CartModel.fromJson(_json);
          cartItemList.add(tmp);
        }
      } else {
        cartItemList = [];
      }

      cartItemList ?? List<ProductModel>.empty();
      return cartItemList;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> applyDiscountCouponCode(
      String _pCouponCode) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var res = await http.post(
        Uri.parse(
            "$apiEndPoint/ShoppingCart/ApplyDiscountCoupon?discountCouponCode=$_pCouponCode"),
        body: jsonEncode({
          "checkout_attribute_1": 1,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      var _body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        var orderTotalModel = await getOrderTotalModelForShoppingCart();
        return {
          'ok': true,
          'message': _body['discount_box']['messages'][0],
          'is_applied': _body['discount_box']['is_applied'],
          'orderTotalModel': orderTotalModel,
        };
      } else {
        return {'ok': false, 'message': "Failed", 'is_applied': false};
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getOrderTotalModelForShoppingCart() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';

      var res = await http.post(
        Uri.parse("$apiEndPoint/ShoppingCart/CheckoutAttributeChange"),
        body: jsonEncode({
          "checkout_attribute_1": 1,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      var _orderTotalBody = jsonDecode(res.body);
      return {
        'ok': true,
        'sub_total': _orderTotalBody['order_totals_model']['sub_total'],
        'order_total_discount': _orderTotalBody['order_totals_model']
            ['order_total_discount'],
        'order_total': _orderTotalBody['order_totals_model']['order_total'],
        'shipping': _orderTotalBody['order_totals_model']['shipping'],
        'tax': _orderTotalBody['order_totals_model']['tax'],
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCartItem(int productId, int quantity, int _clientID) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      var cartResponse = await http.post(
        Uri.parse(
            "$apiEndPoint/ShoppingCart/AddProductToCartFromCatalog/$productId?shoppingCartType=ShoppingCart&quantity=$quantity"),
        body: jsonEncode("string"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      var body = jsonDecode(cartResponse.body);
      if (cartResponse.statusCode == 200) {
        return "success";
      } else {
        throw Exception(body['errors'].toString());
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<String> deleteCartItem(int cartItemId) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      print(cartItemId);
      final response = await http.delete(
        Uri.parse(
            "$backendEndpoint/ShoppingCartItem/Delete/$cartItemId?resetCheckoutData=true&ensureOnlyActiveCheckoutAttributes=false"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        },
      );
      // var body = jsonDecode(response.body);
      // print(body);
      if (response.statusCode == 200) {
        return 'success';
      }
      return 'failed';
    } catch (err) {
      rethrow;
    }
  }

  static Future<List<CategoryList>> getAllCategories() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      customHeaders['Authorization'] = "Bearer $_token";
      final response = await http.get(
          Uri.parse("$apiEndPoint/Catalog/GetCatalogRoot"),
          headers: customHeaders);
      // final response = await http.get(
      //     Uri.parse(
      //         "$backendEndpoint/Category/GetAllCategoriesByParentCategoryId/0?showHidden=false"),
      //     headers: customHeaders);

      List<CategoryList> categoryProductList = [];
      if (response.statusCode == 200) {
        var _body = json.decode(response.body);
        if ((_body as List).isEmpty) {
          categoryProductList = List<CategoryList>.empty();
        } else {
          print(_body);
          // List referValues = ["warp"];
          // List _bodyList = (_body['items'] as List);
          // _bodyList.removeWhere(
          //     (element) => element['name'].toString().toLowerCase() == "wrap");
          // Map _payloads = {
          //   "price": "string",
          //   "specification_option_ids": [0],
          //   "manufacturer_ids": [0],
          //   "order_by": 0,
          //   "view_mode": "string",
          //   "page_index": 0,
          //   "page_number": 1,
          //   "page_size": 3,
          //   "total_items": 0,
          //   "total_pages": 0,
          //   "first_item": 0,
          //   "last_item": 0,
          //   "has_previous_page": true,
          //   "has_next_page": true,
          //   "custom_properties": {
          //     "additionalProp1": "string",
          //     "additionalProp2": "string",
          //     "additionalProp3": "string"
          //   }
          // };
          // for (var item in _body) {
          //   var _tmpResult = await http.post(
          //       Uri.parse("$apiEndPoint/Catalog/GetCategory/${item['id']}"),
          //       body: jsonEncode(_payloads),
          //       headers: customHeaders);
          //   var _tmpBody = jsonDecode(_tmpResult.body);
          //   var tmp = CategoryList.fromJson(item,
          //       _tmpBody['category_model_dto']['picture_model']['image_url']);
          //   categoryProductList.add(tmp);
          // }
            
            categoryProductList = (_body as List).map((e) => CategoryList.fromJson(e, "")).toList();
        }
        return categoryProductList;
      } else {
        throw Exception('Failed to get products');
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // get new arrival products
  Future<List<ProductModel>> getNewArrival() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    List<ProductModel> categoryProductList = [];
    try {
      var response = await http.get(
          Uri.parse("$apiEndPoint/Product/NewProducts"),
          headers: customHeaders);
      var _body = jsonDecode(response.body);
      categoryProductList =
          (_body as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return categoryProductList;

    // var response = await http.get(
    //     Uri.parse("$backendEndpoint/Product/GetProductsMarkedAsNew?storeId=0"),
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Access-Control-Allow-Origin': '*',
    //       "Authorization": "Bearer $_token"
    //     });
    // var _body = jsonDecode(response.body);
    // List<ProductModel> categoryProductList = [];
    // for (var item in _body) {
    //   var _imageAndCategories = await getImageUrlsByProductId(id: item['id']);
    //   var tmp = ProductM.fromJson(item, _imageAndCategories);
    //   categoryProductList.add(tmp);
    // }
    // return categoryProductList;
  }

  // get recommend products
  static Future<List<ProductModel>> getRecommendProduct(page, perPage) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    var response = await http.get(
        Uri.parse("$apiEndPoint/Product/RecentlyViewedProducts"),
        headers: customHeaders);
    var _body = jsonDecode(response.body);
    List<ProductModel> categoryProductList = [];
    for (var item in _body) {
      // var _imageAndCategories = await getImageUrlsByProductId(id: item['id']);
      var tmp = ProductModel.fromJson(item);
      categoryProductList.add(tmp);
    }
    return categoryProductList;
  }

  // get products by category slug name
  static Future<List<ProductModel>> getProductsByCategoryId(
      page, perPage, String slug) async {
    String _slug = slug.toLowerCase();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    var response = await http.get(
        Uri.parse(
            "$backendEndpoint/Category/GetAll?categoryName=$_slug&storeId=0&pageIndex=0&pageSize=2147483647&showHidden=false"),
        headers: customHeaders);
    var body = jsonDecode(response.body);

    List<ProductModel> categoryProductList = [];
    if ((body['items'] as List).isNotEmpty) {
      int _categoryId = body['items'][0]['id'];
      Map _payloads = {
        "price": "string",
        "specification_option_ids": [0],
        "manufacturer_ids": [0],
        "order_by": 0,
        "view_mode": "string",
        "page_index": page,
        "page_number": page + 1,
        "page_size": perPage,
        "total_items": 0,
        "total_pages": 0,
        "first_item": 0,
        "last_item": 0,
        "has_previous_page": true,
        "has_next_page": true,
        "custom_properties": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      };
      var res = await http.post(
          Uri.parse("$apiEndPoint/Catalog/GetCategoryProducts/$_categoryId"),
          body: jsonEncode(_payloads),
          headers: customHeaders);
      var _body = jsonDecode(res.body);
      categoryProductList =
          (_body['catalog_products_model']['products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
    }
    return categoryProductList;
  }

  static Future<List<ProductModel>> getProductsByDirectCategoryId(
      page, perPage, int categoryId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    List<ProductModel> categoryProductList = [];
    Map _payloads = {
      "price": "string",
      "specification_option_ids": [0],
      "manufacturer_ids": [0],
      "order_by": 0,
      "view_mode": "string",
      "page_index": page,
      "page_number": page + 1,
      "page_size": perPage,
      "total_items": 0,
      "total_pages": 0,
      "first_item": 0,
      "last_item": 0,
      "has_previous_page": true,
      "has_next_page": true,
      "custom_properties": {
        "additionalProp1": "string",
        "additionalProp2": "string",
        "additionalProp3": "string"
      }
    };
    var res = await http.post(
        Uri.parse("$apiEndPoint/Catalog/GetCategoryProducts/$categoryId"),
        body: jsonEncode(_payloads),
        headers: customHeaders);
    var _body = jsonDecode(res.body);
    categoryProductList = (_body['catalog_products_model']['products'] as List)
        .map((e) {
          return ProductModel.fromJson(e);
        })
        .toList();
    return categoryProductList;
  }

  static Future<List<ProductModel>> searchProductsByName(
      page, perPage, String slug) async {
    String _slug = slug.toLowerCase();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';

    var _prodcutResponse = await http.get(
        Uri.parse(
            "$backendEndpoint/Product/GetAll?pageIndex=$page&pageSize=$perPage&storeId=0&vendorId=0&warehouseId=0&visibleIndividuallyOnly=false&excludeFeaturedProducts=false&productTagId=0&keywords=$_slug&searchDescriptions=true&searchManufacturerPartNumber=true&searchSku=true&searchProductTags=false&languageId=0&showHidden=true"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
          "Authorization": "Bearer $_token"
        });
    var _body = jsonDecode(_prodcutResponse.body);
    List<ProductModel> categoryProductList = [];
    if ((_body['items'] as List).isEmpty) {
      categoryProductList = List<ProductModel>.empty();
    } else {
      for (var item in _body['items']) {
        // var _imageAndCategories = await getImageUrlsByProductId(id: item['id']);
        var tmp = ProductModel.fromJson(item);
        categoryProductList.add(tmp);
      }
      categoryProductList ?? List<ProductModel>.empty();
    }

    // print(categoryProductList[0].name);
    return categoryProductList;
  }

  static Future<Map<String, dynamic>> getImageUrlsByProductId(
      {id = 0, bool featured = false}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = _prefs.getString("token") ?? '';
      customHeaders['Authorization'] = "Bearer $_token";
      // print(id);

      // var _productDetails = await http.get(
      //     Uri.parse(
      //         "$apiEndPoint/Product/GetProductDetails/$id?updateCartItemId=0"),
      //     headers: customHeaders);
      // var _detailBody = jsonDecode(_productDetails.body);
      // print(1);
      // List<String> imgList = [];
      // List<String> detailImagList = [];
      // if (featured) {
      //   for (var item in _detailBody['product_details_model']
      //       ['picture_models']) {
      //     imgList.add(item['image_url']);
      //   }
      // } else {
      //   for (var item in _detailBody['product_details_model']
      //       ['picture_models']) {
      //     imgList.add(item['thumb_image_url']);
      //   }
      // }
      // for (var item in _detailBody['product_details_model']['picture_models']) {
      //   detailImagList.add(item['image_url']);
      // }

      // var _productCategory = {
      //   'id': _detailBody['product_details_model']['breadcrumb']
      //       ['category_breadcrumb'][0]['id'],
      //   'name': _detailBody['product_details_model']['breadcrumb']
      //       ['category_breadcrumb'][0]['name']
      // };
      // return {
      //   'images': imgList,
      //   'detailImages': detailImagList,
      //   'category': _productCategory
      // };

      var _productCategoryRes = await http.get(
          Uri.parse(
              "$backendEndpoint/ProductCategory/GetProductCategoriesByProductId/$id?showHidden=false"),
          headers: customHeaders);
      var _body = jsonDecode(_productCategoryRes.body);
      int _productCategoryId = _body[0]['category_id'];
      var _categoryDetailRes = await http.get(
          Uri.parse("$backendEndpoint/Category/GetById/$_productCategoryId"),
          headers: customHeaders);
      var _body1 = jsonDecode(_categoryDetailRes.body);
      // get product images
      var response = await http.get(
          Uri.parse(
              "$backendEndpoint/ProductPictures/GetProductPicturesByProductId/$id"),
          headers: customHeaders);
      var body = jsonDecode(response.body);
      if ((body as List).isNotEmpty) {
        List<int> _imgIds =
            (body as List).map((e) => e['picture_id'] as int).toList();
        List<String> imgList = [];
        List<String> detailImagList = [];
        for (int item in _imgIds) {
          var _tmpResult = await http.get(
              Uri.parse(
                  "$backendEndpoint/Picture/GetPictureUrl/$item?targetSize=550&showDefaultPicture=true"),
              headers: customHeaders);
          var _tmpBody = jsonDecode(_tmpResult.body);
          imgList.add(_tmpBody['url']);
          detailImagList.add(_tmpBody['url']);
        }

        return {
          'images': imgList,
          'detailImages': detailImagList,
          'category': {
            'id': _body1['id'],
            'name': _body1['name'],
          }
        };
      } else {
        return {
          'images': [],
          'detailImages': [],
          'category': {
            'id': _body1['id'],
            'name': _body1['name'],
          }
        };
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ProductDetailModel> getProductDetailById(int _id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    try {
      var _productDetails = await http.get(
          Uri.parse(
              "$apiEndPoint/Product/GetProductDetails/$_id?updateCartItemId=0"),
          headers: customHeaders);
      var _detailBody = jsonDecode(_productDetails.body);
      return ProductDetailModel.fromJson(_detailBody['product_details_model']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getShoppingMiniCart(int _productId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString("token") ?? '';
    customHeaders["Authorization"] = "Bearer $_token";
    var _productDetails = await http.get(
        Uri.parse("$apiEndPoint/ShoppingCart/Cart"),
        headers: customHeaders);
    var _body = jsonDecode(_productDetails.body);
    var _carts = _body['items'] as List;
    var product =
        _carts.where((val) => val['product_id'] == _productId).toList();
    if (product.isEmpty) {
      return {'quantity': 0, 'shoppingCartItemId': 0};
    } else {
      return {
        'quantity': product[0]['quantity'],
        'shoppingCartItemId': product[0]['id']
      };
    }
  }

  // get new products on home screen
  Future<List<Map<String, dynamic>>> onGetNewProducts(String _token) async {
    try {
      customHeaders['Authorization'] = "Bearer $_token";
      var res = await http.get(Uri.parse("$apiEndPoint/Product/NewProducts"),
          headers: customHeaders);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<Map<String, dynamic>> _imgList = (body as List)
            .map((e) => {
                  'image': e['default_picture_model']['image_url'].toString(),
                  'name': e['name'].toString()
                })
            .toList();
        return _imgList;
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get Popular products (this is sorted by quantity)
  static Future<List<ProductModel>> onGetPopularProducts(
      {pageSize, pageIndex, token}) async {
    try {
      customHeaders['Authorization'] = "Bearer $token";
      var res = await http.get(
          Uri.parse(
              "$backendEndpoint/OrderReport/BestSellersReport?categoryId=0&manufacturerId=0&storeId=0&vendorId=0&billingCountryId=0&pageIndex=$pageIndex&pageSize=$pageSize&showHidden=false"),
          headers: customHeaders);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<ProductModel> categoryProductList = [];
        if (body['total_count'] > 0) {
          for (var item in body['items']) {
            var _productDetails = await http.get(
                Uri.parse(
                    "$apiEndPoint/Product/GetProductDetails/${item['product_id']}?updateCartItemId=0"),
                headers: customHeaders);
            var _detailBody = jsonDecode(_productDetails.body);
            categoryProductList.add(
                ProductModel.fromJson(_detailBody['product_details_model']));
          }
          return categoryProductList;
        } else {
          return List<ProductModel>.empty();
        }
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  // top collection products
  static Future<List<ProductModel>> onGetTopCollectionProducts(
      {pageSize, pageIndex, token}) async {
    try {
      customHeaders['Authorization'] = "Bearer $token";
      var res = await http.get(Uri.parse("$apiEndPoint/Catalog/ProductTagsAll"),
          headers: customHeaders);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        if (body['total_count'] == 0) {
          return List<ProductModel>.empty();
        } else {
          List<dynamic> _productIds =
              body['items'].map((e) => e['product_id']).toList();
          _productIds ?? List<dynamic>.empty();
          if (_productIds.isNotEmpty) {
            String _implodeIds = _productIds.join(";");
            var _productsRes = await http.get(
              Uri.parse(
                  "$backendEndpoint/Product/GetProductsByIds/$_implodeIds"),
              headers: customHeaders,
            );
            List<ProductModel> categoryProductList = <ProductModel>[];
            for (var item in jsonDecode(_productsRes.body)) {
              // var _imageAndCategories =
              //     await getImageUrlsByProductId(id: item['id']);
              ProductModel tmp = ProductModel.fromJson(item);
              categoryProductList.add(tmp);
            }
            return categoryProductList;
          } else {
            return List<ProductModel>.empty();
          }
        }
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
