import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference productsRef =
    FirebaseFirestore.instance.collection('products');

class MyProduct extends ChangeNotifier {
  int selectedColors = 0;
  int selectedStorage = 0;
  int selectedPrice = 0;
  int quantity = 1;
  String selectedImage = '';

  updatePrice(int index) {
    selectedStorage = index;
    selectedPrice = index;
    notifyListeners();
  }

  updateColor(int index) {
    selectedColors = index;
    notifyListeners();
  }

  updateImage(DocumentSnapshot e) {
    selectedImage = e['colors'][selectedColors];
    notifyListeners();
  }

  updateAll() {
    updateColor(0);
    updatePrice(0);
    quantity = 1;
    notifyListeners();
  }

  addQuantity() {
    if (quantity > 1) {
      quantity = quantity - 1;
    }
    notifyListeners();
  }

  removeQuantity(int limit) {
    if (limit > quantity) {
      quantity = quantity + 1;
      notifyListeners();
    }
  }
}
