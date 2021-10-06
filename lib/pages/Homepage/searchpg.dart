import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/pages/catogries/detail.dart';

CollectionReference productRef =
    FirebaseFirestore.instance.collection('products');
TextEditingController search = TextEditingController();

class SearchPg extends StatefulWidget {
  const SearchPg({Key? key}) : super(key: key);

  @override
  _SearchPgState createState() => _SearchPgState();
}

class _SearchPgState extends State<SearchPg> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: width * 0.01),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Container(
                      width: width * 0.7,
                      height: width * 0.11,
                      child: TextFormField(
                        cursorColor: Colors.yellow.shade800,
                        controller: search,
                        onChanged: (_) {
                          setState(() {});
                        },
                        style: TextStyle(fontSize: width * 0.04),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: width * 0.01,
                                horizontal: width * 0.05),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.yellow.shade800),
                            )),
                      ),
                    ),
                    SizedBox(width: width * 0.007),
                    Text(
                      'Search',
                      style: TextStyle(
                          fontSize: width * 0.042, color: Colors.grey.shade700),
                    ),
                    SizedBox(width: width * 0.01),
                  ],
                ),
              ],
            ),
            Container(
              width: width,
              height: height * 0.885,
              padding: EdgeInsets.only(
                  right: width * 0.01,
                  left: width * 0.01,
                  top: width * 0.01,
                  bottom: width * 0.01),
              color: Colors.grey.shade300.withOpacity(0.8),
              child: StreamBuilder(
                stream: productRef
                    .where('name', isEqualTo: search.text)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('something went wrong'),
                    );
                  }
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Wrap(
                          children: snapshot.data!.docs
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Detail(productId: e.id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: width * 0.469,
                                      height: width * 0.65,
                                      margin: EdgeInsets.only(
                                          left: width * 0.01,
                                          right: width * 0.01,
                                          top: width * 0.01,
                                          bottom: width * 0.01),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.38,
                                            height: width * 0.38,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        e['icon']))),
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
                                  ))
                              .toList()),
                    );
                  } else
                    return Container(
                      width: width,
                      height: height * 0.885,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Colors.yellow.shade700,
                      ),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
