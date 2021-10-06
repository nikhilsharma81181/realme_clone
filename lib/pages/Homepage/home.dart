import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/pages/Homepage/carosuel.dart';
import 'package:realme_clone/pages/Homepage/productlist.dart';
import 'package:realme_clone/pages/Tabs/Tabs.dart';
import 'package:realme_clone/pages/catogries/detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 8, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    // getData();
    super.initState();
  }

  // getData() {
  //   FirebaseFirestore.instance
  //       .collection('categories-icon')
  //       .doc('SaSR6ndJLcMfkaGKg27N')
  //       .get()
  //       .then((DocumentSnapshot doc) {
  //     setState(() {
  //       image = DecorationImage(image: NetworkImage(doc['icon']));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverPersistentHeader(
                  delegate: MyDelegate2(width * 0.67, width * 0.15),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: width * 0.04, horizontal: width * 0.08),
                        height: width * 0.12,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Free Shipping',
                              style: TextStyle(
                                  fontSize: width * 0.029,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700),
                            ),
                            Container(
                              height: height,
                              width: 1,
                              color: Colors.grey.shade700,
                            ),
                            Text(
                              'Secure Payment',
                              style: TextStyle(
                                  fontSize: width * 0.029,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700),
                            ),
                            Container(
                              height: height,
                              width: 1,
                              color: Colors.grey.shade700,
                            ),
                            Text(
                              'Cash On Delivery',
                              style: TextStyle(
                                  fontSize: width * 0.029,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        child: Wrap(
                          children: [
                            buildRow(
                                'Phone',
                                'phone.png',
                                Colors.deepPurple.shade600,
                                'realme Smartphones'),
                            buildRow('Audio', 'buds.png', Colors.blue, 'Audio'),
                            buildRow('Accessories', 'powerbank.png',
                                Colors.yellow, 'Accessories'),
                            buildRow('Smart TV', 'smartTV.png', Colors.blue,
                                'realme TV'),
                            buildRow('Smart Watch', 'watch.png', Colors.grey,
                                'Smart Watch'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(width * 0.022),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                productId:
                                                    '8YhttAhEepWHWf5nrErL')));
                                  },
                                  child: Container(
                                    height: width * 0.67,
                                    width: width * 0.47,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/imgg6.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    highLight('imgg2', '6h9Z6nXKWaDFZ1vvEMwp'),
                                    SizedBox(height: width * 0.02),
                                    highLight('imgg3', 'oEuDGLhzrDGJSCB5SIxF'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.007),
                            Wrap(
                              children: [
                                trendingPhone('imgg5', '8YhttAhEepWHWf5nrErL'),
                                SizedBox(width: width * 0.015),
                                trendingPhone('imgg4', 'nLUwYNCI73JrmjjUP8WT'),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              '  Health & Fitness',
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: height * 0.012),
                            CarouselNew(),
                            SizedBox(height: height * 0.02),
                            Text(
                              '  Personal Care',
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: height * 0.012),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                            productId:
                                                'wfFOvTTzBkeQtsc4VGnQ')));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: width * 0.65,
                                  left: width * 0.032,
                                  top: width * 0.365,
                                  bottom: width * 0.07,
                                ),
                                width: width,
                                height: width * 0.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/dryer.jpg'),
                                    ),
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.amber.shade700.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'On Sale Now',
                                    style: TextStyle(
                                        fontSize: width * 0.026,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              '  Most Popular',
                              style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: height * 0.012),
                            Container(
                              width: width,
                              height: width * 0.5,
                              child: mostPopular(),
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(
                    TabBar(
                      controller: _controller,
                      isScrollable: true,
                      labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.only(bottom: width * 0.03),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.black, width: 2.5),
                      ),
                      tabs: [
                        buildTab('All'),
                        buildTab('Phones'),
                        buildTab('Audio'),
                        buildTab('Smart Home'),
                        buildTab('Smart Watch'),
                        buildTab('Accessories'),
                        buildTab('Charger/Cable'),
                        buildTab('Lifestyle'),
                      ],
                    ),
                    width,
                  ),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              controller: _controller,
              children: [
                AllTab(
                  all: [
                    'realme Smartphones',
                    'Audio',
                    'Smart Home',
                    'Smart Watch',
                    'realme TV',
                    'Power Banks',
                    'Accessories',
                  ],
                ),
                Tabs(categories: 'realme Smartphones'),
                Tabs(categories: 'Audio'),
                Tabs(categories: 'Smart Home'),
                Tabs(categories: 'Smart Watch'),
                Tabs(categories: 'realme TV'),
                Tabs(categories: 'Power Banks'),
                Tabs(categories: 'Accessories'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab(String text) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Tab(
        child: Container(
          height: width * 0.1,
          padding: EdgeInsets.all(width * 0.002),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: width * 0.037, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget highLight(String image, productID) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.read<MyProduct>().updateAll();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Detail(productId: productID)));
      },
      child: Container(
        height: width * 0.32,
        width: width * 0.47,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$image.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget mostPopular() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: productRef.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            width: 10,
            height: 10,
          );
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: snapshot.data!.docs
                  .map((e) => GestureDetector(
                        onTap: () {
                          context.read<MyProduct>().updateAll();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(productId: e.id)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: width * 0.02),
                          width: width * 0.38,
                          height: width * 0.44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.25,
                                height: width * 0.25,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(e['icon']))),
                              ),
                              SizedBox(height: height * 0.012),
                              Text(
                                e['name'],
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: height * 0.007),
                              // Text(
                              //   e['storage'][1],
                              //   style: TextStyle(
                              //       fontSize: width * 0.028,
                              //       fontWeight: FontWeight.w400),
                              // ),
                              SizedBox(height: height * 0.012),
                              Text(
                                '₹${e['price'][0]}',
                                style: TextStyle(
                                    fontSize: width * 0.035,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        } else
          return Container(
            width: 10,
            height: 10,
          );
      },
    );
  }

  Widget trendingPhone(String img, productID) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.read<MyProduct>().updateAll();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Detail(productId: productID)));
      },
      child: Container(
        height: width * 0.32,
        width: width * 0.47,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$img.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildRow(String text, String image, Color color, String catogrie) {
    TextStyle style = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.035,
        color: Colors.black);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.read<MyProduct>().updateAll();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainCatogries(
              catogries: catogrie,
            ),
          ),
        );
      },
      child: Container(
        width: width * 0.197,
        height: width * 0.23,
        child: Column(
          children: [
            Container(
              width: width * 0.13,
              height: width * 0.13,
              decoration: BoxDecoration(
                color: color,
                image: DecorationImage(
                    image: AssetImage('assets/$image'), fit: BoxFit.scaleDown),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
            Text(
              text,
              style: style,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final double width;
  MyDelegate(this.tabBar, this.width);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: width * 0.14),
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + width * 0.15;

  @override
  double get minExtent => tabBar.preferredSize.height + width * 0.15;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MyDelegate2 extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  MyDelegate2(this.maxHeight, this.minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        buildAppBar(shrinkOffset, width * 0.01),
        buildBackground(shrinkOffset),
        Positioned(
          top: height * 0.005,
          child: Container(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.01,
                ),
                Container(
                  width: width * 0.82,
                  padding: EdgeInsets.symmetric(vertical: width * 0.02),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: width * 0.095,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: width * 0.022),
                      decoration: BoxDecoration(
                        color: shrinkOffset == 0
                            ? Colors.white.withOpacity(0.5)
                            : shrinkOffset <= 100
                                ? Colors.grey.withOpacity(0.35)
                                : Colors.grey.withOpacity(0.28),

                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.01),
                          Icon(
                            Icons.search,
                            size: width * 0.05,
                            color: Colors.grey[800],
                          ),
                          Text(
                            'search',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: width * 0.037),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(shrinkOffset);
                  },
                  child: Icon(
                    Icons.message_outlined,
                    color: shrinkOffset == 0
                        ? Colors.white.withOpacity(0.5)
                        : shrinkOffset <= 100
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black87.withOpacity(0.6),
                    size: width * 0.07,
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildBackground(double shrinkOffset) => Opacity(
      opacity: dissapear(shrinkOffset),
      child: SingleChildScrollView(
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [Carousel()],
          )));
  double dissapear(double shrinkOffset) => 1 - shrinkOffset / maxHeight;

  double appear(double shrinkOffset) => shrinkOffset / maxHeight;

  Widget buildAppBar(double shrinkOffset, double width) => Opacity(
        opacity: appear(shrinkOffset),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.grey.shade300.withOpacity(0.7),
                width: 1,
              ),
            ),
          ),
          height: width,
          width: double.infinity,
        ),
      );

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
