import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realme_clone/pages/Homepage/homepage.dart';

class StartPg extends StatefulWidget {
  const StartPg({Key? key}) : super(key: key);

  @override
  _StartPgState createState() => _StartPgState();
}

class _StartPgState extends State<StartPg> {
  PageController _controller = PageController();
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  int page = 0;
  bool reverse = false;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        page = _controller.page!.toInt();
      });
      print(page);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail,
                      size: width * 0.4,
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                          fontSize: width * 0.055, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: width * 0.4,
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                          fontSize: width * 0.055, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.archive,
                      size: width * 0.4,
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                          fontSize: width * 0.055, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            page != 2
                ? Positioned(
                    right: width * 0.05,
                    top: height * 0.02,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Homepage()));
                        setState(() {
                          timer.cancel();
                        });
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: width * 0.041,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Container(),
            page == 2
                ? Positioned(
                    bottom: width * 0.25,
                    right: width * 0.18,
                    child: Container(
                      width: width * 0.65,
                      height: width * 0.125,
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent[700],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                          setState(() {
                            timer.cancel();
                          });
                        },
                        child: Text(
                          'Get started',
                          style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
                : Container(),
            Positioned(
              bottom: 50,
              left: width * 0.45,
              child: SizedBox(
                child: Container(
                  width: width * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: page == 0 ? 10 : 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: page == 0 ? Colors.yellow[900] : Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: page == 1 ? 10 : 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: page == 1 ? Colors.yellow[900] : Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        width: page == 2 ? 10 : 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: page == 2 ? Colors.yellow[900] : Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
