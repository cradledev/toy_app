import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  final ProductService _productService = ProductService();
  late Future<List<CartModel>> cartItems;
  double _total_price = 0;
  String total_price = '0';
  String cart_count = '0';
  List<bool> checkValue = [];
  @override
  void initState() {
    super.initState();
    cartItems = _productService.getCartItems();
    for (int j = 0; j < 50; j++) {
      checkValue.add(false);
    }
    cartItems.then((value) {
      for (int i = 0; i < value.length; i++) {
        _total_price += value[i].quantity.toDouble() * value[i].product.price;
      }
      setState(() {
        total_price = _total_price.toStringAsFixed(2);
        cart_count = value.length.toString();
      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    void deleteCartItem(int id) async {
      String response = await _productService.deleteCartItem(id);
      if (response == 'success') {
        Navigator.pushReplacementNamed(context, '/cart');
      }
    }

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        leadingAction: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 30, left: width * 0.05, right: width * 0.05),
                  child: Text(
                    AppLocalizations.of(context)!.cartpage_scart,
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
                    vertical: 15,
                    horizontal: width * 0.05,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.searchpage_text1 +
                        cart_count +
                        AppLocalizations.of(context)!.searchpage_text2,
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
            FutureBuilder(
              future: cartItems,
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? SizedBox(
                          height: height * 0.5,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                              onTap: () {
                                setState(() {
                                  checkValue[index] = !checkValue[index];
                                });
                                if (checkValue[index] == true) {}
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: height * 0.2,
                                            width: width * 0.4,
                                            margin: EdgeInsets.only(
                                              left: width * 0.04,
                                              bottom: height * 0.02,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index]
                                                .product
                                                .images[0]
                                                .src),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(32.0),
                                                    bottomLeft:
                                                        Radius.circular(32.0)),
                                                color: Colors.white),
                                          ),
                                          Positioned(
                                            top: height * 0.02,
                                            left: width * 0.02,
                                            child: checkValue[index]
                                                ? const Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    size: 30.0,
                                                    color: Colors.blue,
                                                  )
                                                : const Icon(
                                                    Icons.circle,
                                                    size: 30.0,
                                                    color: Colors.blue,
                                                  ),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: height * 0.2,
                                            width: width * 0.5,
                                            margin: EdgeInsets.only(
                                              bottom: height * 0.02,
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              width * 0.05,
                                                              height * 0.03,
                                                              0,
                                                              0),
                                                      child: Text(
                                                        snapshot.data?[index]
                                                            .product.name,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Avenir Next',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              width * 0.05,
                                                              8,
                                                              0,
                                                              0),
                                                      child: Text(
                                                        '\$' +
                                                            snapshot
                                                                .data![index]
                                                                .product
                                                                .price
                                                                .toString() +
                                                            ' * ' +
                                                            snapshot
                                                                .data![index]
                                                                .quantity
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Avenir Next',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(32.0),
                                                  bottomRight:
                                                      Radius.circular(32.0)),
                                              color: Colors.white,
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.02,
                                            right: width * 0.05,
                                            child: InkWell(
                                              onTap: () => {
                                                deleteCartItem(
                                                    snapshot.data![index].id)
                                              },
                                              child: const Icon(
                                                  Icons.close_rounded),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            ),
            InkWell(
              onTap: () => {
                Navigator.pushNamed(context, '/wrap'),
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                child: Text(
                  AppLocalizations.of(context)!.searchpage_text3,
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
              onTap: () => {},
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                child: Text(
                  AppLocalizations.of(context)!.searchpage_coupon,
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
                  padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                  child: Text(
                    AppLocalizations.of(context)!.searchpage_Subtotal,
                    style: const TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 14,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                  child: Text(
                    '\$' + total_price,
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
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
              child: SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/delivery');
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
                    AppLocalizations.of(context)!.searchpage_checkout,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
