import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/Tabs/Tabs.dart';
import 'package:realme_clone/pages/catogries/buy&cart/checkout.dart';
import 'package:realme_clone/pages/login/auth.dart';

final user = FirebaseAuth.instance.currentUser;

CollectionReference addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('address');

class BuyNowPopUp extends StatefulWidget {
  final String productId;
  final bool menu;
  final bool cart;
  const BuyNowPopUp({
    Key? key,
    required this.productId,
    required this.menu,
    required this.cart,
  }) : super(key: key);

  @override
  _BuyNowPopUpState createState() => _BuyNowPopUpState();
}

class _BuyNowPopUpState extends State<BuyNowPopUp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int selectedStorage = context.watch<MyProduct>().selectedStorage;
    int selectedColors = context.watch<MyProduct>().selectedColors;
    int selectedPrice = context.watch<MyProduct>().selectedPrice;
    int quantity = context.watch<MyProduct>().quantity;
    return StreamBuilder<DocumentSnapshot>(
        stream: productRef.doc(widget.productId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.hasData) {
            Map<String, dynamic> e =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              padding: EdgeInsets.all(width * 0.04),
              height: height * 0.832,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: width * 0.01),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: width * 0.16,
                        width: width * 0.16,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(e['colors-img'][selectedColors]),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.045),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹',
                                style: TextStyle(
                                    fontSize: width * 0.037,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                              Text(
                                e['price'][selectedPrice].toString(),
                                style: TextStyle(
                                    fontSize: width * 0.052,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: width * 0.017),
                          Text(
                            'Selected: ${e['colors'][selectedColors]} ${e['storage'][selectedStorage]}  x $quantity',
                            style: TextStyle(fontSize: width * 0.034),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.06),
                  Container(
                    height: height * 0.55,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Color',
                            style: TextStyle(fontSize: width * 0.036),
                          ),
                          SizedBox(height: height * 0.01),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < e['colors'].length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      context.read<MyProduct>().updateColor(i);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(width * 0.05),
                                      margin:
                                          EdgeInsets.only(right: width * 0.032),
                                      decoration: selectedColors == i
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.yellow.shade700
                                                    .withOpacity(0.5),
                                              ),
                                              color: Colors.yellow.shade800
                                                  .withOpacity(0.07))
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: width * 0.2,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        e['colors-img'][i]))),
                                          ),
                                          SizedBox(height: height * 0.016),
                                          Text(
                                            e['colors'][i],
                                            style: TextStyle(
                                                fontSize: width * 0.034),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.028),
                          e['categories'] == 'realme Smartphones'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' Storage',
                                      style: TextStyle(fontSize: width * 0.036),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Wrap(
                                      children: [
                                        for (int i = 0;
                                            i < e['storage'].length;
                                            i++)
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<MyProduct>()
                                                  .updatePrice(i);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.04,
                                                  vertical: width * 0.027),
                                              margin: EdgeInsets.only(
                                                  right: width * 0.03),
                                              decoration: selectedStorage == i
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors
                                                            .yellow.shade700
                                                            .withOpacity(0.5),
                                                      ),
                                                      color: Colors
                                                          .yellow.shade800
                                                          .withOpacity(0.07))
                                                  : BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                    ),
                                              child: Text(
                                                e['storage'][i],
                                                style: TextStyle(
                                                    fontSize: width * 0.034),
                                              ),
                                            ),
                                          ),
                                        SizedBox(height: height * 0.08),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(''),
                          Row(
                            children: [
                              Text(' Quantity '),
                              Text(
                                '(Limited purchase of ${e['quantity-limit']} pieces per person)',
                                style: TextStyle(
                                  fontSize: width * 0.027,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: height * 0.032),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: width * 0.005),
                                  height: width * 0.092,
                                  width: width * 0.092,
                                  decoration: BoxDecoration(
                                    color: quantity == 1
                                        ? Colors.grey.shade100.withOpacity(0.7)
                                        : Colors.grey.shade200,
                                  ),
                                  alignment: Alignment.center,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      context.read<MyProduct>().addQuantity();
                                    },
                                    child: Icon(Icons.remove,
                                        color: quantity < 2
                                            ? Colors.grey.shade400
                                            : Colors.black,
                                        size: width * 0.055),
                                  )),
                              Container(
                                margin: EdgeInsets.only(right: width * 0.005),
                                height: width * 0.092,
                                width: width * 0.092,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(fontSize: width * 0.042),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: width * 0.005),
                                  height: width * 0.092,
                                  width: width * 0.092,
                                  decoration: BoxDecoration(
                                    color: quantity == 10
                                        ? Colors.grey.shade100.withOpacity(0.7)
                                        : Colors.grey.shade200,
                                  ),
                                  alignment: Alignment.center,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      context
                                          .read<MyProduct>()
                                          .removeQuantity(e['quantity-limit']);
                                    },
                                    child: Icon(Icons.add,
                                        color: quantity == e['quantity-limit']
                                            ? Colors.grey.shade400
                                            : Colors.black,
                                        size: width * 0.055),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.menu
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                addToCart(e, selectedStorage, selectedStorage,
                                    selectedPrice, quantity);
                              },
                              child: Container(
                                width: width * 0.46,
                                height: height * 0.0632,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: width * 0.041,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CheckOut(productId: widget.productId)));
                              },
                              child: Container(
                                width: width * 0.46,
                                height: height * 0.0632,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade800
                                        .withOpacity(0.85),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    )),
                                alignment: Alignment.center,
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    fontSize: width * 0.041,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: width,
                          height: height * 0.0632,
                          decoration: BoxDecoration(
                              color: widget.cart
                                  ? Colors.grey.shade800.withOpacity(0.9)
                                  : Colors.yellow.shade800.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(30)),
                          child: RawMaterialButton(
                            onPressed: () {
                              if (widget.cart) {
                                addToCart(e, selectedStorage, selectedStorage,
                                    selectedPrice, quantity);
                              } else if (FirebaseAuth.instance.currentUser ==
                                  null) {
                                signInWithGoogle(context,
                                    CheckOut(productId: widget.productId));
                              } else {
                                context.read<UserAddress>().addressAvailable();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CheckOut(productId: widget.productId),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: widget.cart
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else
            return CircularProgressIndicator(color: Colors.yellow.shade800);
        });
  }

  Future addToCart(
      Map<String, dynamic> e, int color, storage, price, quantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('cart')
          .add({
        'product name': e['name'],
        'color': e['colors'][color],
        'storage': e['storage'][storage],
        'quantity': quantity,
        'price': e['price'][price],
        'icon': e['colors-img'][color],
        'productId': widget.productId,
        'quantity-limit': e['quantity-limit'],
        'selected': false,
      });
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
