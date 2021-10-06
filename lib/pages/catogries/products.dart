import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/pages/catogries/detail.dart';
import 'package:provider/provider.dart';

CollectionReference ref = FirebaseFirestore.instance.collection('products');

class Products extends StatefulWidget {
  final String categories;
  const Products({Key? key, required this.categories}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool aa = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      child: StreamBuilder(
        stream: widget.categories == 'Newly Launched'
            ? ref
                .where('categories', whereIn: [
                  'realme Smartphones',
                  'Audio',
                  'Smart Home',
                  'Smart Watch',
                  'realme TV',
                  'Power Banks',
                  'Accessories'
                ])
                .limit(7)
                .snapshots()
            : ref.where('categories', isEqualTo: widget.categories).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (!snapshot.hasData) {
            return Container(
              height: width * 0.2,
              width: width * 0.2,
              child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Text("Empty");
          }

          if (snapshot.hasData && snapshot.data != null) {
            return Wrap(
                children: snapshot.data!.docs
                    .map((e) => GestureDetector(
                          onTap: () {
                            context.read<MyProduct>().updateAll();
                            context.read<MyProduct>().updateImage(e);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detail(productId: e.id)));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(width * 0.02),
                                  height: width * 0.17,
                                  width: width * 0.18,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(e['icon']))),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width * 0.23,
                                  child: Text(
                                    e['name'],
                                    style: TextStyle(fontSize: width * 0.03),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList());
          } else
            return Container(
              height: width * 0.85,
              width: width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ),
            );
        },
      ),
    );
  }
}
