import 'package:flutter/material.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(20, height * 0.1, 0, height * 0.02),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text(
                            "Payment Details",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        children: const [
                          Text(
                            "Add your payment information",
                            style: TextStyle(
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Row(
                        children: const [
                          Text(
                            "Select your payment method",
                            style: TextStyle(
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
                            padding: const EdgeInsets.only(left: 10),
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
                                    : MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(83.0),
                                    side: const BorderSide(
                                        color: Color(0xff283488)),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Credit card',
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
                            padding: const EdgeInsets.only(right: 10),
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
                                    ? MaterialStateProperty.all(Colors.white)
                                    : MaterialStateProperty.all(
                                        const Color(0xff283488)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(83.0),
                                    side: const BorderSide(
                                        color: Color(0xff283488)),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Debit card',
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
                          const Text(
                            "Card number",
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter card number';
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "Expiry",
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
                                      return 'Please enter expiry.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _expiry = value,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      return 'Please enter cvv.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => _cvv = value,
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 8, 0, height * 0.03),
                      child: const Text(
                        "Subtotal",
                        style: TextStyle(
                          fontFamily: 'Avenir Next',
                          fontSize: 14,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(width * 0.5, 8, 0, height * 0.03),
                      child: const Text(
                        "\$41.98",
                        style: TextStyle(
                          fontFamily: 'Avenir Next',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d1d1d),
                        ),
                      ),
                    ),
                  ],
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
                    child: const Text(
                      'Confirm and Pay',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
