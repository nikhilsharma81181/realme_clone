import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/pages/catogries/detail.dart';

CollectionReference productRef =
    FirebaseFirestore.instance.collection('products');

class AllTab extends StatefulWidget {
  final List all;
  const AllTab({Key? key, required this.all}) : super(key: key);

  @override
  _AllTabState createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: width * 0.032),
      child: StreamBuilder(
        stream: productRef.where('categories', whereIn: widget.all).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Wrap(
                children: snapshot.data!.docs
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(productId: e.id)));
                        },
                        child: Container(
                          width: width * 0.458,
                          height: width * 0.65,
                          margin: EdgeInsets.all(width * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                              SizedBox(height: height * 0.02),
                              Text(
                                e['name'],
                                style: TextStyle(
                                    fontSize: width * 0.036,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: height * 0.01),
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
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  Widget builtContainer(Color colors) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      height: width * 0.67,
      width: width * 0.45,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final String categories;
  const Tabs({Key? key, required this.categories}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: width * 0.032),
      child: StreamBuilder(
        stream: productRef
            .where('categories', isEqualTo: widget.categories)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Wrap(
                children: snapshot.data!.docs
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(productId: e.id)));
                        },
                        child: Container(
                          width: width * 0.458,
                          height: width * 0.65,
                          margin: EdgeInsets.all(width * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                              SizedBox(height: height * 0.02),
                              Text(
                                e['name'],
                                style: TextStyle(
                                    fontSize: width * 0.036,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: height * 0.01),
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
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  Widget builtContainer(Color colors) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      height: width * 0.67,
      width: width * 0.45,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
