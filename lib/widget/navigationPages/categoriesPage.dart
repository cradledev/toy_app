// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
// import 'package:toy_app/model/details.dart';
// import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';
import 'package:toy_app/service/product_repo.dart';
import 'package:toy_app/model/category_list_model.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/model/search_model.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  int _currentIndex = 0;
  final ProductService _productService = ProductService();
  late Future<List<CategoryList>> categories;
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    categories = _productService.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;

    void categoryListShow(String item) async {
      products = _productService.getCategory(item);
      Navigator.pushNamed(context, '/categoryItem',
          arguments: SearchData(item, products));
    }

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
        selectedIndex: 1,
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
                    "Categories",
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
                    bottom: height * 0.01,
                  ),
                  child: const Text(
                    "All the yourchild needs",
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
                future: categories,
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
                              onTap: () {
                                categoryListShow(snapshot.data![index].name);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: width * 0.46,
                                    height: height * 0.32,
                                    margin: EdgeInsets.only(
                                        left: width * 0.02,
                                        right: width * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      color: Colors.white,
                                    ),
                                    child: Image.network(
                                      snapshot.data![index].image.src,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    top: height * 0.25,
                                    left: width * 0.05,
                                    child: Container(
                                      width: width * 0.4,
                                      height: height * 0.05,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: const TextStyle(
                                            fontFamily: 'Avenir Next',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff283488),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
