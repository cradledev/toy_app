import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailPageTest extends StatefulWidget {
  const DetailPageTest({Key? key}) : super(key: key);
  static const routeName = '/test';

  @override
  State<DetailPageTest> createState() => _DetailPageTest();
}

class _DetailPageTest extends State<DetailPageTest> {
  int _quantity = 1;
  final ProductService _productService = ProductService();
  var quantity = TextEditingController();
  void submitFavourite(int id) async {
    String response = await _productService.setFavouriteItem(id);
    if (response == 'success') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.detailpage_success),
              content: Text(AppLocalizations.of(context)!.detailpage_text1),
              actions: [
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.detailpage_ok),
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
              title: Text(AppLocalizations.of(context)!.detailpage_failed),
              content: Text(AppLocalizations.of(context)!.detailpage_text2),
              actions: [
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.detailpage_ok),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
    // Future<String> response = _productService.setFavourite(id);
  }

  void submitCartItem(int productId) async {
    _quantity = int.parse(quantity.text);
    if (_quantity != 0) {
      String response = await _productService.addCartItem(productId, _quantity);
      if (response == 'success') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.detailpage_success),
                content: Text(AppLocalizations.of(context)!.detailpage_text1),
                actions: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.detailpage_ok),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
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
                title: Text(AppLocalizations.of(context)!.detailpage_failed),
                content: Text(AppLocalizations.of(context)!.detailpage_text2),
                actions: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.detailpage_ok),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.detailpage_alert),
              content: Text(AppLocalizations.of(context)!.detailpage_text4),
              actions: [
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.detailpage_ok),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    String url = args.images[0].src;
    if (args.images.length > 1) url = args.images[1].src;
    final avatarContent = Stack(
      children: <Widget>[
        SizedBox(
          height: mq.height,
        ),
        SizedBox(
          width: mq.width,
          child: Image.network(
            url,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 12.0,
          top: 80.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        Positioned(
          right: 12.0,
          top: 80.0,
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, '/home');
              // Navigator.pop(context);
              submitFavourite(args.id);
            },
            child: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: mq.height * 0.45,
          child: Container(
            width: mq.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mq.width * 0.085,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(mq.width * 0.085, 0, 0, 10),
                  child: Text(
                    args.name,
                    style: const TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 32,
                      color: Color(0xff1d1d1d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(mq.width * 0.085, 8, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      args.shortdescription,
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
                      AppLocalizations.of(context)!.detailpage_quantity,
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
                  padding: EdgeInsets.fromLTRB(
                      mq.width * 0.085, 0, 0, mq.height * 0.02),
                  child: SizedBox(
                    width: mq.width * 0.3,
                    child: NumberInputPrefabbed.roundedButtons(
                      controller: quantity,
                      incDecBgColor: const Color(0xff808080),
                      buttonArrangement: ButtonArrangement.incRightDecLeft,
                      incIcon: Icons.add,
                      decIcon: Icons.remove,
                      incIconColor: const Color(0xff283488),
                      decIconColor: const Color(0xff283488),
                      incIconSize: 35,
                      decIconSize: 35,
                      min: 1,
                      initialValue: 0,
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
                      AppLocalizations.of(context)!.detailpage_description,
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
                  padding: EdgeInsets.fromLTRB(
                      mq.width * 0.085, 0, mq.width * 0.0853, mq.height * 0.02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      args.fulldescription,
                      style: const TextStyle(
                        fontFamily: "Avenir Next",
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff1d1d1d),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: mq.width * 0.6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            mq.width * 0.085, 16, 16, mq.height * 0.02),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home');
                            submitCartItem(args.id);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff283488)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                side:
                                    const BorderSide(color: Color(0xff283488)),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.detailpage_acart,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          16, 16, mq.width * 0.0853, mq.height * 0.02),
                      child: Text(
                        '\$' + args.price.toString(),
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
              ],
            ),
          ),
        ),
        Positioned(
          top: mq.height * 0.5,
          right: mq.width * 0.08,
          child: Row(
            children: [
              const Icon(
                Icons.star,
                size: 30,
                color: Color(0xffF8C327),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(
                  args.approvedratingsum.toString(),
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
        )
      ],
    );

    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(child: avatarContent),
        ],
      ),
    );
  }
}
