import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:realme_clone/models/change-model.dart';

import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/Tabs/Tabs.dart';
import 'package:realme_clone/pages/cart/checkout-cart.dart';
import 'package:realme_clone/pages/catogries/detail.dart';
import 'package:realme_clone/pages/login/auth.dart';

final user = FirebaseAuth.instance.currentUser;
CollectionReference cartRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('cart');

class Cart extends StatefulWidget {
  final bool fromDetail;
  const Cart({Key? key, required this.fromDetail}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.fromDetail
          ? Colors.grey.shade200
          : Colors.grey.shade300.withOpacity(0.5),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (widget.fromDetail) Navigator.of(context).pop();
          },
          child: Container(
            height: width * 0.2,
            alignment: Alignment.center,
            child: widget.fromDetail
                ? Row(
                    children: [
                      SizedBox(
                        width: width * 0.025,
                      ),
                      Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: width * 0.052),
                      Text(
                        'My Cart',
                        style: TextStyle(
                          fontSize: width * 0.047,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: width * 0.047,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
        elevation: 0,
        leadingWidth: widget.fromDetail ? width * 0.32 : width * 0.24,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirebaseAuth.instance.currentUser == null
                ? Container(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.32),
                        Text(
                          'Missing Cart items ?',
                          style: TextStyle(
                            fontSize: width * 0.047,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'Login In to see the Items you added previously',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: height * 0.035),
                        Container(
                          width: width * 0.28,
                          height: width * 0.11,
                          decoration: BoxDecoration(
                            color: Colors.amber[700],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: RawMaterialButton(
                            onPressed: () {
                              signInWithGoogle(
                                context,
                                Cart(fromDetail: false),
                              );
                            },
                            child: Text(
                              'login',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : cartProduct()
          ],
        ),
      ),
      bottomSheet: FirebaseAuth.instance.currentUser == null
          ? Container(
              height: 1,
              width: 1,
            )
          : Container(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.015, horizontal: width * 0.037),
              child: StreamBuilder<QuerySnapshot>(
                stream: cartRef.snapshots(),
                builder: (context, snapshot) {
                  int totalPrice = 0;

                  if (snapshot.hasData) {
                    snapshot.data!.docs.forEach((DocumentSnapshot e) {
                      int price = e['price'];
                      totalPrice = totalPrice + price;
                    });
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total: '),
                      Text(
                        '₹',
                        style: TextStyle(
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        totalPrice.toString(),
                        style: TextStyle(
                          fontSize: width * 0.048,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: width * 0.028),
                      Container(
                        width: width * 0.32,
                        height: width * 0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(colors: [
                              Colors.yellow,
                              Colors.yellow.shade800.withOpacity(0.9),
                            ])),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            context.read<UserAddress>().defaultAddress();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CheckOutAll()));
                          },
                          child: Text('Place Order'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }

  Widget cartProduct() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: StreamBuilder(
            stream: cartRef.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('something went wrong'),
                );
              } else if (snapshot.data == null) {
                return Container(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.yellow.shade700,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return emptyCart();
              } else if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.docs
                      .map((e) => GestureDetector(
                            onTap: () {
                              context.read<MyProduct>().updateAll();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(productId: e['productId'])));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: width * 0.025),
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.022,
                                  vertical: width * 0.011),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.15,
                                            height: width * 0.15,
                                            child: Image(
                                                image: NetworkImage(e['icon'])),
                                          ),
                                          SizedBox(width: width * 0.02),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e['product name'],
                                                style: TextStyle(
                                                    fontSize: width * 0.038,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                e['color'],
                                                style: TextStyle(
                                                    fontSize: width * 0.033,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                              SizedBox(height: height * 0.002),
                                              Text(
                                                e['storage'],
                                                style: TextStyle(
                                                    fontSize: width * 0.033,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '₹${e['price']}',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          Text(
                                            'x${e['quantity']}',
                                            style: TextStyle(
                                              fontSize: width * 0.0322,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          removeFromCart(e.id);
                                        },
                                        child: Text(
                                          'Remove from cart',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: width * 0.005),
                                              height: width * 0.07,
                                              width: width * 0.07,
                                              decoration: BoxDecoration(
                                                color: e['quantity'] == 1
                                                    ? Colors.grey.shade100
                                                        .withOpacity(0.7)
                                                    : Colors.grey.shade200,
                                              ),
                                              alignment: Alignment.center,
                                              child: RawMaterialButton(
                                                onPressed: () {
                                                  if (e['quantity'] != 1) {
                                                    removeQuantity(
                                                        e.id, e['quantity']);
                                                  }
                                                },
                                                child: Icon(Icons.remove,
                                                    color: e['quantity'] < 2
                                                        ? Colors.grey.shade400
                                                        : Colors.black,
                                                    size: width * 0.04),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: width * 0.005),
                                            height: width * 0.07,
                                            width: width * 0.07,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              e['quantity'].toString(),
                                              style: TextStyle(
                                                  fontSize: width * 0.037),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: width * 0.005),
                                            height: width * 0.07,
                                            width: width * 0.07,
                                            decoration: BoxDecoration(
                                              color: e['quantity'] ==
                                                      e['quantity-limit']
                                                  ? Colors.grey.shade100
                                                      .withOpacity(0.7)
                                                  : Colors.grey.shade200,
                                            ),
                                            alignment: Alignment.center,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                if (e['quantity'] !=
                                                    e['quantity-limit']) {
                                                  addQuantity(
                                                      e.id, e['quantity']);
                                                }
                                              },
                                              child: Icon(Icons.add,
                                                  color: e['quantity'] ==
                                                          e['quantity-limit']
                                                      ? Colors.grey.shade400
                                                      : Colors.black,
                                                  size: width * 0.04),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              } else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.yellow.shade700,
                    ),
                  ],
                );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.047, horizontal: width * 0.035),
          child: Text(
            'Recommended',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.039,
                color: Colors.black),
          ),
        ),
        Container(
          width: width,
          padding: EdgeInsets.all(width * 0.02),
          child: FutureBuilder(
            future: productRef.orderBy('created', descending: true).get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  width: 10,
                  height: 10,
                );
              }
              if (snapshot.hasData) {
                return Wrap(
                  spacing: width * 0.015,
                  alignment: WrapAlignment.start,
                  runSpacing: width * 0.02,
                  children: snapshot.data!.docs
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            context.read<MyProduct>().updateAll();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Detail(productId: e.id),
                              ),
                            );
                          },
                          child: Container(
                            width: width * 0.469,
                            height: width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.38,
                                  height: width * 0.38,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(e['icon']))),
                                ),
                                SizedBox(height: height * 0.042),
                                Text(
                                  e['name'],
                                  style: TextStyle(
                                      fontSize: width * 0.036,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: height * 0.02),
                                Text(
                                  '₹${e['price'][0]}',
                                  style: TextStyle(
                                      fontSize: width * 0.038,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              } else
                return Container(
                  width: 10,
                  height: 10,
                );
            },
          ),
        ),
      ],
    );
  }

  Future removeFromCart(String docId) async {
    cartRef.doc(docId).delete();
    setState(() {});
  }

  Future addQuantity(String docId, int quantity) async {
    cartRef.doc(docId).update({
      'quantity': quantity + 1,
    });
  }

  Future removeQuantity(String docId, int quantity) async {
    cartRef.doc(docId).update({
      'quantity': quantity - 1,
    });
  }

  Widget emptyCart() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height * 0.45,
          width: width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: width * 0.32,
                color: Colors.blue.shade200,
              ),
              Text(
                'Your cart is empty.',
                style: TextStyle(
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
