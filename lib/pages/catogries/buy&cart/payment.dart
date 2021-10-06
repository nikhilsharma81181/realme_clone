import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realme_clone/models/cart-model.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/pages/Homepage/homepage.dart';

final user = FirebaseAuth.instance.currentUser;
CollectionReference addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('address');
CollectionReference cartRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('cart');
CollectionReference ref1 = FirebaseFirestore.instance.collection('orders');

class PaymentMethod extends StatefulWidget {
  final String addressId;
  final bool cartOrder;
  const PaymentMethod({
    Key? key,
    required this.addressId,
    required this.cartOrder,
  }) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String currentTime =
      '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
  String address = '';
  String phoneNo = '';
  String pinCode = '';
  String name = '';
  String city = '';
  String state = '';
  String email = '';
  String landmark = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    addressRef.doc(widget.addressId).get().then((DocumentSnapshot doc) {
      setState(() {
        address = doc['full-address'];
        phoneNo = doc['Mobile Number'];
        pinCode = doc['Pincode'];
        name = doc['Full Name'];
        city = doc['City'];
        state = doc['State'];
        email = doc['Email'];
        landmark = doc['Landmark'];
      });
    });
  }

  Future placeOrder(int quantity, String productName, productColor, storage,
      price, icon, int totalPrice) async {
    DocumentReference _docRef = await ref1.add({
      'useruid': user!.uid,
      'Full Name': name,
      'Mobile Number': phoneNo,
      'Pincode': pinCode,
      'City': city,
      'State': state,
      'full-address': address,
      'Email': email,
      'Landmark': landmark,
      'addressId': '',
      'Product Name': productName,
      'Product Color': productColor,
      'Product Storage': storage,
      'Product Price': price,
      'Total Price': totalPrice,
      'quantity': quantity,
      'time': DateTime.now(),
      'current-state': 'On the way',
      'icon': icon,
    });
    await ref1.doc(_docRef.id).update({
      'addressId': _docRef.id,
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
  }

  Future placeOrderCart() async {
    try {
      cartRef.get().then((QuerySnapshot snap) {
        snap.docs.forEach((DocumentSnapshot doc) async {
          DocumentReference _docRef = await ref1.add({
            'useruid': user!.uid,
            'Full Name': name,
            'Mobile Number': phoneNo,
            'Pincode': pinCode,
            'City': city,
            'State': state,
            'full-address': address,
            'Email': email,
            'Landmark': landmark,
            'addressId': '',
            'Product Name': doc['product name'],
            'Product Color': doc['color'],
            'Product Storage': doc['storage'],
            'Product Price': doc['price'],
            'Total Price': doc['price'] * doc['quantity'],
            'quantity': doc['quantity'],
            'time': DateTime.now(),
            'current-state': 'On the way',
            'icon': doc['icon'],
          });
          await ref1.doc(_docRef.id).update({
            'addressId': _docRef.id,
          });
          deleteCart();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Homepage()));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future deleteCart() async {
    try {
      cartRef.get().then((QuerySnapshot snap) {
        snap.docs.forEach((DocumentSnapshot doc) {
          cartRef.doc(doc.id).delete();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Payment Methods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount: ${context.watch<ProductDetails>().totalPrice}',
                    style: TextStyle(
                      fontSize: width * 0.037,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * 0.022),
                  buildDetails('Name', name),
                  SizedBox(height: height * 0.0125),
                  buildDetails('Address', address),
                  SizedBox(height: height * 0.0125),
                  buildDetails('Phone No', phoneNo),
                  SizedBox(height: height * 0.0125),
                  buildDetails('Postal Code', pinCode),
                  SizedBox(height: height * 0.0125),
                  productsDetail(),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.01,
              color: Colors.grey.shade300,
            ),
            Container(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your payment method',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400.withOpacity(0.5),
              thickness: 1.2,
              height: height * 0.004,
            ),
            SizedBox(height: height * 0.007),
            paymentMethod('Credit / Debit Card'),
            paymentMethod('Wallet'),
            paymentMethod('Net Banking'),
            paymentMethod('EMI'),
            paymentMethod('UPI'),
            paymentMethod('Cash On Delivery'),
          ],
        ),
      ),
    );
  }

  Widget productsDetail() {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: cartRef.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('error occured');
        }
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product List',
                style: TextStyle(
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widget.cartOrder
                  ? Wrap(
                      children: snapshot.data!.docs
                          .map((e) => Text(
                              '${e['product name']} ${e['color']} ${e['storage']},'))
                          .toList(),
                    )
                  : Text(
                      '${context.watch<ProductDetails>().productName} (${context.watch<ProductDetails>().color}, ${context.watch<ProductDetails>().storage})',
                      style: TextStyle(
                        fontSize: width * 0.037,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          );
        } else
          return Container();
      },
    );
  }

  Widget paymentMethod(String text) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int quantity = context.watch<MyProduct>().quantity;
    String productName = context.watch<ProductDetails>().productName;
    String color = context.watch<ProductDetails>().color;
    String storage = context.watch<ProductDetails>().storage;
    int totalPrice = context.watch<ProductDetails>().totalPrice;
    String icon = context.watch<ProductDetails>().icon;
    return GestureDetector(
      onTap: () {
        if (widget.cartOrder) {
          setState(() {
            placeOrderCart();
          });
        } else {
          setState(() {
            placeOrder(
              quantity,
              productName,
              color,
              storage,
              totalPrice.toString(),
              icon,
              totalPrice,
            );
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(height: height * 0.014),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: width * 0.04,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: height * 0.012),
            Divider(
              color: Colors.grey.shade400.withOpacity(0.5),
              thickness: 1.2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetails(String text, String text1) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: width * 0.037,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          text1,
          style: TextStyle(
            fontSize: width * 0.037,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildLine() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.025),
        child: Text(
          '|',
          style: TextStyle(color: Colors.grey.shade400),
        ));
  }
}
