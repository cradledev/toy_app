import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';

import 'package:toy_app/service/product_repo.dart';
import 'package:toy_app/model/category_list_model.dart';
import 'package:toy_app/model/product_model.dart';
import 'package:toy_app/model/search_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
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

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 1),
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        title: const Text(""),
        leadingAction: () {
          Navigator.pushNamed(context, '/search');
        },
        leadingIcon: const Icon(
          Icons.search,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 30, left: width * 0.05, right: width * 0.05),
                  child: Text(
                    AppLocalizations.of(context)!.categoriespage_categories,
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
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                    horizontal: width * 0.05,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.categoriespage_text,
                    style: const TextStyle(
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
