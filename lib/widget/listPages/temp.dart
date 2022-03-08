import 'package:flutter/material.dart';
import 'package:toy_app/model/details.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _Popular();
}

class _Popular extends State<Popular> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  final ProductService _productService = ProductService();
  late Future<List<Product>> products;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    products = _productService.getall();
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

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: 0,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) =>
            {setState(() => _currentIndex = index), onTabTapped(index)},
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeBackColor: Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Categories'),
            activeBackColor: Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart Items'),
            activeBackColor: Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite_outline),
            title: Text('Saved'),
            activeBackColor: Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text('Profile'),
            activeBackColor: Color(0xFF283488),
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
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: height * 0.1, left: width * 0.05),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                  child: const Text(
                    "Popular",
                    style: TextStyle(
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
                  padding: EdgeInsets.only(
                      top: height * 0.02,
                      left: width * 0.05,
                      bottom: height * 0.05),
                  child: const Text(
                    "Toys collection",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Avenir Next",
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/1-1.png",
                            "3.9",
                            "Super Robot",
                            "Hotwheels collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$25.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.04, right: width * 0.04),
                          child: Image.asset('assets/img/Popular/1.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.04, right: width * 0.04),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Super Robot",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$25.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/2-1.png",
                            "4.9",
                            "Lecomotive",
                            "Wooden toys collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$16.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.04, right: width * 0.04),
                          child: Image.asset('assets/img/Popular/2.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.04, right: width * 0.04),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Lecomotive",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$15.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/3-1.png",
                            "2.9",
                            "Teddy Bear",
                            "Soft toys collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$8.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Image.asset('assets/img/Popular/3.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Teddy Bear",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$15.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/4-1.png",
                            "2.9",
                            "Horse",
                            "Soft toys collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$12.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Image.asset('assets/img/Popular/4.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Horse",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$20.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/5-1.png",
                            "4.9",
                            "Car",
                            "R/C Toys collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$19.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Image.asset('assets/img/Popular/5.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Car",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$30.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPageTest.routeName,
                        arguments: ToyDetail(
                            "assets/img/Popular/6-1.png",
                            "4.9",
                            "Spiderman",
                            "R/C Toys collection",
                            "Interactive - A fully English speaking robot for kids that talks, dances, tells jokes, plays music and features tons of light and . . .",
                            "\$19.99"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Image.asset('assets/img/Popular/6.png'),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: width * 0.4,
                          margin: EdgeInsets.only(
                              left: width * 0.05, right: width * 0.05),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, height * 0.03, 0, 0),
                                    child: const Text(
                                      "Superman",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.05, 10, 0, 0),
                                    child: const Text(
                                      "\$60.99",
                                      style: TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xff283488),
                                ),
                              ),
                            ],
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
