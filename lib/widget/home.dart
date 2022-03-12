import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/provider/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> popularProducts;
  late Future<List<Product>> newArrivalProducts;
  late Future<List<Product>> topCollectionProducts;
  late Future<List<Product>> robotProducts;
  late Future<List<Product>> babyProducts;
  late Future<List<Product>> recommendedProducts;

  // provider setting
  late AppState _appState;
  late String _languageCode = "en";
  @override
  void initState() {
    super.initState();
    popularProducts = _productService.getCategory('Popular');
    newArrivalProducts = _productService.getCategory('NewArrival');
    topCollectionProducts = _productService.getCategory('TopCollection');
    robotProducts = _productService.getCategory('Robots');
    babyProducts = _productService.getCategory('Baby');
    recommendedProducts = _productService.getCategory('Recommended');
    // app state
    _appState = Provider.of<AppState>(context, listen: false);
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
        bottomNavigationBar:
            CustomBottomNavbar(context: context, selectedIndex: 0),
        body: SingleChildScrollView(
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
                            padding: const EdgeInsets.only(top: 70),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              "assets/img/home/1-4.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
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
                          AppLocalizations.of(context)!.home_top,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          AppLocalizations.of(context)!.home_popular,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: height * 0.35,
                    child: FutureBuilder(
                      future: popularProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.2,
                                            left: width * 0.05,
                                            child: Container(
                                              width: width * 0.5,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: const Color(0xff283488),
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                height * 0.03,
                                                                0,
                                                                0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                10,
                                                                0,
                                                                0),
                                                        child: Text(
                                                          '\$' +
                                                              snapshot
                                                                  .data![index]
                                                                  .price
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                            top: height * 0.23,
                                            right: width * 0.12,
                                            child: const Icon(
                                              Icons.shopping_cart_rounded,
                                              size: 30,
                                              color: Color(0xffffffff),
                                            ),
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
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/bike');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              "assets/img/home/5.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    ),
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
                          AppLocalizations.of(context)!.home_new,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                    child: FutureBuilder(
                      future: newArrivalProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.22,
                                            child: Container(
                                              width: width * 0.4,
                                              height: height * 0.08,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32),
                                                    bottomRight:
                                                        Radius.circular(32)),
                                                color: Color(0xffffffff),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.01,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            10,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      '\$' +
                                                          snapshot.data![index]
                                                              .price
                                                              .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.23,
                                            right: width * 0.035,
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                              color: Color(0xff283488),
                                            ),
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
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/party');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              "assets/img/home/7.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/school');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              "assets/img/home/8.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    ),
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
                          AppLocalizations.of(context)!.home_collections,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                    height: height * 0.35,
                    child: FutureBuilder(
                      future: topCollectionProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.22,
                                            child: Container(
                                              width: width * 0.4,
                                              height: height * 0.08,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32),
                                                    bottomRight:
                                                        Radius.circular(32)),
                                                color: Color(0xffffffff),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.01,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            10,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      '\$' +
                                                          snapshot.data![index]
                                                              .price
                                                              .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.23,
                                            right: width * 0.035,
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                              color: Color(0xff283488),
                                            ),
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
                  )
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
                          AppLocalizations.of(context)!.home_robots,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: height * 0.35,
                    child: FutureBuilder(
                      future: robotProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.22,
                                            child: Container(
                                              width: width * 0.4,
                                              height: height * 0.08,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32),
                                                    bottomRight:
                                                        Radius.circular(32)),
                                                color: Color(0xffffffff),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.01,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            10,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      '\$' +
                                                          snapshot.data![index]
                                                              .price
                                                              .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.23,
                                            right: width * 0.035,
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                              color: Color(0xff283488),
                                            ),
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
                  )
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
                          AppLocalizations.of(context)!.home_baby,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                    child: FutureBuilder(
                      future: babyProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.22,
                                            child: Container(
                                              width: width * 0.4,
                                              height: height * 0.08,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32),
                                                    bottomRight:
                                                        Radius.circular(32)),
                                                color: Color(0xffffffff),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.01,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            10,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      '\$' +
                                                          snapshot.data![index]
                                                              .price
                                                              .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.23,
                                            right: width * 0.035,
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                              color: Color(0xff283488),
                                            ),
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
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/cakes');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              "assets/img/home/12.png",
                              scale: 2,
                            ),
                          ),
                        )
                      ],
                    ),
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
                          AppLocalizations.of(context)!.home_recommended,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                    height: height * 0.35,
                    child: FutureBuilder(
                      future: recommendedProducts,
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshot) =>
                          snapshot.hasData
                              ? ListView.builder(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) =>
                                      InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        DetailPageTest.routeName,
                                        arguments: snapshot.data![index],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              color: Colors.white,
                                            ),
                                            child: Image.network(snapshot
                                                .data![index].images[0].src),
                                          ),
                                          Positioned(
                                            top: height * 0.2,
                                            left: width * 0.05,
                                            child: Container(
                                              width: width * 0.5,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: const Color(0xff283488),
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                height * 0.03,
                                                                0,
                                                                0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                10,
                                                                0,
                                                                0),
                                                        child: Text(
                                                          '\$' +
                                                              snapshot
                                                                  .data![index]
                                                                  .price
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                            top: height * 0.23,
                                            right: width * 0.12,
                                            child: const Icon(
                                              Icons.shopping_cart_rounded,
                                              size: 30,
                                              color: Color(0xffffffff),
                                            ),
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
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: const LanguageTransitionWidget(),
      ),
    );
  }
}
