import 'package:flutter/material.dart';
import 'package:toy_app/pack/lib/bottom_navy_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  int currentIndex = 0;
  final List<bool> isTappedList = [true, false, false, false];
  int _currentIndex = 0;
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
    void onTabTapped(int index) {
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      }
      if (index == 1) {
        Navigator.pushNamed(context, '/categories');
      }
      if (index == 2) {
        Navigator.pushNamed(context, '/cart');
      }
      if (index == 3) {
        Navigator.pushNamed(context, '/saved');
      }
      if (index == 4) {
        Navigator.pushNamed(context, '/profile');
      }
    }

    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: 4,
        showElevation: true,
        itemCornerRadius: 24,
        backgroundColor: Colors.white,
        curve: Curves.easeIn,
        onItemSelected: (index) =>
            {setState(() => _currentIndex = index), onTabTapped(index)},
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeBackColor: const Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.apps),
            title: const Text('Categories'),
            activeBackColor: const Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text('Shopping Cart Items'),
            activeBackColor: const Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite_outline),
            title: const Text('Saved'),
            activeBackColor: const Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            title: const Text('Profile'),
            activeBackColor: const Color(0xFF283488),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey[600],
          ),
        ],
      ),
      body: Column(
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
          Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: width * 0.2,
                        margin: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.02),
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
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text(
                              savedFirstName + " " + savedLastName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
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
              children: const [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Profile Information",
                    style: TextStyle(
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
              children: const [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.badge_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Banking details",
                    style: TextStyle(
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
              children: const [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.pin_drop_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Address",
                    style: TextStyle(
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
              children: const [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Shopping history",
                    style: TextStyle(
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
              children: const [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings_outlined,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Settings",
                    style: TextStyle(
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
