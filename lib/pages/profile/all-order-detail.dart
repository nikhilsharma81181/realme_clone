import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference allProductRef =
    FirebaseFirestore.instance.collection('orders');

class AllOrderDetail extends StatefulWidget {
  final String docId;
  const AllOrderDetail({Key? key, required this.docId}) : super(key: key);

  @override
  _AllOrderDetailState createState() => _AllOrderDetailState();
}

class _AllOrderDetailState extends State<AllOrderDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,
                color: Colors.black, size: width * 0.056),
          ),
          title: Text(
            'Orders Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: width * 0.048,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot>(
                future: allProductRef.doc(widget.docId).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.hasData) {
                    Map<String, dynamic> e =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        buildFistMenu(e),
                        buildSecondMenu(e),
                        buildThreeMenu(e),
                      ],
                    );
                  } else
                    return CircularProgressIndicator(
                      color: Colors.yellow.shade800,
                    );
                }),
          ),
        ));
  }

  Widget buildFistMenu(Map<String, dynamic> e) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width * 0.032),
      padding: EdgeInsets.all(width * 0.035),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.47,
                alignment: Alignment.centerRight,
                child: Text(
                  'Order on: ${e['time'].toDate().day},${e['time'].toDate().month},${e['time'].toDate().year}  ${e['time'].toDate().hour}:${e['time'].toDate().minute}:${e['time'].toDate().second}',
                  style: TextStyle(color: Colors.grey.shade700),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.15,
                    height: width * 0.15,
                    child: Image(image: NetworkImage(e['icon'])),
                  ),
                  SizedBox(width: width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['Product Name'],
                        style: TextStyle(
                            fontSize: width * 0.038, color: Colors.black),
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
          SizedBox(height: height * 0.025),
        ],
      ),
    );
  }

  Widget buildSecondMenu(Map<String, dynamic> e) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width * 0.032),
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: width * 0.05,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Information',
            style: TextStyle(
              fontSize: width * 0.0385,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.025),
          Text(
            'Name:',
            style:
                TextStyle(fontSize: width * 0.035, color: Colors.grey.shade600),
          ),
          SizedBox(height: height * 0.01),
          Text(
            e['Full Name'],
            style: TextStyle(fontSize: width * 0.035, color: Colors.black87),
          ),
          SizedBox(height: height * 0.025),
          Text(
            'Phone:',
            style:
                TextStyle(fontSize: width * 0.035, color: Colors.grey.shade600),
          ),
          SizedBox(height: height * 0.01),
          Text(
            e['Mobile Number'],
            style: TextStyle(fontSize: width * 0.035, color: Colors.black87),
          ),
          SizedBox(height: height * 0.025),
          Text(
            'Address:',
            style:
                TextStyle(fontSize: width * 0.035, color: Colors.grey.shade600),
          ),
          SizedBox(height: height * 0.01),
          Text(
            e['full-address'],
            style: TextStyle(fontSize: width * 0.035, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget buildThreeMenu(Map<String, dynamic> e) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Container();
  }
}
