import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/product.model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

import 'package:flutter_pagewise/flutter_pagewise.dart';

class Lego extends StatefulWidget {
  const Lego({Key key}) : super(key: key);

  @override
  State<Lego> createState() => _Lego();
}

class _Lego extends State<Lego> {
  // future setting
  static const int PAGE_SIZE = 4;
  // provider setting
  AppState _appState;

  Widget _build() {
    return PagewiseGridView<ProductM>.count(
      pageSize: PAGE_SIZE,
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 6.0,
      childAspectRatio: 0.75,
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
        print(pageIndex);
        return ProductService.getProductsByCategoryId(
            pageIndex, PAGE_SIZE, "lego");
      },
    );
  }

  Widget _itemBuilder(context, ProductM entry, _) {
    return InkWell(
      hoverColor: const Color(0xffdb6241),
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPageTest.routeName,
          arguments: entry,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      child: entry?.images?.isEmpty ?? true
                          ? const Text("")
                          : Image.network(
                              entry?.images[0],
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32)),
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      entry?.name?.isEmpty ?? true
                                          ? ""
                                          : entry?.name,
                                      style: const TextStyle(
                                        fontFamily: 'Avenir Next',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      entry?.price?.isNaN ?? true
                                          ? ""
                                          : '\$' + entry?.price.toString(),
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
                              SizedBox(
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
                            ],
                          ),
                        )
                      ],
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

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffdb6241),
      bottomNavigationBar: CustomBottomNavbar(
        context: context,
        selectedIndex: 0,
      ),
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        leadingAction: () {
          Navigator.pop(context);
        },
        title: const Text(""),
        backgroundColor: const Color(0xffdb6241),
        leadingIconColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: width * 0.05,
                        right: width * 0.05,
                        bottom: 0),
                    child: Text(
                      AppLocalizations.of(context).legopage_lego,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    child: Text(
                      AppLocalizations.of(context).legopage_collection,
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
                height: height * 0.65,
                child: _build(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
