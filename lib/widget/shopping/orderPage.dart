import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _Order();
}

class _Order extends State<Order> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff283488),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.25, height * 0.05, 0, 0),
                child: SizedBox(
                  height: height * 0.1,
                  width: width * 0.5,
                  child: Image.asset(
                    "assets/img/LoginRegistration/header.png",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.35, 0, 0, 0),
                child: SizedBox(
                  height: height * 0.3,
                  width: width * 0.3,
                  child: Image.asset(
                    "assets/img/Shopping cart and Checkout/5.png",
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              "Order placed",
              style: TextStyle(
                fontSize: 32,
                fontFamily: "Avenir Next",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(
              "Your order has been successfully processed! Stay",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Avenir Next",
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              "turned for delivery news.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Avenir Next",
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.2,
          ),
          SizedBox(
            height: height * 0.07,
            width: width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(83.0),
                    side: const BorderSide(color: Color(0xff283488)),
                  ),
                ),
              ),
              child: const Text(
                'Okay',
                style: TextStyle(color: Color(0xff283488), fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
