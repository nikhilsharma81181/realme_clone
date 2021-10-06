import 'package:flutter/material.dart';
import 'package:realme_clone/pages/catogries/products.dart';

class Catogries extends StatefulWidget {
  const Catogries({Key? key}) : super(key: key);

  @override
  _CatogriesState createState() => _CatogriesState();
}

class _CatogriesState extends State<Catogries>
    with SingleTickerProviderStateMixin {
  PageController _card = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.grey.shade300.withOpacity(0.7),
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.04,
              ),
              width: width,
              height: width * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search),
                  SizedBox(width: width * 0.01),
                  Text('Search'),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: height * 0.032),
                  buildMenu('Newly Launched', 0),
                  buildMenu('realme Smartphones', 1),
                  buildMenu('Audio', 2), 
                  buildMenu('Smart Home', 3),
                  buildMenu('Smart Watch', 4),
                  buildMenu('realme TV', 5),
                  buildMenu('Power Banks', 6),
                  buildMenu('Accessories', 7),
                ],
              ),
              Expanded(
                child: Container(
                  height: height * 0.76,
                  width: width * 0.6,
                  child: PageView(
                    // onPageChanged: (_) {},
                    scrollDirection: Axis.vertical,
                    controller: _card,
                    physics: ClampingScrollPhysics(),
                    children: [
                      pages('Newly Launched'),
                      pages('realme Smartphones'),
                      pages('Audio'),
                      pages('Smart Home'),
                      pages('Smart Watch'),
                      pages('realme TV'),
                      pages('Power Banks'),
                      pages('Accessories'),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildMenu(String text, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle style = TextStyle(
        fontSize: width * 0.033,
        fontWeight: index != selectedIndex ? FontWeight.w400 : FontWeight.w600);

    return GestureDetector(
      onTap: () {
        setState(() {
          _card.animateToPage(index,
              duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
          selectedIndex = index;
        });
      },
      child: Container(
        width: width * 0.24,
        height: height * 0.079,
        alignment: Alignment.center,
        child: SizedBox(
          height: width * 0.15,
          width: width * 0.25,
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget pages(String header) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(width * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: width * 0.25,
            width: width * 0.67,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[200],
            ),
          ),
          SizedBox(height: height / 92),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: 32,
                color: Colors.grey.shade300,
              ),
              SizedBox(width: width * 0.02),
              Text(
                header,
                style: TextStyle(
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: width * 0.02),
              Container(
                height: 2,
                width: 32,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          SizedBox(height: height * 0.025),
          Products(categories: header)
        ],
      ),
    );
  }
}
