import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/services/database.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 7, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            width: width,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  controller: _controller,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.black, width: 2.5),
                  ),
                  tabs: [
                    buildTab('Newly Launched'),
                    buildTab('realme Smartphones'),
                    buildTab('Audio'),
                    buildTab('Smart Life'),
                    buildTab('realme TV'),
                    buildTab('Power Banks'),
                    buildTab('Accessories'),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(width * 0.026),
                  width: width,
                  height: height * 0.89,
                  child: DefaultTabController(
                    length: 7,
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        banner(),
                        // AllTab(),
                        // AllTab(),
                        // AllTab(),
                        // AllTab(),
                        // AllTab(),
                        // AllTab(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget banner() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            height: width * 0.4,
            color: Colors.grey[400],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Text(
                  'Newly Launched',
                  style: TextStyle(fontSize: width * 0.038),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddProduct()));
                    },
                    icon: Icon(Icons.add))
              ],
            ),
          ),
          Wrap(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: width * 0.2,
                      width: width * 0.2,
                      color: Colors.grey,
                    ),
                    Text('name'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildTab(String text) {
    double width = MediaQuery.of(context).size.width;
    return Tab(
      child: Container(
        padding: EdgeInsets.all(width * 0.002),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: width * 0.037, color: Colors.black),
        ),
      ),
    );
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  late File file;
  var photoUrl = '';
  UploadTask? task;
  bool isAvailable = false;

  CollectionReference ref = FirebaseFirestore.instance.collection('products');

  Future post() async {
    try {
      DocumentReference _docRef = await ref.add({
        'name': name.text.trim(),
        'price': price.text.trim(),
        'categories': 'realme Smartphones',
        'icon': photoUrl,
        'productId': '',
      });

      await ref.doc(_docRef.id).update({
        'productId': _docRef.id,
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                post();
                Navigator.of(context).pop();
              });
            },
            child: Text(
              'Post',
              style: TextStyle(
                  fontSize: width * 0.042, fontWeight: FontWeight.w500),
            ),
          )
        ],
        backgroundColor: Colors.white60,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.5,
              width: width,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: width * 0.6,
                          width: width,
                          child: PageView(
                            children: [
                              Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.add, size: width * 0.1),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.add, size: width * 0.1),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.add, size: width * 0.1),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.add, size: width * 0.1),
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                child: Icon(Icons.add, size: width * 0.1),
                              ),
                            ],
                          ),
                        ),
                        // Positioned(child: Container())
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    width: width,
                    height: height * 0.18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.4,
                              height: width * 0.13,
                              child: TextFormField(
                                controller: price,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(width * 0.022),
                                  hintText: 'Price',
                                  prefix: Text('₹'),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {});
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.image);
                                    if (result == null) return;
                                    final path = result.files.single.path!;
                                    setState(() {
                                      file = File(path);
                                      isAvailable = true;
                                    });
                                    uploadFile();
                                  },
                                  child: isAvailable
                                      ? Container(
                                          width: width * 0.14,
                                          height: width * 0.14,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(file))),
                                        )
                                      : Container(
                                          width: width * 0.14,
                                          height: width * 0.14,
                                          color: Colors.grey.shade300,
                                          child: Icon(Icons.add),
                                        ),
                                ),
                                Text('Add Icon')
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: width * 0.6,
                          height: width * 0.13,
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(width * 0.022),
                              hintText: 'Enter name',
                              prefix: Text('₹'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadFile() async {
    final fileName = name.text.trim();
    final destination = 'videos/$fileName.mp4';

    task = FirebaseApiUpload.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download-Link: $urlDownload');
    setState(() {
      photoUrl = urlDownload;
    });
  }
}
