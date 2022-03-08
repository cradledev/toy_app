// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:toy_app/model/details.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/service/product_repo.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _Saved();
}

class _Saved extends State<Saved> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  int _currentIndex = 0;
  final ProductService _productService = ProductService();
  late Future<List<CartModel>> favouriteItems;

  @override
  void initState() {
    super.initState();
    favouriteItems = _productService.getFavouriteItems();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;
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
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: 3,
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
            title: const Text('Settings'),
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
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: height * 0.1, left: width * 0.05),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                      // Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30,
                    ),
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
                    "Saved",
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
                  ),
                  child: const Text(
                    "Your favorite toys",
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
            SizedBox(
              height: height * 0.62,
              child: FutureBuilder(
                future: favouriteItems,
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: itemWidth / itemHeight),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) =>
                                InkWell(
                              hoverColor: Colors.pink,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: snapshot.data![index].product,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.05,
                                  right: width * 0.05,
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      height: height * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Colors.white,
                                      ),
                                      child: Image.network(snapshot
                                          .data![index].product.images[0].src),
                                    ),
                                    Positioned(
                                      top: height * 0.22,
                                      child: Container(
                                        width: width * 0.4,
                                        height: height * 0.08,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(32),
                                              bottomRight: Radius.circular(32)),
                                          color: Color(0xffffffff),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  width * 0.05,
                                                  height * 0.01,
                                                  0,
                                                  0),
                                              child: Text(
                                                snapshot
                                                    .data![index].product.name,
                                                style: const TextStyle(
                                                  fontFamily: 'Avenir Next',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  width * 0.05, 10, 0, 0),
                                              child: Text(
                                                '\$' +
                                                    snapshot.data![index]
                                                        .product.price
                                                        .toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
