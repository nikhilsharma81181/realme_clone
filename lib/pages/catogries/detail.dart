import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realme_clone/models/change-model.dart';
import 'package:realme_clone/pages/Homepage/searchpg.dart';
import 'package:realme_clone/pages/cart/cart.dart';
import 'package:realme_clone/pages/catogries/buy&cart/buynow.dart';
import 'package:realme_clone/pages/catogries/sliverheader.dart';

CollectionReference ref = FirebaseFirestore.instance.collection('products');

class Detail extends StatefulWidget {
  final String productId;
  const Detail({Key? key, required this.productId}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  int more = 0;
  TextEditingController pincode = TextEditingController();
  int pinLength = 0;

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    ref
        .doc(widget.productId)
        .collection('offers')
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        more = snapshot.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int selectedStorage = context.watch<MyProduct>().selectedStorage;
    int selectedColors = context.watch<MyProduct>().selectedColors;
    int selectedPrice = context.watch<MyProduct>().selectedPrice;
    int quantity = context.watch<MyProduct>().quantity;
    return StreamBuilder<DocumentSnapshot>(
        stream: productRef.doc(widget.productId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.hasData) {
            Map<String, dynamic> e =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverPersistentHeader(
                        delegate:
                            MyDetailDelegate2(height * 0.535, width * 0.2, e),
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(width * 0.035),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '₹',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: width * 0.042,
                                              fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                              text: e['price'][selectedPrice]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: width * 0.07,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: width * 0.032),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              context: context,
                                              builder: (context) =>
                                                  buildBottomSheet(
                                                      e['price'], e['name']));
                                        },
                                        child: Icon(
                                          Icons.help_outline,
                                          size: width * 0.045,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    e['name'],
                                    style: TextStyle(
                                      fontSize: width * 0.042,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Container(
                                    height: width * 0.185,
                                    width: width,
                                    child: offers(2, 0.085, widget.productId),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          context: context,
                                          builder: (_) {
                                            return buildOffers();
                                          });
                                    },
                                    child: more > 2
                                        ? Text(
                                            '     + ${more - 2} More benifits',
                                            style: TextStyle(
                                                fontSize: width * 0.035,
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: width * 0.022,
                              color: Colors.grey.shade300.withOpacity(0.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // backgroundColor: Colors.white.withOpacity(0.5),
                                  context: context,
                                  builder: (buyNow) => BuyNowPopUp(
                                    productId: widget.productId,
                                    menu: true,
                                    cart: true,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(width * 0.035),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              e['colors'][selectedColors],
                                              style: TextStyle(
                                                  fontSize: width * 0.037),
                                            ),
                                            SizedBox(width: width * 0.035),
                                            Text(
                                              e['storage'][selectedStorage],
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                            SizedBox(width: width * 0.035),
                                            Text(
                                              'x $quantity',
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Choose',
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: width * 0.032,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.017),
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i < e['storage'].length;
                                            i++)
                                          Row(
                                            children: [
                                              SizedBox(width: width * 0.02),
                                              Container(
                                                height: width * 0.095,
                                                width: width * 0.095,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e['colors-img']
                                                                [i]))),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.0225),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Free shipping',
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: width * 0.014),
                                              width: 1,
                                              height: width * 0.03,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Secure payment',
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: width * 0.014),
                                              width: 1,
                                              height: width * 0.03,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'COD',
                                              style: TextStyle(
                                                  fontSize: width * 0.036),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: width * 0.032,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              height: width * 0.022,
                              color: Colors.grey.shade300.withOpacity(0.5),
                            ),
                            Container(
                              padding: EdgeInsets.all(width * 0.045),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.67,
                                    height: width * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade300)),
                                    child: TextFormField(
                                      controller: pincode,
                                      onChanged: (_) {
                                        setState(() {
                                          pinLength = pincode.text.length;
                                        });
                                      },
                                      cursorColor: Colors.yellow.shade600,
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: width * 0.02,
                                          horizontal: width * 0.05,
                                        ),
                                        counterText: '',
                                        hintText:
                                            'Enter pincode for delivery details',
                                        hintStyle: TextStyle(
                                            fontSize: width * 0.035,
                                            color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: width * 0.1,
                                    width: width * 0.225,
                                    decoration: pincode.text.length < 6
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey.shade300)
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.yellow.shade700
                                                .withOpacity(0.85)),
                                    child: RawMaterialButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Check ',
                                        style: TextStyle(
                                          fontSize: width * 0.036,
                                          color: pincode.text.length < 6
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: width * 0.022,
                              color: Colors.grey.shade300.withOpacity(0.5),
                            ),
                            Container(
                              padding: EdgeInsets.all(width * 0.045),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: TextStyle(fontSize: width * 0.035),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    children: [
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                            fontSize: width * 0.092,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: width * 0.07),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  size: width * 0.044,
                                                  color:
                                                      Colors.yellow.shade800),
                                              Icon(Icons.star,
                                                  size: width * 0.044,
                                                  color:
                                                      Colors.yellow.shade800),
                                              Icon(Icons.star,
                                                  size: width * 0.044,
                                                  color:
                                                      Colors.yellow.shade800),
                                              Icon(Icons.star,
                                                  size: width * 0.044,
                                                  color:
                                                      Colors.yellow.shade800),
                                              Icon(Icons.star_half,
                                                  size: width * 0.044,
                                                  color:
                                                      Colors.yellow.shade800),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.005),
                                          RichText(
                                            text: TextSpan(
                                              text: ' Average rating based on ',
                                              style: TextStyle(
                                                  fontSize: width * 0.028,
                                                  color: Colors.grey.shade600),
                                              children: [
                                                TextSpan(
                                                  text: '1200',
                                                  style: TextStyle(
                                                    fontSize: width * 0.029,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(text: ' reviews'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.025),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        reviewCard(0.8),
                                        reviewCard(0.8),
                                        reviewCard(0.8),
                                        reviewCard(0.8),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.017),
                                  Container(
                                    width: width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('View all reviews'),
                                        Icon(Icons.arrow_forward_ios,
                                            size: width * 0.032)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: width * 0.022,
                              color: Colors.grey.shade300.withOpacity(0.5),
                            ),
                            Container(
                              padding: EdgeInsets.all(width * 0.045),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recommended',
                                    style: TextStyle(fontSize: width * 0.035),
                                  ),
                                  SizedBox(height: height * 0.017),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        recommeded(widget.productId),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: width * 0.022,
                              color: Colors.grey.shade300.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: MyDetailDelegate(
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            indicatorPadding: EdgeInsets.zero,
                            unselectedLabelColor: Colors.grey.shade500,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.035,
                            ),
                            unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.035),
                            labelColor: Colors.black,
                            labelPadding: EdgeInsets.zero,
                            tabs: [
                              Container(
                                width: width * 0.255,
                                height: width * 0.095,
                                alignment: Alignment.center,
                                child: Text('Overview'),
                              ),
                              Container(
                                width: width * 0.255,
                                height: width * 0.095,
                                alignment: Alignment.center,
                                child: Text('Specs'),
                              ),
                            ],
                          ),
                          width,
                        ),
                        floating: true,
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Image(image: AssetImage('assets/aa.png'));
                        },
                      ),
                      Container(
                        width: width,
                        height: height,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.support_agent),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cart(
                                        fromDetail: true,
                                      )));
                        },
                        child: Icon(Icons.shopping_cart_outlined),
                      ),
                      Row(
                        children: [
                          bottomAddcart(),
                          bottomBuyNow(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(color: Colors.yellow.shade800),
            ));
        });
  }

  Widget bottomAddcart() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.115,
      width: width * 0.34,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(0),
          ),
          color: Colors.grey.shade700),
      child: RawMaterialButton(
        splashColor: Colors.grey.shade700,
        focusColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(0),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              context: context,
              builder: (buyNow) => BuyNowPopUp(
                    productId: widget.productId,
                    menu: false,
                    cart: true,
                  ));

          // context.read<UserAddress>().addressAvailable();
        },
        child: Text(
          'Add to Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.039,
          ),
        ),
      ),
    );
  }

  Widget bottomBuyNow() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.115,
      width: width * 0.34,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(30),
          ),
          color: Colors.yellow.shade700),
      child: RawMaterialButton(
        splashColor: Colors.yellow.shade700,
        focusColor: Colors.yellow.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(30),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              context: context,
              builder: (buyNow) => BuyNowPopUp(
                    productId: widget.productId,
                    menu: false,
                    cart: false,
                  ));
        },
        child: Text(
          'Buy Now',
          style: TextStyle(
            color: Colors.black,
            fontSize: width * 0.039,
          ),
        ),
      ),
    );
  }

  Widget reviewCard(double num) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: width * 0.02),
      height: width * 0.5,
      width: width * num,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget recommeded(String productID) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<QuerySnapshot>(
      future: productRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            height: 10,
            width: 10,
          );
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: snapshot.data!.docs
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(productId: productID)));
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

  Widget buildOffers() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      height: MediaQuery.of(context).size.height * 0.82,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All benefits',
                style: TextStyle(
                  fontSize: width * 0.047,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.032),
          offers(100, 0.12, widget.productId),
        ],
      ),
    );
  }

  Widget offers(int limit, double height, String productId) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: ref.doc(productId).collection('offers').limit(limit).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No offer is available at the moment"),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return Column(
              children: snapshot.data!.docs.map((e) {
            return Container(
              width: width,
              height: width * height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer,
                          size: width * 0.04, color: Colors.red[600]),
                      SizedBox(width: width * 0.022),
                      Container(
                        width: width * 0.8,
                        child: RichText(
                            text: TextSpan(
                                text: '${e['title']}: ',
                                style: TextStyle(
                                    fontSize: width * 0.035,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                                children: [
                              TextSpan(
                                text: e['des'],
                                style: TextStyle(
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.w400),
                              )
                            ])),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: width * 0.032,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }).toList());
        } else
          return Container();
      },
    );
  }

  Widget buildBottomSheet(String sP, String name) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(width * 0.04),
      height: height * 0.832,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: width * 0.05,
                width: width * 0.12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: width * 0.05,
                  width: width * 0.05,
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
          Text(
            'Price Detail',
            style: TextStyle(
              fontSize: width * 0.038,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: height * 0.007),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Maximum Retail Price ',
                    style: TextStyle(
                      fontSize: width * 0.033,
                    ),
                  ),
                  Text(
                    '(Inclusive of all taxes)',
                    style: TextStyle(
                      fontSize: width * 0.028,
                    ),
                  ),
                ],
              ),
              Text(
                '₹27,999',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selling Price',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                '₹$sP',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.008),
          Text(
            'Manufacturer & Importer Info',
            style: TextStyle(
              fontSize: width * 0.038,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: height * 0.008),
          Row(
            children: [
              Text(
                'Product Name - ',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                (' (color,6GB+128GB)'),
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.005),
          Row(
            children: [
              Text(
                'Common Name - ',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                'Mobile Phone',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              Text(
                'Manufactured By - ',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                'Oppo Mobiles India Private Limited',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              Text(
                'Country Orign - ',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
              Text(
                'India',
                style: TextStyle(
                  fontSize: width * 0.033,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductImageView extends StatefulWidget {
  final Map<String, dynamic> e;
  const ProductImageView({Key? key, required this.e}) : super(key: key);

  @override
  _ProductImageViewState createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  PageController screenshot = PageController();
  int page = 1;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Map<String, dynamic> e = widget.e;
    int selectedColors = context.watch<MyProduct>().selectedColors;
    String selectedImage = widget.e['colors'][selectedColors];
    return Stack(
      children: [
        PageView(
          onPageChanged: (_) {
            if (screenshot.page!.toInt() + 1 == page) {
              setState(() {
                page = page + 1;
              });
            } else if (screenshot.page!.toInt() + 1 < page) {
              setState(() {
                page = page - 1;
              });
            }
          },
          controller: screenshot,
          children: [
            for (int i = 0; i < e[selectedImage].length; i++)
              Container(
                child: Image(
                  fit: BoxFit.scaleDown,
                  image: NetworkImage(
                    e[selectedImage][i],
                  ),
                ),
              ),
          ],
        ),
        Positioned(
          bottom: width * 0.032,
          right: width * 0.032,
          child: Container(
              width: width * 0.12,
              height: width * 0.06,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade600),
              child: Text(
                '${page.toString()}/${e[selectedImage].length}',
                style: TextStyle(color: Colors.white, fontSize: width * 0.034),
              )),
        ),
      ],
    );
  }
}
