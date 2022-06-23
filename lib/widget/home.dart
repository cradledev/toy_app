import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/components/custom_drawer_widget.dart';
import 'package:toy_app/model/product.model.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/provider/index.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  // future setting
  static const int PAGE_SIZE = 10;
  // slider setting
  List<Map<String, dynamic>> imgList = <Map<String, dynamic>>[];
  List<int> bannerProductIds = [];
  // provider setting
  AppState _appState;
  String _languageCode = "en";
  // pageloading
  bool isPageLoading = false;

  // product service
  ProductService productService;

  Widget _buildNewArrival() {
    return PagewiseListView<ProductM>(
      pageSize: 100,
      scrollDirection: Axis.horizontal,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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
        return ProductService.getNewArrival(pageIndex, 100);
      },
    );
  }

  Widget _buildTopCollection() {
    return PagewiseListView<ProductM>(
      pageSize: PAGE_SIZE,
      scrollDirection: Axis.horizontal,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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
        return ProductService.onGetPopularProducts(
            pageIndex: pageIndex,
            pageSize: PAGE_SIZE,
            token: _appState.user.token);
      },
    );
  }

  Widget _buildRecommend() {
    return PagewiseListView<ProductM>(
      pageSize: 100,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: _recommendItemBuilder,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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

  Widget _recommendItemBuilder(context, ProductM entry, _) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPageTest.routeName,
          arguments: entry,
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
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
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    child: entry?.images?.isEmpty ?? true
                        ? Image.asset(
                            'assets/img/no_image.png',
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            entry?.images[0],
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.38,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: const Color(0xFF283488),
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
                                          : '${entry?.name?.substring(0, 12)}...',
                                      style: const TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'ر.س ${entry?.price.toString()}',
                                      style: const TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 1.0,
                                fillColor: Colors.white,
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 16.0,
                                  color: Color(0xff283488),
                                ),
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
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
    );
  }

  Widget _itemBuilder(context, ProductM entry, _) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPageTest.routeName,
          arguments: entry,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
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
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      child: entry?.images?.isEmpty ?? true
                          ? Image.asset(
                              'assets/img/no_image.png',
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              entry?.images[0],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        entry?.name?.isEmpty ?? true
                                            ? ""
                                            : "${entry?.name?.substring(0, 13)}...",
                                        style: const TextStyle(
                                          fontFamily: 'Avenir Next',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        'ر.س ${entry?.price.toString()}',
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
                                      borderRadius:
                                          BorderRadius.circular(17.5)),
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

  Widget _buildRobots() {
    return PagewiseListView<ProductM>(
      pageSize: PAGE_SIZE,
      scrollDirection: Axis.horizontal,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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
      pageFuture: (pageIndex) => ProductService.getProductsByCategoryId(
          pageIndex, PAGE_SIZE, "العاب ريموت"),
    );
  }

  // Widget popular list item
  Widget _buildPopular() {
    return PagewiseListView<ProductM>(
      pageSize: PAGE_SIZE,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: _recommendItemBuilder,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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
      pageFuture: (pageIndex) => ProductService.onGetPopularProducts(
          pageIndex: pageIndex,
          pageSize: PAGE_SIZE,
          token: _appState.user.token),
    );
  }

  Widget _buildBabyToys() {
    return PagewiseListView<ProductM>(
      pageSize: PAGE_SIZE,
      scrollDirection: Axis.horizontal,
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
        return Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Retry'), onPressed: () => callback())
                ],
              )),
        );
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
      pageFuture: (pageIndex) =>
          ProductService.getProductsByCategoryId(pageIndex, PAGE_SIZE, "رضع"),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    setState(() {
      isPageLoading = true;
    });
    _appState = Provider.of<AppState>(context, listen: false);
    print(_appState.user.toMap());
    productService = ProductService();
    productService.onGetNewProducts(_appState.user.token).then((value) {
      imgList = value;
      setState(() {
        isPageLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isPageLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    _appState.getLocale().then((locale) {
      setState(() {
        _languageCode = locale.languageCode;
      });
    });
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 236, 236),
        bottomNavigationBar:
            CustomBottomNavbar(context: context, selectedIndex: 0),
        appBar: const CustomAppBar(
          title: Text(""),
          leadingIcon: Icon(
                CupertinoIcons.line_horizontal_3,
                size: 30,
                color: Colors.white,
              ),
          backgroundColor: Color(0xff283488),
        ),
        drawer: const CustomDrawerWidget(),
        body: isPageLoading
            ? Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xff283488),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.asset(
                                    "assets/img/home/header.png",
                                    scale: 1.6,
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/search');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/img/home/1-3.png',
                                      ),
                                      fit: BoxFit.scaleDown,
                                      height: 50,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          imgList.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 30),
                                  child: Column(
                                    children: [
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          height: 250.0,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                        ),
                                        items: imgList.map((item) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Stack(
                                                  fit: StackFit.expand,
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35.0),
                                                      child: Image.network(
                                                        item['image'],
                                                        height: 250.0,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16),
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                const Offset(
                                                                    0, 1),
                                                            blurRadius: 5,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(35.0),
                                                      ),
                                                      // margin:
                                                      //     const EdgeInsets.only(top: 30),
                                                      // alignment: Alignment.topCenter,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            item['name'],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 28,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  height: 30.0,
                                ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_top,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/lego');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-1.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/hotwheels');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-2.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/barbie');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-3.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/disney');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-4.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/bratz');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-5.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/starwars');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-6.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/toystory');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-7.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/marvel');
                                },
                                child: Container(
                                  child: Image.asset('assets/img/home/2-8.png'),
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_popular,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/popular');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.35, child: _buildPopular())
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/bike');
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                "assets/img/home/5.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    AppLocalizations.of(context).bike_title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_new,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/new');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.35,
                          child: _buildNewArrival(),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/party');
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                "assets/img/home/7.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    AppLocalizations.of(context).party_title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/school');
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                "assets/img/home/8.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    AppLocalizations.of(context).school_title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_collections,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/top');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: height * 0.35, child: _buildTopCollection())
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_robots,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/robots');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.35, child: _buildRobots())
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_baby,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/baby');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.35,
                          child: _buildBabyToys(),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/cakes');
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                "assets/img/home/12.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    AppLocalizations.of(context).cake_title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).home_recommended,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/recommended');
                                },
                                child: (_languageCode == "en")
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: height * 0.35, child: _buildRecommend())
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
