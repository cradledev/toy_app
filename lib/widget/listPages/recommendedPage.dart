import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/model/produt_model.dart';
import 'package:toy_app/widget/detailPage_test.dart';

import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key key}) : super(key: key);

  @override
  State<Recommended> createState() => _Recommended();
}

class _Recommended extends State<Recommended> {
  // future setting
  static const int PAGE_SIZE = 6;
  // provider setting
  AppState _appState;
  Widget _build() {
    return PagewiseGridView<ProductModel>.count(
      pageSize: 100,
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 6.0,
      childAspectRatio: 0.75,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: _itemBuilder,
      loadingBuilder: (context) {
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              )),
        );
      },
      retryBuilder: (context, callback) {
        // return Center(
        //   child: SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           ElevatedButton(
        //               child: const Text('Retry'), onPressed: () => callback())
        //         ],
        //       )),
        // );
        return const SizedBox(width: 0,);
      },
      noItemsFoundBuilder: (context) {
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('No Items Found'),
                ],
              )),
        );
      },
      pageFuture: (pageIndex) {
        return ProductService.getRecommendProduct(pageIndex, 100);
      },
    );
  }

  Widget _itemBuilder(context, ProductModel entry, _) {
    return InkWell(
      // hoverColor: Colors.pink,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPageTest(productId : entry.id);
          }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
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
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      child: entry?.image?.isEmpty ?? true
                          ? Image.asset('assets/img/no_image.png', fit: BoxFit.fill,)
                          : Image.network(
                              entry?.image,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        entry?.name?.isEmpty ?? true
                                            ? ""
                                            : "${entry?.name?.substring(0,15)}...",
                                        style: const TextStyle(
                                          fontFamily: 'Avenir Next',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        entry?.price?.isNaN ?? true
                                            ? ""
                                            : 'ر.س ${entry?.price.toString()}',
                                        style: const TextStyle(
                                          fontFamily: 'Avenir Next',
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
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
                                  fillColor: const Color(0xff283488),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17.5)),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      bottomNavigationBar: CustomBottomNavbar(
        context: context,
        selectedIndex: 0,
      ),
      appBar: CustomAppBar(
        title: const Text(""),
        leadingAction: () {
          Navigator.pop(context);
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
                    top: 10,
                    left: width * 0.05,
                    right: width * 0.05,
                  ),
                  child: Text(
                    AppLocalizations.of(context).recommendedpage_recommended,
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
                    vertical: 15,
                  ),
                  child: Text(
                    AppLocalizations.of(context).recommendedpage_collection,
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
            SizedBox(height: height * 0.65, child: _build()),
          ],
        ),
      ),
    );
  }
}
