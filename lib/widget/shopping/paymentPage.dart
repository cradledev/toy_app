import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/components/components.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _Payment();
}

class _Payment extends State<Payment> {
  bool isClickedCredit = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    String _cardnumber = '';
    String _expiry = '';
    String _cvv = '';

    void submitPayment() async {
      final bool? isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        Navigator.pushReplacementNamed(context, '/order');
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        title: const Text(""),
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 20),
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
                                  AppLocalizations.of(context)!
                                      .paymentpage_pdetail,
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
                                  AppLocalizations.of(context)!
                                      .paymentpage_atext,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .paymentpage_select,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff1d1d1d),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.46,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  margin: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.02),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isClickedCredit = true;
                                      });
                                    },
                                    style: ButtonStyle(
                                      // backgroundColor:
                                      //     MaterialStateProperty.all(_creditColor),
                                      backgroundColor: isClickedCredit
                                          ? MaterialStateProperty.all(
                                              const Color(0xff283488))
                                          : MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(83.0),
                                          side: const BorderSide(
                                              color: Color(0xff283488)),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .paymentpage_credit,
                                      style: TextStyle(
                                        color: isClickedCredit
                                            ? Colors.white
                                            : const Color(0xff283488),
                                        fontSize: 14,
                                        fontFamily: "Avenir Next",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32.0),
                                        topRight: Radius.circular(32.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.46,
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  margin: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.02),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isClickedCredit = false;
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: isClickedCredit
                                          ? MaterialStateProperty.all(
                                              Colors.white)
                                          : MaterialStateProperty.all(
                                              const Color(0xff283488)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(83.0),
                                          side: const BorderSide(
                                              color: Color(0xff283488)),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .paymentpage_debit,
                                      style: TextStyle(
                                          color: isClickedCredit
                                              ? const Color(0xff283488)
                                              : Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32.0),
                                        topRight: Radius.circular(32.0)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .paymentpage_number,
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
                                      return AppLocalizations.of(context)!
                                          .paymentpage_pnumber;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _cardnumber = value,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .paymentpage_expiry,
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
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .paymentpage_pexpiry;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => _expiry = value,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'CVV',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .paymentpage_cvv;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => _cvv = value,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .paymentpage_subtotal,
                              style: const TextStyle(
                                fontFamily: 'Avenir Next',
                                fontSize: 14,
                                color: Color(0xff999999),
                              ),
                            ),
                            const Text(
                              "\$41.98",
                              style: TextStyle(
                                fontFamily: 'Avenir Next',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1d1d1d),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    submitPayment();
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
                    AppLocalizations.of(context)!.paymentpage_confirm,
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
