// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/search_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Searchlist extends StatefulWidget {
  const Searchlist({Key? key}) : super(key: key);

  @override
  State<Searchlist> createState() => _Searchlist();
}

class _Searchlist extends State<Searchlist> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var itemHeight = height * 0.1;
    var itemWidth = width * 0.4;
    SearchData data = ModalRoute.of(context)!.settings.arguments as SearchData;
    late Future<List<Product>> products = data.products;
    String searchText = data.searchText;

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 0),
      appBar: CustomAppBar(
        title: const Text(""),
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: const LanguageTransitionWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffffffff),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.05),
                    child: Text(
                      searchText,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: width * 0.05),
                    child: Text(
                      AppLocalizations.of(context)!.searchlistpage_result,
                      style: const TextStyle(
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
                                      crossAxisCount: 1,
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
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: height * 0.2,
                                          width: width * 0.4,
                                          margin: EdgeInsets.only(
                                              left: width * 0.04),
                                          child: Image.network(snapshot
                                              .data![index].images[0].src),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(32.0),
                                                  bottomLeft:
                                                      Radius.circular(32.0)),
                                              color: Colors.white),
                                        ),
                                        Container(
                                          height: height * 0.2,
                                          width: width * 0.5,
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.03,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            8,
                                                            0,
                                                            0),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .searchlistpage_lego,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.05,
                                                                height * 0.05,
                                                                0,
                                                                0),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .price
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                width * 0.15,
                                                                height * 0.05,
                                                                0,
                                                                0),
                                                        child: const Icon(
                                                          Icons.shopping_cart,
                                                          size: 30,
                                                          color:
                                                              Color(0xff283488),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(32.0),
                                                bottomRight:
                                                    Radius.circular(32.0)),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
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
      ),
    );
  }
}
