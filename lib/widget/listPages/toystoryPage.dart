import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Toystory extends StatefulWidget {
  const Toystory({Key? key}) : super(key: key);

  @override
  State<Toystory> createState() => _Toystory();
}

class _Toystory extends State<Toystory> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> products;
  @override
  void initState() {
    super.initState();
    products = _productService.getManufacture('Toystory');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.3;
    var itemWidth = width * 0.4;

    return Scaffold(
      backgroundColor: const Color(0xff45cbf5),
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        leadingAction: () {
          Navigator.pop(context);
        },
        title: const Text(""),
        backgroundColor: const Color(0xff45cbf5),
        leadingIconColor: Colors.white,
      ),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 0),
      body: SingleChildScrollView(
        child: Padding(
          // color: const Color(0xff45cbf5),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 30,
                        left: width * 0.05,
                        right: width * 0.05,
                        bottom: 0),
                    child: Text(
                      AppLocalizations.of(context)!.toystorypage_toystory,
                      style: const TextStyle(
                        color: Colors.white,
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
                      top: 15,
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.toystorypage_collection,
                      style: const TextStyle(
                        color: Colors.white,
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