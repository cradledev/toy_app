import 'package:flutter/material.dart';
import 'package:toy_app/model/details.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

class Bike extends StatefulWidget {
  const Bike({Key? key}) : super(key: key);

  @override
  State<Bike> createState() => _Bike();
}

class _Bike extends State<Bike> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  final ProductService _productService = ProductService();
  late Future<List<Product>> products;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    products = _productService.getCategory('Bikes');
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
        child: Container(
          color: const Color(0xffffffff),
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
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
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
                      "Scooters & Bikes",
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
                      "Toys collection",
                      style: TextStyle(
                        color: Colors.black,
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
                  future: products,
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
                                    DetailPageTest.routeName,
                                    arguments: snapshot.data![index],
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
                                                bottomLeft: Radius.circular(32),
                                                bottomRight:
                                                    Radius.circular(32)),
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
                                                  snapshot.data![index].name,
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
                                                      snapshot
                                                          .data![index].price
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
      ),
    );
  }
}
