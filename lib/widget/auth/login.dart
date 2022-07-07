import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/model/user_model.dart';

import 'package:toy_app/provider/index.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/service/user_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenPage();
}

class _LoginScreenPage extends State<LoginScreen> {
  // app state
  AppState _appState;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpwd = TextEditingController();
  String _userEmail = '';
  String _userPwd = '';

  Map userInfo;

  // userservice setting
  UserService userService;
  // indicator status
  bool _loadingStatus = false;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      _loadingStatus = false;
      _passwordVisible = false;
    });
    _appState = Provider.of<AppState>(context, listen: false);
    userService = UserService();
  }

  // final TextEditingController _passwordController = TextEditingController();
  void submitLogin() {
    final bool isValid = _formKey.currentState.validate();
    if (isValid == true) {
      setState(() {
        _loadingStatus = true;
      });
      userInfo = {'email': _userEmail, 'password': _userPwd};
      userService.onLogin(userInfo).then((value) {
        setState(() {
          _loadingStatus = false;
        });
        _appState.user = UserModel.fromJson(value);
        _appState.setLocalStorage(key: 'user', value: jsonEncode(value));
        _appState.setLocalStorage(key: 'token', value: value['token']);
        Navigator.pushReplacementNamed(context, '/home');
      }).catchError((error) {
        setState(() {
          _loadingStatus = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).login_text1),
              content: Text(AppLocalizations.of(context).login_text2),
              actions: [
                ElevatedButton(
                  child: Text(AppLocalizations.of(context).login_ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: MediaQuery.of(context).size.height * 0.9,
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
                        Text(
                          AppLocalizations.of(context).login_login,
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Avenir Next',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context).login_plogin,
                          style: const TextStyle(
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
                                    Text(
                                      AppLocalizations.of(context).login_email,
                                      style: const TextStyle(
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
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return AppLocalizations.of(context)
                                              .login_pmail;
                                        }
                                        // Check if the entered email has the right format
                                        if (!RegExp(r'\S+@\S+\.\S+')
                                            .hasMatch(value)) {
                                          return AppLocalizations.of(context)
                                              .login_pvmail;
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
                                    Text(
                                      AppLocalizations.of(context).login_pwd,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: _userpwd,
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return AppLocalizations.of(context)
                                              .login_rpwd;
                                        }
                                        if (value.trim().length < 8) {
                                          return AppLocalizations.of(context)
                                              .login_vpwd;
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
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text:
                                                    AppLocalizations.of(context)
                                                        .login_fpwd,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                                children: [
                                                  TextSpan(
                                                    text: " ${AppLocalizations.of(
                                                            context)
                                                        .login_tap}",
                                                    style: const TextStyle(
                                                        color: Color(0xff283488),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () => print(
                                                              'Tap Here onTap'),
                                                  )
                                                ]),
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
              SizedBox(
                height: 60,
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
                  child: _loadingStatus
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        )
                      : Text(
                          AppLocalizations.of(context).login_login,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
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
