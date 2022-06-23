import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:toy_app/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/components/custom_drawer_widget.dart';
import 'package:toy_app/helper/constant.dart';
import 'package:toy_app/provider/index.dart';
import 'package:toy_app/service/user_auth.dart';
import 'package:toy_app/widget/profile/addressPage.dart';
import 'package:toy_app/widget/profile/changePasswordPage.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  AppState _appState;
  UserService userService;
  String savedFirstName = '';
  String savedLastName = '';
  String imagePath = '';
  int purchageAmount = 0;
  bool isPageLoading = false;
  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    userService = UserService();
    if (mounted) {
      setState(() {
        isPageLoading = true;
      });
      getUserInfo();
    }
  }

  void onLogout() async {
    userService.onLogout(_appState.user.token).then((value) {
      _appState.resetState();
      _appState.setLocalStorage(key: 'user', value: '');
      _appState.setLocalStorage(key: 'token', value: '');
      Navigator.pushNamed(context, '/');
    }).catchError((error) {});
  }

  void getUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _token = _appState.user.token;
    var _profileInfoRes = await http.get(
      Uri.parse("$apiEndPoint/Customer/info"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        "Authorization": "Bearer $_token"
      },
    );
    var _body = jsonDecode(_profileInfoRes.body);
    var _orderInfoRes = await http.get(
      Uri.parse("$apiEndPoint/Order/CustomerOrders"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        "Authorization": "Bearer $_token"
      },
    );
    var _orderBody = jsonDecode(_orderInfoRes.body);
    if (mounted) {
      setState(() {
        savedFirstName = _body['first_name'] ?? "";
        savedLastName = _body['last_name'] ?? "";
        imagePath = (_prefs.getString('path') ?? "");
        purchageAmount = (_orderBody['orders'] as List).isEmpty ?? true
            ? 0
            : (_orderBody['orders'] as List).length;
      });
      _appState.profileAddress1 = _body['street_address'];
      _appState.profileCity = _body['city'];
      _appState.countryId = _body['country_id'] ?? 234;
      _appState.firstName = _body['first_name'];
      _appState.lastName = _body['last_name'];
      _appState.phoneNumber = _body['phone'];
      var _bioAttr = (_body['customer_attributes'] as List)
          .where((e) => e['name'] == "bio")
          .toList();
      _appState.bio = _bioAttr.isEmpty ? null : _bioAttr[0];
      setState(() {
        isPageLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        leadingIcon: const Icon(
          CupertinoIcons.line_horizontal_3,
          size: 30,
          color: Colors.black,
        ),
      ),
      drawer: const CustomDrawerWidget(),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 4),
      body: isPageLoading
          ? Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  )),
            )
          : Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.transparent,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CircleAvatar(
                                  radius: 50.0,
                                  child: imagePath == ''
                                      ? Image.asset(
                                          "assets/img/home/avatar.jpg",
                                          fit: BoxFit.fill,
                                        )
                                      : Image.file(
                                          File(imagePath),
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                            "$savedFirstName $savedLastName",
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Text(
                                      purchageAmount.toString() + " purchase",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.1,
                        )
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    Navigator.pushNamed(context, '/edit'),
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).profilepage_info,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                // InkWell(
                //   onTap: () => {},
                //   child: Row(
                //     children: [
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       const Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Icon(
                //           Icons.badge_outlined,
                //           size: 25,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           AppLocalizations.of(context).profilepage_bank,
                //           style: const TextStyle(
                //             fontSize: 18,
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                              opacity: animation, child: const AddressPage());
                        },
                      ),
                    )
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.pin_drop_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).profilepage_address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialogBox();
                        });
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.language_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).language,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                              opacity: animation,
                              child: const ChangePasswordPage());
                        },
                      ),
                    )
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.settings_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).changepassword_title,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    onLogout();
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context).profilepage_logout,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
