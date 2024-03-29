import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/model/produt_model.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';
import 'package:toy_app/widget/shopping/wrapPage.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  // provider setting
  AppState _appState;

  final ProductService _productService = ProductService();
  final TextEditingController _textCouponController = TextEditingController();
  List<CartModel> cartItems;
  // double _total_price = 0;
  String total_price = '0';
  String cart_count = '0';
  bool loading = false;
  String couponCode = "";
  bool isIncludingWrapPackage = false;
  int wrapPackageProductId = 0;
  int wrapPackageCartItemId = 0;
  ProductModel wrapPackageProduct;
  bool isApplyingCouponCode = false;
  Map<String, dynamic> orderTotalModel;
  // List<bool> checkValue = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    if (mounted) {
      setState(() {
        loading = true;
      });
      _appState = Provider.of<AppState>(context, listen: false);
      _productService.getCartItems().then((Map<String, dynamic> value) {
        cartItems = value['cartItemList'];
        for (var item in cartItems) {
          // _total_price += item.price * item.quantity;
          if (item.productName.toLowerCase().contains("التفاف")) {
            isIncludingWrapPackage = true;
            wrapPackageProductId = item.productId;
            wrapPackageCartItemId = item.id;
          }
        }
        orderTotalModel = value['orderTotalModel'];

        total_price = orderTotalModel['order_total'];
        cart_count = cartItems.length.toString();
        setState(() {
          loading = false;
        });
      }).catchError((err) {
        print(err);
        setState(() {
          loading = false;
        });
      });
    }
  }

  void deleteCartItem(int id) {
    _productService.deleteCartItem(id).then((value) {
      setState(() {
        loading = false;
      });
      if (value == "success") {
        Navigator.pushReplacementNamed(context, '/cart');
      }
    });
  }

  void _displayCouponCodeDialog(BuildContext context) {
    isApplyingCouponCode
        ? const Center(
            child: SizedBox(
              height: 30,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          )
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return WillPopScope(
                  onWillPop: () => Future.value(false),
                  child: AlertDialog(
                    title: const Text('Enter the coupon code'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          couponCode = value;
                        });
                      },
                      controller: _textCouponController,
                      decoration:
                          const InputDecoration(hintText: "Coupon Code"),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('CANCEL'),
                        onPressed: isApplyingCouponCode
                            ? null
                            : () {
                                setState(() {
                                  couponCode = "";
                                  _textCouponController.text = "";
                                  Navigator.pop(context);
                                });
                              },
                      ),
                      ElevatedButton(
                        child: isApplyingCouponCode
                            ? const Text("...Processing")
                            : const Text('OK'),
                        onPressed: isApplyingCouponCode
                            ? null
                            : () {
                                if (couponCode.isNotEmpty) {
                                  setState(() {
                                    isApplyingCouponCode = true;
                                  });
                                  _productService
                                      .applyDiscountCouponCode(couponCode)
                                      .then((value) {
                                    setState(() {
                                      isApplyingCouponCode = false;
                                      couponCode = "";
                                      _textCouponController.text = "";
                                    });
                                    if (value['ok']) {
                                      if (value['is_applied'] == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value['message']),
                                          backgroundColor: Colors.green,
                                        ));
                                        setState(() {
                                          orderTotalModel =
                                              value['orderTotalModel'];
                                          total_price = value['orderTotalModel']
                                              ['order_total'];
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value['message']),
                                          backgroundColor: Colors.red,
                                        ));
                                      }

                                      Navigator.pop(context);
                                    }
                                  }).catchError((err) {
                                    print(err);
                                    setState(() {
                                      isApplyingCouponCode = false;
                                      _textCouponController.text = "";
                                      couponCode = "";
                                    });
                                  });
                                }
                              },
                      ),
                    ],
                  ),
                );
              });
            });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Color(0xff283488),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 8, left: width * 0.05, right: width * 0.05),
                        child: Text(
                          AppLocalizations.of(context).cartpage_scart,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            letterSpacing: 0.02,
                            fontFamily: "Avenir Next",
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: width * 0.05,
                        ),
                        child: Text(
                          AppLocalizations.of(context).searchpage_text1 +
                              cart_count +
                              AppLocalizations.of(context).searchpage_text2,
                          style: const TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            fontFamily: "Avenir Next",
                          ),
                        ),
                      )
                    ],
                  ),
                  loading
                      ? const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : cartItems?.isEmpty ?? true
                          ? const Center(
                              child: Text("No Cart Item."),
                            )
                          : Center(
                              child: SizedBox(
                                height: height * 0.5,
                                width: width * 0.9,
                                child: ListView.builder(
                                  itemCount: cartItems.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailPageTest(
                                            productId:
                                                cartItems[index].productId);
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      margin: const EdgeInsets.only(
                                          bottom: 20, top: 20),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 1),
                                            blurRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(32.0),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              32.0)),
                                              child: cartItems[index]
                                                          .productImage
                                                          ?.isEmpty ??
                                                      true
                                                  ? Image.asset(
                                                      'assets/img/no_image.png',
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.network(
                                                      cartItems[index]
                                                          ?.productImage,
                                                      fit: BoxFit.fill,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.zero,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.zero,
                                                  height: height * 0.2,
                                                  width: width * 0.5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                height * 0.03,
                                                                width * 0.05,
                                                                0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              cartItems[index]
                                                                          ?.productName
                                                                          ?.isEmpty ??
                                                                      true
                                                                  ? ""
                                                                  : cartItems[index]
                                                                              .productName
                                                                              .toString()
                                                                              .length >
                                                                          15
                                                                      ? "${cartItems[index]?.productName?.substring(0, 15)}..."
                                                                      : cartItems[
                                                                              index]
                                                                          ?.productName,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Avenir Next',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: SizedBox(
                                                                height: 30,
                                                                width: 30,
                                                                child:
                                                                    RawMaterialButton(
                                                                  onPressed:
                                                                      () => {
                                                                    deleteCartItem(
                                                                        cartItems[index]
                                                                            .id)
                                                                  },
                                                                  elevation:
                                                                      1.0,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    size: 16.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(0),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                8,
                                                                width * 0.05,
                                                                0),
                                                        child: cartItems[index]
                                                                    .discount ==
                                                                null
                                                            ? Text(
                                                                'ر.س ${cartItems[index].unitPrice?.substring(1)}X${cartItems[index].quantity.toString()}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Avenir Next',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            : Column(
                                                                children: [
                                                                  // Text(
                                                                  //   'ر.س ${cartItems[index].unitPrice?.substring(1)}X${cartItems[index].quantity.toString()}',
                                                                  //   style:
                                                                  //       const TextStyle(
                                                                  //     fontFamily:
                                                                  //         'Avenir Next',
                                                                  //     fontSize:
                                                                  //         14,
                                                                  //     color: Colors
                                                                  //         .black,
                                                                  //     decoration:
                                                                  //         TextDecoration
                                                                  //             .lineThrough,
                                                                  //   ),
                                                                  // ),
                                                                  Text(
                                                                    'ر.س ${cartItems[index].unitPrice?.substring(1)}X${cartItems[index].quantity.toString()}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          'Avenir Next',
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                  opacity: animation,
                                  child: WrapPage(
                                      id: wrapPackageCartItemId,
                                      productId: wrapPackageProductId,
                                      product: wrapPackageProduct));
                            }),
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                      child: Text(
                        AppLocalizations.of(context).searchpage_text3,
                        style: const TextStyle(
                          fontFamily: 'Avenir Next',
                          fontSize: 14,
                          color: Color(0xff283488),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _displayCouponCodeDialog(context);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                      child: Text(
                        AppLocalizations.of(context).searchpage_coupon,
                        style: const TextStyle(
                          fontFamily: 'Avenir Next',
                          fontSize: 14,
                          color: Color(0xff283488),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          AppLocalizations.of(context).searchpage_Subtotal,
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 14,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          orderTotalModel == null
                              ? ""
                              : orderTotalModel['sub_total'] == null
                                  ? ""
                                  : "ر.س ${orderTotalModel['sub_total']?.toString()?.substring(1)}",
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1d1d1d),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          AppLocalizations.of(context).discount_title,
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 14,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          orderTotalModel == null
                              ? ""
                              : orderTotalModel['order_total_discount'] == null
                                  ? ""
                                  : "ر.س ${orderTotalModel['order_total_discount']?.toString()?.substring(1)}",
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1d1d1d),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          AppLocalizations.of(context).total_title,
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 14,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.05, 8, width * 0.05, 0),
                        child: Text(
                          orderTotalModel == null
                              ? ""
                              : orderTotalModel['order_total'] == null
                                  ? ""
                                  : "ر.س ${orderTotalModel['order_total']?.toString()?.substring(1)}",
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1d1d1d),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  if (_appState.user.isGuest != true) {
                    int _tmpCartCount = int.parse(cart_count.toString());
                    if (_tmpCartCount > 0) {
                      _appState.cartTotalPrice = total_price;
                      Navigator.pushNamed(context, '/delivery');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No Cart items."),
                        backgroundColor: Colors.orange,
                      ));
                    }
                  } else {
                    int _tmpCartCount = int.parse(cart_count.toString());
                    if (_tmpCartCount > 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context)
                                  .detailpage_checkout_guest),
                              actions: [
                                ElevatedButton(
                                  child: Text(AppLocalizations.of(context)
                                      .detailpage_ok),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/delivery');
                                  },
                                ),
                                ElevatedButton(
                                  child: Text(AppLocalizations.of(context)
                                      .detailpage_cancel),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(AppLocalizations.of(context)
                                          .login_plogin),
                                      backgroundColor: Colors.orange,
                                    ));
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No Cart items."),
                        backgroundColor: Colors.orange,
                      ));
                    }
                  }

                  // _appState.cartTotalPrice = total_price;
                  //   Navigator.pushNamed(context, '/delivery');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff283488)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(83.0),
                      side: const BorderSide(color: Color(0xff283488)),
                    ),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).searchpage_checkout,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
