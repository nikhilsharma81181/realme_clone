import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  PageController _card = PageController();
  int page = 0;
  @override
  void initState() {
    autoCard();
    super.initState();
  }

  autoCard() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_card.page!.toInt() < 3) {
        setState(() {
          _card.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          page = _card.page!.toInt() + 1;
        });
      } else {
        setState(() {
          _card.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          page = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width * 0.67,
      child: Stack(
        children: [
          PageView(
            controller: _card,
            onPageChanged: (_) {
              page = _card.page!.toInt();
            },
            children: [
              carosuel('img1.jpeg'),
              carosuel('img3.jpeg'),
              carosuel('img4.jpeg'),
              carosuel('img5.jpeg'),
              carosuel('img6.jpeg'),
              carosuel('img7.jpeg'),
            ],
          ),
          Positioned(
              bottom: width * 0.05,
              right: width * 0.4,
              child: Container(
                width: width * 0.17,
                child: Row(children: _buildIndicator()),
              )),
        ],
      ),
    );
  }

  Widget carosuel(String url) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/$url'), fit: BoxFit.cover),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 8,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.white),
            color: isActive ? Colors.white : Colors.white.withOpacity(0.1)),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 6; i++) {
      if (page == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}

class CarouselNew extends StatefulWidget {
  const CarouselNew({Key? key}) : super(key: key);

  @override
  _CarouselNewState createState() => _CarouselNewState();
}

class _CarouselNewState extends State<CarouselNew> {
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  PageController _card = PageController();
  int page = 0;
  List image = [];
  @override
  void initState() {
    autoCard();
    getData();
    super.initState();
  }

  getData() {
    FirebaseFirestore.instance
        .collection('extras')
        .doc('wWGuanuZxiyedhYBOvii')
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        image = doc['health'];
      });
    });
  }

  autoCard() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_card.page!.toInt() < (image.length - 1)) {
        setState(() {
          _card.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          page = _card.page!.toInt() + 1;
        });
      } else {
        setState(() {
          _card.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          page = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width * 0.5,
      child: Stack(
        children: [
          PageView(
            controller: _card,
            onPageChanged: (_) {
              page = _card.page!.toInt();
            },
            children: [
              for (int i = 0; i < image.length; i++) buildContainer(image[i]),
            ],
          ),
          Positioned(
              bottom: width * 0.05,
              right: width * 0.44,
              child: Container(
                width: width * 0.12,
                child: Row(children: _buildIndicator()),
              )),
        ],
      ),
    );
  }

  Widget buildContainer(String image) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 8,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.white),
            color: isActive ? Colors.white : Colors.white.withOpacity(0.1)),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < image.length; i++) {
      if (page == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
