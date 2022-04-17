// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/model/product.dart';
import 'package:toy_app/widget/detailPage_test.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:toy_app/service/product_repo.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';

class Searchlist extends StatefulWidget {
  const Searchlist({Key key}) : super(key: key);

  @override
  State<Searchlist> createState() => _Searchlist();
}

class _Searchlist extends State<Searchlist> {
  // future setting
  static const int PAGE_SIZE = 10;
  String searchText = '';
  // provider setting
  AppState _appState;
  Widget _buildSearch(String _searchText) {
    return PagewiseGridView<ProductModel>.count(
      pageSize: PAGE_SIZE,
      crossAxisCount: 1,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 6.0,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height * 0.2),
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
        return ProductService.searchProductsByName(
            pageIndex + 1, PAGE_SIZE, _searchText);
      },
    );
  }

  Widget _itemBuilder(context, ProductModel entry, _) {
    return InkWell(
      hoverColor: Colors.pink,
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPageTest.routeName,
          arguments: entry,
        );
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  bottomLeft: Radius.circular(32.0)),
              child: Image.network(
                "${_appState.endpoint}/products/image/${entry.image}",
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 5),
                        child: Text(
                          entry.name,
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          entry.category,
                          style: const TextStyle(
                            fontFamily: 'Avenir Next',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Text(
                                '\$' + entry.price.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Avenir Next',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                height: 30,
                                width: 30,
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
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0)),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // app state
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    searchText = ModalRoute.of(context).settings.arguments as String;
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
                      AppLocalizations.of(context).searchlistpage_result,
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
                height: height * 0.65,
                child: _buildSearch(searchText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
