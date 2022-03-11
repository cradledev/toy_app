import 'package:flutter/material.dart';
import 'package:toy_app/service/user_auth.dart';
import 'package:toy_app/components/components.dart';

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

  // indicator status
  bool _loadingStatus = false;
  late UserService _userService;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _userService = UserService();
    _loadingStatus = false;
  }

  // final TextEditingController _passwordController = TextEditingController();
  void submitLogin() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      setState(() {
        _loadingStatus = true;
      });
      Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          _loadingStatus = false;
        });
        Navigator.pushReplacementNamed(context, '/home');
      });
      // String response = await _userService.login(_userEmail, _userPwd);
      // if (response == 'success') {
      //   setState(() {
      //     _loadingStatus = false;
      //   });
      //   Navigator.pushReplacementNamed(context, '/home');
      // } else {
      //   setState(() {
      //     _loadingStatus = false;
      //   });
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: const Text("Sorry, sir!"),
      //         content: const Text("Authentication failed!"),
      //         actions: [
      //           ElevatedButton(
      //             child: const Text("Ok"),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           )
      //         ],
      //       );
      //     },
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Avenir Next',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Please log in to your account to continue",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff999999),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.zero,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter your email address';
                                      }
                                      // Check if the entered email has the right format
                                      if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      // Return null if the entered email is valid
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _userEmail = value;
                                      });
                                    },
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      if (value.trim().length < 8) {
                                        return 'Password must be at least 8 characters in length';
                                      }
                                      // Return null if the entered password is valid
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _userPwd = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: const [
                                        Text("Forget your password?"),
                                        Text(
                                          "Tap here",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: (_loadingStatus)
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff283488)),
                      strokeWidth: 2)
                  : const SizedBox(
                      height: 0,
                    ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: _loadingStatus ? null : submitLogin,
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
                    _loadingStatus ? "Hold on..." : "Login",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
