import 'package:flutter/material.dart';
// import 'package:toy_app/model/details.dart';
// import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

class WrapPage extends StatefulWidget {
  const WrapPage({Key? key}) : super(key: key);

  @override
  State<WrapPage> createState() => _WrapPage();
}

class _WrapPage extends State<WrapPage> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = _productService.getCategory('Wrap');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;
    return Scaffold(
      // backgroundColor: Color(0xff283488),
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
                      Navigator.pushNamed(context, '/cart');
                      // Navigator.pop(context);
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
                    "Wrap options",
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
                    "Choose packeging design",
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
                              onTap: () {},
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
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Colors.white,
                                      ),
                                      child: Image.network(
                                        snapshot.data![index].images[0].src,
                                        fit: BoxFit.fill,
                                      ),
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
                                                    snapshot.data![index].price
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
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
              child: SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/wraporder');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff283488)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(83.0),
                        side: const BorderSide(color: Color(0xff283488)),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
