import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

CollectionReference addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('address');
final user = FirebaseAuth.instance.currentUser;

class UserAddress extends ChangeNotifier {
  bool hasAddress = false;
  String defaultAdd = '';
  String selectedAddress = '';

  addressAvailable() {
    addressRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.length == 0) {
        hasAddress = false;
      } else {
        hasAddress = true;
      }
      print(hasAddress);
      if (hasAddress) {
        defaultAddress();
      }
      notifyListeners();
    });
  }

  defaultAddress() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot doc) {
      defaultAdd = doc['default-address'];
      selectedAddress = doc['default-address'];
      print(defaultAdd);
    });
    notifyListeners();
  }

  selectAddress(String selectedAdd) {
    selectedAddress = selectedAdd;
    notifyListeners();
  }
}
