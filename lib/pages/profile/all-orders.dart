import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/Homepage/searchpg.dart';
import 'package:realme_clone/pages/catogries/detail.dart';
import 'package:realme_clone/pages/profile/all-order-detail.dart';

CollectionReference allProductRef =
    FirebaseFirestore.instance.collection('orders');

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: width * 0.5,
        leading: Row(
          children: [
            SizedBox(width: width * 0.032),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: width * 0.056),
            ),
            SizedBox(width: width * 0.015),
            Text(
              'My Orders',
              style: TextStyle(color: Colors.black, fontSize: width * 0.047),
            )
          ],
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildOrders(),
              SizedBox(height: height * 0.01),
              Text(
                '    Recommended',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height * 0.01),
              buildRecommendation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrders() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: StreamBuilder(
        stream:
            allProductRef.where('useruid', isEqualTo: user!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.data!.docs.isEmpty) {
            return Text('You have\'t ordered yet');
          }
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AllOrderDetail(docId: e.id)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: width * 0.032,
                            right: width * 0.02,
                            left: width * 0.02,
                          ),
                          padding: EdgeInsets.all(width * 0.032),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.32,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${e['time'].toDate().day},${e['time'].toDate().month},${e['time'].toDate().year}  ${e['time'].toDate().hour}:${e['time'].toDate().minute}:${e['time'].toDate().second}',
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                  Text(
                                    e['current-state'],
                                    style: TextStyle(
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.037),
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
                                            e['Product Name'],
                                            style: TextStyle(
                                                fontSize: width * 0.038,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Text(
                                            e['Product Color'],
                                            style: TextStyle(
                                                fontSize: width * 0.033,
                                                color: Colors.grey.shade700),
                                          ),
                                          SizedBox(height: height * 0.002),
                                          Text(
                                            e['Product Storage'],
                                            style: TextStyle(
                                                fontSize: width * 0.033,
                                                color: Colors.grey.shade700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹${e['Product Price']}',
                                      ),
                                      Text(
                                        'x ${e['quantity']}',
                                        style: TextStyle(
                                          fontSize: width * 0.0322,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: height * 0.015),
                              Divider(
                                  color: Colors.grey.shade200, thickness: 1),
                              SizedBox(height: height * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity:',
                                      style: TextStyle(
                                          color: Colors.grey.shade700)),
                                  Text(e['quantity'].toString(),
                                      style: TextStyle(
                                          color: Colors.grey.shade700)),
                                ],
                              ),
                              SizedBox(height: height * 0.007),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total:',
                                      style: TextStyle(color: Colors.black87)),
                                  Text('₹${e['Product Price']}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: width * 0.038,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          } else
            return CircularProgressIndicator(
              color: Colors.yellow.shade800,
            );
        },
      ),
    );
  }

  Widget buildRecommendation() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(width * 0.02),
      child: FutureBuilder(
        future: productRef.orderBy('created', descending: true).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Detail(productId: e.id,),
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
    );
  }
}
