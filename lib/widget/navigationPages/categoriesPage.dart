import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';

import 'package:toy_app/service/product_repo.dart';
import 'package:toy_app/model/category_list_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
  // future setting
  static const int PAGE_SIZE = 100;
  // provider setting
  AppState _appState;
  List<CategoryList> categoryList = [];
  bool isPageLoading = false;
  Widget _build() {
    return FutureBuilder(
      future: ProductService.getAllCategories(),
      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return _itemBuilder(context, snapshot.data[index]);
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }

  Widget _itemBuilder(context, CategoryList entry) {
    return InkWell(
      // hoverColor: Colors.pink,
      onTap: () {
        Navigator.pushNamed(
          context,
          "/categoryItem",
          arguments: {'id': entry?.id, 'name': entry?.name},
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    child: entry?.image?.isEmpty ?? true
                        ? Image.asset(
                            'assets/img/no_image.png',
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            entry?.image,
                            fit: BoxFit.fill,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.only(bottom: 15),
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: const Color(0xffffffff),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: Text(
                            entry?.name.toString(),
                            style: const TextStyle(
                              fontFamily: 'Avenir Next',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff283488),
                            ),
                          ),
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
    );
  }

  @override
  void initState() {
    super.initState();

    onInit();
  }

  void onInit() {
    _appState = Provider.of<AppState>(context, listen: false);
    // setState(() {
    //   isPageLoading = true;
    // });
    // ProductService.getAllCategories().then((value) {
    //   setState(() {
    //     isPageLoading = false;
    //   });
    //   categoryList = value;
    // }).catchError((error) {
    //   setState(() {
    //     isPageLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 1),
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
                      top: 10, left: width * 0.05, right: width * 0.05),
                  child: Text(
                    AppLocalizations.of(context).categoriespage_categories,
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
                    AppLocalizations.of(context).categoriespage_text,
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
            SizedBox(height: height * 0.65, child: _build()),
          ],
        ),
      ),
    );
  }
}
