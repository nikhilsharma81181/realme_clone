import 'package:flutter/material.dart';

class ProductDetails extends ChangeNotifier {
  String productName = '';
  String storage = '';
  String color = '';
  int totalPrice = 0;
  String icon = '';

  getProductDetails(String name, stge, col, pic, int totalprice) {
    productName = name;
    storage = stge;
    color = col;
    icon = pic;
    totalPrice = totalprice;
    notifyListeners();
  }
}
