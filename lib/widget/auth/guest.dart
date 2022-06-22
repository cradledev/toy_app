// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toy_app/helper/theme_helper.dart';
import 'package:toy_app/provider/index.dart';
import 'package:toy_app/service/user_auth.dart';

class Guest extends StatefulWidget {
  const Guest({Key key}) : super(key: key);

  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {

  // Appstate setting
  AppState appState;
  // loading status
  bool isProcessing = false;
  // global formkey
  final formKey = GlobalKey<FormState>();
  // text input controller
  TextEditingController userNameController;
  TextEditingController userEmailController;

  // user service setting
  UserService userService;
  @override
  void initState() {
    super.initState();
    onInit();
  }

  // custom init
  void onInit() {
    appState = Provider.of<AppState>(context, listen: false);
    userService = UserService();
    userNameController = TextEditingController();
    userEmailController = TextEditingController();
    setState(() {
      isProcessing = false;
    });
  }

  @override
  void dispose() {
    userEmailController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  void onAsGuset() {
    final bool _isValid = formKey.currentState.validate();
    if (_isValid) {
      setState(() {
        isProcessing = true;
      });
      Map _payloads = {
        "is_guest": true,
        "username": userNameController.text,
        "email": userEmailController.text,
        "password": "isGuest",
      };
      userService.onVisitAsGuest(_payloads).then((_guest) {
        setState(() {
          isProcessing = false;
        });
        appState.user = _guest;
        appState.setLocalStorage(key: 'token', value: _guest.token);
        // navigate Home screen
        Navigator.pushReplacementNamed(context, '/home');
      }).catchError((error) {
        setState(() {
          isProcessing = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: height * 0.9,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          AppLocalizations.of(context).guest_title,
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
                          AppLocalizations.of(context).guest_subtitle,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff999999),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: userNameController,
                              decoration: ThemeHelper().textInputDecoration(
                                lableText:
                                    AppLocalizations.of(context).guest_username,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppLocalizations.of(context)
                                      .guest_validationUsername;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: userEmailController,
                              decoration: ThemeHelper().textInputDecoration(
                                lableText:
                                    AppLocalizations.of(context).guest_email,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppLocalizations.of(context)
                                      .guest_validationUserEmail;
                                }
                                // Check if the entered email has the right format
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return AppLocalizations.of(context)
                                      .login_pvmail;
                                }
                                // Return null if the entered email is valid
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                  onPressed: isProcessing ? null : onAsGuset,
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
                  child: isProcessing
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        )
                      : Text(
                          AppLocalizations.of(context).guest_title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
