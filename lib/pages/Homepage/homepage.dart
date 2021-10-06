import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/Homepage/home.dart';
import 'package:realme_clone/pages/cart/cart.dart';
import 'package:realme_clone/pages/catogries/catogries.dart';
import 'package:realme_clone/pages/profile/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      FirebaseAuth.instance.currentUser == null
          ? setState(() {})
          : context.read<UserAddress>().addressAvailable();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _selectedIndex == 0
          ? Home()
          : _selectedIndex == 1
              ? Catogries()
              : _selectedIndex == 2
                  ? Cart(
                      fromDetail: false,
                    )
                  : Profile(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: width * 0.0295,
        unselectedFontSize: width * 0.0295,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Icons.grid_view)
                : Icon(Icons.grid_view_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.shopping_cart)
                : Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(Icons.person)
                : Icon(Icons.person_outline),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
