import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:toy_app/model/product.model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

class DetailPageTest extends StatefulWidget {
  const DetailPageTest({Key key}) : super(key: key);
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
  int categoryId = 0;
  String categoryName = "";
  int shoppingCartItemId = 0;
  bool processing = false;
  bool isProcessingFavour = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    // app state
    _appState = Provider.of<AppState>(context, listen: false);
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

    // Future<String> response = _productService.setFavourite(id);
  }

  void submitCartItem(productId, price) {
    _quantity = int.parse(quantity.text);
    // print(_appState.user['_id']);
    if (_quantity != 0) {
      setState(() {
        processing = true;
      });

      _productService
          .addCartItem(productId, _quantity, shoppingCartItemId,
              _appState.user.customerId)
          .then((response) {
        if (response == 'success') {
          setState(() {
            processing = false;
          });

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

  void getCartByProductId(int id, int productId) async {
    var response = await _productService.getShoppingMiniCart(productId);
    shoppingCartItemId = response['shoppingCartItemId'];
    if (response['quantity'] > 0) {
      quantity.text = response['quantity'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    final args = ModalRoute.of(context).settings.arguments as ProductM;
    String productImageUrl =
        args?.images?.isEmpty ?? true ? "" : args?.images[0];
    categoryId = args?.categoryId?.isNaN ?? true ? 0 : args?.categoryId;
    categoryName =
        args?.categoryName?.isEmpty ?? true ? "" : args?.categoryName;
    getCartByProductId(_appState.user.customerId, args?.id);

    Widget topContent = Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: productImageUrl?.isEmpty ?? true
                    ? const AssetImage('assets/img/no_image.png')
                    : NetworkImage(
                        productImageUrl,
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
                    if (!_appState.user.isGuest) {
                      submitFavourite(args?.id);
                    }
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                args?.name?.isEmpty ?? true ? "" : args?.name,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            // args.approvedratingsum.toString(),
                            "Stock " + args.stock.toString(),
                            style: const TextStyle(
                              fontFamily: 'Avenir Next',
                              fontSize: 16,
                              color: Color(0xff1d1d1d),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(mq.width * 0.085, 8, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        categoryName ?? "",
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
                          print(value);
                          if (!value.isNaN) {
                            quantity.text = value.toString();
                            _quantity = value;
                          }
                        },
                        min: 1,
                        max: args.stock,
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
                        args.shortdescription ?? "",
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
                              if (!_appState.user.isGuest) {
                                submitCartItem(args?.id, args?.price);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("You must login, not as a Guest."),
                                  backgroundColor: Colors.orange,
                                ));
                              }
                              // Navigator.pushNamed(context, '/home');
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
                      child: Text(
                        processing
                            ? "...processing"
                            : AppLocalizations.of(context).detailpage_acart,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
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
                          'ر.س ${args.price.toString()}',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [topContent, bottomContent],
      ),
    );
  }
}
