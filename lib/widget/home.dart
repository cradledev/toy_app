import 'package:flutter/material.dart';
import 'package:toy_app/model/details.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  int _currentIndex = 0;
  final ProductService _productService = ProductService();
  late Future<List<Product>> popularProducts;
  late Future<List<Product>> newArrivalProducts;
  late Future<List<Product>> topCollectionProducts;
  late Future<List<Product>> robotProducts;
  late Future<List<Product>> babyProducts;
  late Future<List<Product>> recommendedProducts;

  @override
  void initState() {
    super.initState();
    popularProducts = _productService.getCategory('Popular');
    newArrivalProducts = _productService.getCategory('NewArrival');
    topCollectionProducts = _productService.getCategory('TopCollection');
    robotProducts = _productService.getCategory('Robots');
    babyProducts = _productService.getCategory('Baby');
    recommendedProducts = _productService.getCategory('Recommended');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    void onTabTapped(int index) {
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      }
      if (index == 1) {
        Navigator.pushNamed(context, '/categories');
      }
      if (index == 2) {
        Navigator.pushNamed(context, '/cart');
      }
      if (index == 3) {
        Navigator.pushNamed(context, '/saved');
      }
      if (index == 4) {
        Navigator.pushNamed(context, '/profile');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: 0,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) =>
              {setState(() => _currentIndex = index), onTabTapped(index)},
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeBackColor: const Color(0xFF283488),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
              inactiveColor: Colors.grey[600],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Categories'),
              activeBackColor: const Color(0xFF283488),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
              inactiveColor: Colors.grey[600],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.shopping_cart),
              title: const Text('Shopping Cart Items'),
              activeBackColor: const Color(0xFF283488),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
              inactiveColor: Colors.grey[600],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.favorite_outline),
              title: const Text('Saved'),
              activeBackColor: const Color(0xFF283488),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
              inactiveColor: Colors.grey[600],
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              title: const Text('Profile'),
              activeBackColor: const Color(0xFF283488),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
              inactiveColor: Colors.grey[600],
            ),
          ],
        ),
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
                              scale: 1.7,
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
                              child: Image.asset(
                                "assets/img/home/1-3.png",
                                scale: 1.8,
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Top Brands",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Popular",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.7, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/popular');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "New arrivals",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.65, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/new');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Top collections",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.6, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/top');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Robots",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.7, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/robots');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Baby toys",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.7, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/baby');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: const Text(
                          "Recommended",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.6, 20, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/recommended');
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
