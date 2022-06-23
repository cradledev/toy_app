import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/components/custom_drawer_widget.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';
import 'package:toy_app/widget/detailPage_test.dart';

class Saved extends StatefulWidget {
  const Saved({Key key}) : super(key: key);

  @override
  State<Saved> createState() => _Saved();
}

class _Saved extends State<Saved> {
  ProductService _productService;
  AppState _appState;
  List<CartModel> favouriteItems;

  bool isProcessing = false;
  @override
  void initState() {
    super.initState();
    _init();
    // favouriteItems = _productService.getFavouriteItems();
  }

  void _init() {
    _productService = ProductService();
    _appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      isProcessing = true;
    });
    _productService.getFavouriteItems(_appState.user.customerId).then((res) {
      setState(() {
        isProcessing = false;
        favouriteItems = res;
      });
    }).catchError((err) {
      print(err);
      setState(() {
        isProcessing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavbar(
        context: context,
        selectedIndex: 3,
      ),
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        actionFlag: true,
        actionIcon: const Icon(
          Icons.search,
          color: Colors.black,
          size: 30,
        ),
        actionEvent: () {
          Navigator.pushNamed(context, '/search');
        },
        leadingIcon: const Icon(
          CupertinoIcons.line_horizontal_3,
          color: Colors.black,
          size: 30,
        ),
        
      ),
      drawer: const CustomDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context).categoryitempage_saved,
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
                    horizontal: width * 0.05,
                    vertical: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context).savedpage_text,
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
            Container(
              height: height * 0.65,
              padding: const EdgeInsets.only(top: 10),
              color: const Color.fromARGB(255, 234, 233, 233),
              child: !isProcessing
                  ? favouriteItems?.isEmpty ?? true
                      ? Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('No Items Found'),
                                ],
                              )),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8),
                          itemCount: favouriteItems.length,
                          itemBuilder: (BuildContext context, index) => InkWell(
                            hoverColor: Colors.pink,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailPageTest.routeName,
                                arguments: favouriteItems[index].product,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(32),
                                              topRight: Radius.circular(32)),
                                          child: favouriteItems[index]
                                                      ?.product
                                                      ?.images[0]
                                                      ?.isEmpty ??
                                                  true
                                              ? Image.asset(
                                                  'assets/img/no_image.png',
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  favouriteItems[index]
                                                      ?.product
                                                      ?.images[0],
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(32),
                                              bottomRight: Radius.circular(32)),
                                          color: Color(0xffffffff),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.zero,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5),
                                                          child: Text(
                                                            favouriteItems[index]?.product?.name?.isEmpty ??
                                                                    true
                                                                ? ""
                                                                : "${favouriteItems[index]?.product?.name?.substring(0, 15)}...",
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Avenir Next',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5),
                                                          child: Text(
                                                            favouriteItems[index]?.product?.price?.isNaN ??
                                                                    true
                                                                ? ""
                                                                : 'ر.س ${favouriteItems[index]?.product?.price.toString()}',
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Avenir Next',
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 35,
                                                    width: 35,
                                                    child: RawMaterialButton(
                                                      onPressed: () {},
                                                      elevation: 1.0,
                                                      fillColor: const Color(
                                                          0xff283488),
                                                      child: const Icon(
                                                        Icons
                                                            .shopping_cart_outlined,
                                                        size: 16.0,
                                                        color: Colors.white,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          17.5)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  // Positioned(
                                  //   top: 8,
                                  //   child: Container(
                                  //     width: width * 0.4,
                                  //     height: height * 0.08,
                                  //     decoration: const BoxDecoration(
                                  //       borderRadius: BorderRadius.only(
                                  //           bottomLeft: Radius.circular(32),
                                  //           bottomRight: Radius.circular(32)),
                                  //       color: Color(0xffffffff),
                                  //     ),
                                  //     child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Padding(
                                  //           padding: EdgeInsets.fromLTRB(
                                  //               width * 0.05,
                                  //               height * 0.01,
                                  //               0,
                                  //               0),
                                  //           child: Text(
                                  //             favouriteItems[index]
                                  //                         ?.product
                                  //                         ?.name
                                  //                         ?.isEmpty ??
                                  //                     true
                                  //                 ? ""
                                  //                 : favouriteItems[index]
                                  //                     ?.product
                                  //                     ?.name,
                                  //             style: const TextStyle(
                                  //               fontFamily: 'Avenir Next',
                                  //               fontSize: 14,
                                  //               color: Colors.black,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Padding(
                                  //           padding: EdgeInsets.fromLTRB(
                                  //               width * 0.05, 10, 0, 0),
                                  //           child: Text(
                                  //             '\$' +
                                  //                 favouriteItems[index]
                                  //                     .product
                                  //                     .price
                                  //                     .toString(),
                                  //             style: const TextStyle(
                                  //               fontFamily: 'Avenir Next',
                                  //               fontSize: 16,
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // Positioned(
                                  //   top: height * 0.23,
                                  //   right: width * 0.035,
                                  //   child: const Icon(
                                  //     Icons.shopping_cart,
                                  //     size: 30,
                                  //     color: Color(0xff283488),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
