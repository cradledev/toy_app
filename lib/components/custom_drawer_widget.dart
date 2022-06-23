import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_app/model/navigation_item.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:toy_app/provider/index.dart';
import 'package:toy_app/provider/navigation_provider.dart';

class CustomDrawerWidget extends StatelessWidget {
  static const padding = EdgeInsets.symmetric(horizontal: 20);

  const CustomDrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Drawer(
      child: Container(
        color: Colors.blue.shade500,
        child: ListView(
          children: <Widget>[
            buildHeader(
              context,
              urlImage: "urlImage",
              name: "name",
              email: "email",
            ),
            const SizedBox(height: 10),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const ListTile(
                  //   contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  //   title: Text(
                  //     "Auth",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        buildMenuItem(context,
                            item: NavigationItem.home,
                            text: AppLocalizations.of(context).babytoyspage_home,
                            icon: Icons.home)
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        appState?.user?.isGuest == false
                            ? buildMenuItem(context,
                                item: NavigationItem.setting,
                                text: AppLocalizations.of(context).profilepage_setting,
                                icon: Icons.settings)
                            : const SizedBox(
                                height: 0,
                              )
                      ],
                    ),
                  ),
                  appState?.user?.isGuest == false
                      ? const Divider(color: Colors.white70)
                      : const SizedBox(
                          height: 0,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        appState?.user?.isGuest == true
                            ? buildMenuItem(context,
                                item: NavigationItem.login,
                                text: AppLocalizations.of(context).login_login,
                                icon: Icons.login_outlined)
                            : buildMenuItem(context,
                                item: NavigationItem.logout,
                                text: AppLocalizations.of(context).profilepage_logout,
                                icon: Icons.logout_outlined),
                      ],
                    ),
                  ),
                  // const Divider(color: Colors.white70),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: Column(
                  //     children: [
                  //       appState?.user?.isGuest == false
                  //           ? buildMenuItem(context,
                  //               item: NavigationItem.contactUS,
                  //               text: 'Contact US',
                  //               icon: Icons.contact_page_outlined)
                  //           : const SizedBox(
                  //               height: 0,
                  //             ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    NavigationItem item,
    String text,
    IconData icon,
  }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final color = isSelected ? Colors.orangeAccent : Colors.white;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: (() => selectItem(context, item)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            // ),
            Expanded(
              child: Row(
                children: [
                  icon != null
                      ? Icon(icon, color: color)
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 5, top: 7, bottom: 7, right: 5),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
    onGoPage(context, item);
  }

  void onGoPage(BuildContext context, NavigationItem item) async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    switch (item) {
      case NavigationItem.logout:
        appState.setLocalStorage(key: "user", value: "");
        appState.setLocalStorage(key: "key", value: "");
        appState.setLocalStorage(key: "token", value: "");
        appState.resetState();
        Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
        break;
      case NavigationItem.login:
        Navigator.pushNamed(context, '/auth');
        break;
      case NavigationItem.home:
        Navigator.pushNamed(context, '/home');
        break;
      case NavigationItem.setting:
        Navigator.pushNamed(
          context,
          '/profile',
        );
        break;
      case NavigationItem.header:
        break;
      default:
        break;
    }
  }

  Widget buildHeader(
    BuildContext context, {
    String urlImage,
    String name,
    String email,
  }) {
    AppState appState = Provider.of<AppState>(context, listen: false);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => selectItem(context, NavigationItem.header),
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
              Image.asset(
                'assets/img/LoginRegistration/header.png',
                // height: height * 0.1,
                fit: BoxFit.fill,
              ),
              // const SizedBox(height: 20),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Column(
              //       children: [
              //         Text(
              //           appState.user != null ? appState.user['email'] : "",
              //           textAlign: TextAlign.center,
              //           style: const TextStyle(
              //             fontSize: 18,
              //             color: Colors.white,
              //             height: 1.5,
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 4),
              //     Text(
              //       appState.user != null ? appState.user['type'] : "",
              //       style: const TextStyle(fontSize: 14, color: Colors.white),
              //     ),
              //   ],
              // ),
              // const Spacer(),
              // const CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
