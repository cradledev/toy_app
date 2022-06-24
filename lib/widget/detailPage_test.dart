import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:toy_app/model/product_detail_model.dart';
import 'package:toy_app/model/produt_model.dart';

import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

class DetailPageTest extends StatefulWidget {
  const DetailPageTest({Key key, this.productId}) : super(key: key);
  final int productId;
  static const routeName = '/test';

  @override
  State<DetailPageTest> createState() => _DetailPageTest();
}

class _DetailPageTest extends State<DetailPageTest> {
  // app state import
  // provider setting
  AppState _appState;

  int _quantity = 1;
  final ProductService _productService = ProductService();
  var quantity = TextEditingController();
  // int shoppingCartItemId = 0;
  bool processing = false;
  bool isProcessingFavour = false;
  bool isPageLoading = false;
  ProductService productService;
  ProductDetailModel productDetail;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> onGetProductDetailInfo() async {
    try {
      productDetail =
          await productService.getProductDetailById(widget.productId);
    } catch (e) {
      print(e);
      setState(() {
        isPageLoading = false;
      });
    }
  }

  void _init() async {
    if (mounted) {
      setState(() {
        isPageLoading = true;
      });
      _appState = Provider.of<AppState>(context, listen: false);
      productService = ProductService();
      await onGetProductDetailInfo();
      // await getCartByProductId();
      setState(() {
        isPageLoading = false;
      });
    }
    // app state
  }

  void submitFavourite(id) {
    _quantity = int.parse(quantity.text);
    setState(() {
      isProcessingFavour = true;
    });
    _productService
        .setFavouriteItem(_appState.user.customerId, id, _quantity)
        .then((response) {
      if (response == 'success') {
        setState(() {
          isProcessingFavour = false;
        });
        if (_appState.user.isGuest) {
          _addProductToWishlistAsGuest(id, _quantity);
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context).detailpage_success),
                content: Text(AppLocalizations.of(context).detailpage_text1),
                actions: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).detailpage_ok),
                    onPressed: () {
                      Navigator.pushNamed(context, '/saved');
                    },
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context).detailpage_failed),
                content: Text(AppLocalizations.of(context).detailpage_text2),
                actions: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).detailpage_ok),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }).catchError((err) {
      print(err);
      setState(() {
        isProcessingFavour = false;
      });
    });
  }

  void _addProductToWishlistAsGuest(productId, quantity) async {
    List _guestWishlist = [];
    String _tmp = await _appState.getLocalStorage('guestWishlist');
    if (_tmp.isEmpty) {
      _guestWishlist.add({'productId': productId, 'quantity': quantity});
    } else {
      _guestWishlist = jsonDecode(_tmp);
      var existingItem = _guestWishlist.firstWhere(
          (element) => element['productId'] == productId,
          orElse: () => null);
      if (existingItem == null) {
        _guestWishlist.add({'productId': productId, 'quantity': quantity});
      } else {
        _guestWishlist[_guestWishlist
            .indexWhere((element) => element['productId'] == productId)] = {
          'productId': productId,
          'quantity': quantity
        };
      }
    }
    _appState.setLocalStorage(
        key: 'guestWishlist', value: jsonEncode(_guestWishlist));
  }

  void _addProductToShoppingCartAsGuest(productId, price, quantity) async {
    List _guestShoppingCart = [];
    String _tmp = await _appState.getLocalStorage('guestShoppingCart');
    if (_tmp.isEmpty) {
      _guestShoppingCart
          .add({'productId': productId, 'price': price, 'quantity': quantity});
    } else {
      _guestShoppingCart = jsonDecode(_tmp);
      var existingItem = _guestShoppingCart.firstWhere(
          (element) => element['productId'] == productId,
          orElse: () => null);
      if (existingItem == null) {
        _guestShoppingCart.add(
            {'productId': productId, 'price': price, 'quantity': quantity});
      } else {
        _guestShoppingCart[_guestShoppingCart
            .indexWhere((element) => element['productId'] == productId)] = {
          'productId': productId,
          'price': price,
          'quantity': quantity
        };
      }
    }
    _appState.setLocalStorage(
        key: 'guestShoppingCart', value: jsonEncode(_guestShoppingCart));
  }

  void submitCartItem(productId, price) async {
    _quantity = int.parse(quantity.text);
    // print(_appState.user['_id']);

    if (_quantity != 0) {
      setState(() {
        processing = true;
      });
      if (_appState.user.isGuest) {
        _addProductToShoppingCartAsGuest(productId, price, _quantity);
      }
      _productService
          .addCartItem(productId, _quantity,
              _appState.user.customerId)
          .then((response) {
        if (response == 'success') {
          setState(() {
            processing = false;
          });
          if (_appState.user.isGuest) {
            _addProductToShoppingCartAsGuest(productId, price, _quantity);
          }
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context).detailpage_success),
                  content: Text(AppLocalizations.of(context).detailpage_cart),
                  actions: [
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context).detailpage_ok),
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                    )
                  ],
                );
              });
        } else {
          setState(() {
            processing = false;
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context).detailpage_failed),
                  content: Text(AppLocalizations.of(context).detailpage_text2),
                  actions: [
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context).detailpage_ok),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        }
      }).catchError((err) {
        print(err);
        setState(() {
          processing = false;
        });
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).detailpage_alert),
              content: Text(AppLocalizations.of(context).detailpage_text4),
              actions: [
                ElevatedButton(
                  child: Text(AppLocalizations.of(context).detailpage_ok),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  // Future<void> getCartByProductId() async {
  //   try {
  //     var response =
  //         await _productService.getShoppingMiniCart(widget.productId);
  //     shoppingCartItemId = response['shoppingCartItemId'];
  //     if (response['quantity'] > 0) {
  //       quantity.text = response['quantity'].toString();
  //     }
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isPageLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    Widget topContent = Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: productDetail?.image?.isEmpty ?? true
                    ? const AssetImage('assets/img/no_image.png')
                    : NetworkImage(
                        productDetail?.image,
                      ),
                fit: BoxFit.fill,
                opacity: 0.7),
          ),
        ),
        Positioned(
          left: 12.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        Positioned(
          right: 12.0,
          top: 60.0,
          child: InkWell(
            onTap: isProcessingFavour
                ? null
                : () {
                    // Navigator.pushNamed(context, '/home');
                    // if (!_appState.user.isGuest) {
                    //   submitFavourite(args?.id);
                    // }
                    submitFavourite(widget.productId);
                  },
            child: isProcessingFavour
                ? const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
          ),
        ),
      ],
    );
    Widget bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: const Color.fromRGBO(58, 66, 86, .9).withOpacity(0.1)),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productDetail?.name?.isEmpty ?? true
                                    ? ""
                                    : productDetail?.name,
                                style: const TextStyle(
                                  fontFamily: 'Avenir Next',
                                  fontSize: 32,
                                  color: Color(0xff1d1d1d),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12),
                        //   child: Text(
                        //     "",
                        //     // AppLocalizations.of(context).stock +
                        //     //     args.stock.toString(),
                        //     style: const TextStyle(
                        //       fontFamily: 'Avenir Next',
                        //       fontSize: 16,
                        //       color: Color(0xff1d1d1d),
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(mq.width * 0.085, 8, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productDetail?.categoryName ?? "",
                        style: const TextStyle(
                          fontFamily: 'Avenir Next',
                          fontSize: 14,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        mq.width * 0.085, 16, 0, mq.height * 0.02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).detailpage_quantity,
                        style: const TextStyle(
                          fontFamily: "Avenir Next",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d1d1d),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: mq.width * 0.3,
                      child: NumberInputPrefabbed.roundedButtons(
                        controller: quantity,
                        incDecBgColor: const Color.fromARGB(255, 223, 240, 253),
                        buttonArrangement: ButtonArrangement.incRightDecLeft,
                        incIcon: Icons.add,
                        decIcon: Icons.remove,
                        incIconColor: const Color(0xff283488),
                        decIconColor: const Color(0xff283488),
                        incIconSize: 35,
                        decIconSize: 35,
                        onChanged: (value) {
                          if (!value.isNaN) {
                            quantity.text = value.toString();
                            _quantity = value;
                          }
                        },
                        min: 1,
                        max: 100,
                        // max: args.stock,
                        initialValue: _quantity,
                        numberFieldDecoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        mq.width * 0.085, 16, 0, mq.height * 0.02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).detailpage_description,
                        style: const TextStyle(
                          fontFamily: "Avenir Next",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d1d1d),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(mq.width * 0.085, 0,
                        mq.width * 0.085, mq.height * 0.02),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        productDetail?.shortdescription ?? "",
                        style: const TextStyle(
                          fontFamily: "Avenir Next",
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff1d1d1d),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: mq.width * 0.5,
                  height: 80,
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        mq.width * 0.085, 16, 16, mq.height * 0.02),
                    child: ElevatedButton(
                      onPressed: processing
                          ? null
                          : () {
                              submitCartItem(
                                  widget.productId, productDetail?.price);
                            },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff283488)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            side: const BorderSide(color: Color(0xff283488)),
                          ),
                        ),
                      ),
                      child: processing
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            )
                          : Text(
                              AppLocalizations.of(context).detailpage_acart,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            16, 16, mq.width * 0.0853, mq.height * 0.02),
                        child: Text(
                          'ر.س ${productDetail?.price?.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: "Avenir Next",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1d1d1d),
                          ),
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
    );
    return isPageLoading
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [topContent, bottomContent],
              ),
            ),
          );
  }
}
