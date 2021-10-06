import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/pages/Tabs/Tabs.dart';
import 'package:realme_clone/pages/catogries/detail.dart';

class MainCatogries extends StatefulWidget {
  final String catogries;
  const MainCatogries({Key? key, required this.catogries})
      : super(key: key);

  @override
  _MainCatogriesState createState() => _MainCatogriesState();
}

class _MainCatogriesState extends State<MainCatogries> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
          widget.catogries,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(width * 0.021),
        child: StreamBuilder(
          stream: productRef
              .where('categories', isEqualTo: widget.catogries)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                height: 10,
                width: 10,
              );
            }
            if (snapshot.hasData) {
              return Wrap(
                spacing: width * 0.02,
                children: snapshot.data!.docs
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Detail(productId: e.id),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: width * 0.01),
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
                width: width,
                height: height,
              );
          },
        ),
      ),
    );
  }
}
