import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _Auth();
}

class _Auth extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Image(
              image: const AssetImage(
                'assets/img/LoginRegistration/header.png',
              ),
              fit: BoxFit.scaleDown,
              height: height * 0.1,
            ),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          const Text(
            "Welcome",
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
            "Welcome back! Login with your data that you",
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 14,
              color: Color(0xff999999),
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "entered during registration.",
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 14,
              color: Color(0xff999999),
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.1,
          ),
          SizedBox(
            height: height * 0.07,
            width: width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
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
                'Log in',
                style: TextStyle(color: const Color(0xff283488), fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            height: height * 0.07,
            width: width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
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
                'Sign up',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
