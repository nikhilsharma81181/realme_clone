import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/catogries/buy&cart/address.dart';
import 'package:realme_clone/pages/catogries/buy&cart/payment.dart';

CollectionReference addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('address');
CollectionReference cartRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('cart');

final user = FirebaseAuth.instance.currentUser;

class CheckOutAll extends StatefulWidget {
  const CheckOutAll({Key? key}) : super(key: key);

  @override
  _CheckOutAllState createState() => _CheckOutAllState();
}

class _CheckOutAllState extends State<CheckOutAll> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String address = context.watch<UserAddress>().selectedAddress;
    bool hasAddress = context.watch<UserAddress>().hasAddress;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Check Out',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.022, vertical: width * 0.05),
        width: width,
        color: Colors.grey.shade300.withOpacity(0.7),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Address(
                          buying: true,
                        )));
              },
              child: !hasAddress
                  ? Container(
                      width: width,
                      height: width * 0.32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: width * 0.08,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            'Selected Address',
                            style: TextStyle(
                              fontSize: width * 0.044,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : address == ''
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FutureBuilder<DocumentSnapshot>(
                          future: addressRef.doc(address).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              Map<String, dynamic> e =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Container(
                                padding: EdgeInsets.all(width * 0.05),
                                width: width,
                                height: height * 0.132,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e['Full Name'],
                                            style: TextStyle(
                                                fontSize: width * 0.039,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: height * 0.007),
                                        Text(e['Mobile Number'],
                                            style: TextStyle(
                                                fontSize: width * 0.038,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: height * 0.007),
                                        Text(e['State'])
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: width * 0.042,
                                    )
                                  ],
                                ),
                              );
                            } else
                              return CircularProgressIndicator(
                                  color: Colors.yellow.shade700);
                          }),
            ),
            SizedBox(height: height * 0.014),
            Row(
              children: [
                Text(
                  '  Product List',
                  style: TextStyle(
                    fontSize: width * 0.038,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.005),
            StreamBuilder(
              stream: cartRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                int totalPrice = 0;
                int totalQuantity = 0;
                if (snapshot.hasError) {
                  return Container();
                }
                if (snapshot.hasData) {
                  snapshot.data!.docs.forEach((DocumentSnapshot e) {
                    int price = e['price'];
                    totalPrice = totalPrice + price;

                    int quantity = e['quantity'];
                    totalQuantity = totalQuantity + quantity;
                  });
                  return Column(
                    children: [
                      Column(
                          children: snapshot.data!.docs
                              .map(
                                (e) => Container(
                                  padding: EdgeInsets.all(width * 0.05),
                                  margin: EdgeInsets.symmetric(
                                      vertical: width * 0.01),
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: width * 0.17,
                                                height: width * 0.17,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e['icon']))),
                                              ),
                                              SizedBox(width: width * 0.045),
                                              Container(
                                                width: width * 0.45,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      e['product name'],
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.04),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e['color'],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.036,
                                                              color: Colors.grey
                                                                  .shade600),
                                                        ),
                                                        Text(
                                                          e['storage'],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.036,
                                                              color: Colors.grey
                                                                  .shade600),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                e['price'].toString(),
                                                style: TextStyle(
                                                    fontSize: width * 0.037,
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                e['quantity'].toString(),
                                                style: TextStyle(
                                                  fontSize: width * 0.03,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList()),
                      SizedBox(height: height * 0.014),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            amountList('Quantity', totalQuantity.toString()),
                            SizedBox(height: height * 0.01),
                            amountList('Items Subtotal', totalPrice.toString()),
                            SizedBox(height: height * 0.01),
                            amountList('Discount', '- ₹0'),
                            SizedBox(height: height * 0.01),
                            amountList('Shipping', '+ ₹0'),
                          ],
                        ),
                      ),
                    ],
                  );
                } else
                  return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
          stream: cartRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int totalPrice = 0;
              snapshot.data!.docs.forEach((DocumentSnapshot e) {
                int price = e['price'];
                totalPrice = totalPrice + price;
              });
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Total:  '),
                          Text(
                            '₹',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            totalPrice.toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        height: width * 0.12,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: hasAddress
                              ? Colors.yellow.shade700
                              : Colors.grey.shade300,
                        ),
                        child: RawMaterialButton(
                          onPressed: () {
                            // context.read<ProductDetails>().getProductDetails(e);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentMethod(
                                      addressId: address,
                                      cartOrder: true,
                                    )));
                          },
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                              color: hasAddress ? Colors.black : Colors.white,
                              fontSize: width * 0.038,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(height: 1, width: 1);
          }),
    );
  }

  Widget amountList(String text, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$text:'),
        Text(amount),
      ],
    );
  }
}
