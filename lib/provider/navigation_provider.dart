import 'package:flutter/material.dart';
import 'package:toy_app/model/navigation_item.dart';


class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.header;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}
