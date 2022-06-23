import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/components/components.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';
import 'package:toy_app/service/product_repo.dart';


class Delivery extends StatefulWidget {
  const Delivery({Key key}) : super(key: key);

  @override
  State<Delivery> createState() => _DeliveryPage();
}

class _DeliveryPage extends State<Delivery> {
  // provider setting
  AppState _appState;

  final _formKey = GlobalKey<FormState>();
  final ProductService _productService = ProductService();
  String _address = '';
  String _city = '';
  String _index = '';

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }
void submitDelivery() async {
      final bool isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        _appState.address = _address;
        _appState.city = _city;
        _appState.index = _index;
        _productService.setshippingdress(_appState.firstName, _appState.lastName, _appState.user.userEmail ,_address, _city, _index).then((value) {
          if(value == "success") {
        Navigator.pushNamed(context, '/payment');

          }
        });

      }
    }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text(""),
        leadingAction: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.zero,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .deliverypage_daddress,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .deliverypage_aaddress,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .deliverypage_address,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return AppLocalizations.of(context)
                                          .deliverypage_paddress;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _address = value,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .deliverypage_city,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return AppLocalizations.of(context)
                                          .deliverypage_pcity;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _city = value,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .deliverypage_index_title,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return AppLocalizations.of(context)
                                          .deliverypage_index;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _index = value,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    submitDelivery();
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
                  child: Text(
                    AppLocalizations.of(context).deliverypage_next,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
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
