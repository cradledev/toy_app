import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:toy_app/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  String savedFirstName = '';
  String savedLastName = '';
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      savedFirstName = (savedPref.getString('first_name') ?? "");
      savedLastName = (savedPref.getString('last_name') ?? "");
      imagePath = (savedPref.getString('path') ?? "");
    });
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
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: const LanguageTransitionWidget(),
      bottomNavigationBar:
          CustomBottomNavbar(context: context, selectedIndex: 4),
      body: Column(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: width * 0.2,
                        margin: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 38.0,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              savedFirstName + " " + savedLastName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "68 purchase",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
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
                    AppLocalizations.of(context)!.profilepage_info,
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
            onTap: () => {},
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.badge_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.profilepage_bank,
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
            onTap: () => {},
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
                    AppLocalizations.of(context)!.profilepage_address,
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
            onTap: () => {},
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.profilepage_history,
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
            onTap: () => {},
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
                    AppLocalizations.of(context)!.profilepage_setting,
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
