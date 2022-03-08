import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:toy_app/service/user_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenPage();
}

class _LoginScreenPage extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpwd = TextEditingController();
  String _userEmail = '';
  String _userPwd = '';
  final UserService _userService = UserService();
  // final TextEditingController _passwordController = TextEditingController();
  void submitLogin() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      String response = await _userService.login(_userEmail, _userPwd);
      if (response == 'success') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sorry, sir!"),
                content: const Text("Authentication failed!"),
                actions: [
                  ElevatedButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, height * 0.05, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/auth');
                    // Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.15, height * 0.05, 0, 0),
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
                            "Login",
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Avenir Next',
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
                            "Please log in to your account to continue",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
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
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _useremail,
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
                                return 'Please enter your email address';
                              }
                              // Check if the entered email has the right format
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              // Return null if the entered email is valid
                              return null;
                            },
                            onChanged: (value) => _userEmail = value,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _userpwd,
                            obscureText: true,
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
                                return 'This field is required';
                              }
                              if (value.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              // Return null if the entered password is valid
                              return null;
                            },
                            onChanged: (value) => _userPwd = value,
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Row(
                        children: const [
                          Text("Forget your password?"),
                          Text(
                            "Tap here",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.2,
                ),
                SizedBox(
                  height: height * 0.07,
                  width: width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      submitLogin();
                      // Navigator.pushReplacementNamed(context, '/home');
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
                      'Login',
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
