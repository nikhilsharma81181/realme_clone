import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realme_clone/models/user-address-model.dart';
import 'package:realme_clone/pages/catogries/buy&cart/address.dart';
import 'package:realme_clone/pages/login/auth.dart';
import 'package:realme_clone/pages/profile/data.dart';
import 'package:provider/provider.dart';

import 'all-orders.dart';

final user = FirebaseAuth.instance.currentUser;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: Colors.yellow.shade800,
              height: height * 0.29,
              child: Column(
                children: [
                  Container(
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.settings_outlined,
                              size: width * 0.072, color: Colors.white),
                          SizedBox(width: width * 0.045),
                          Icon(Icons.message_outlined,
                              size: width * 0.072, color: Colors.white),
                          SizedBox(width: width * 0.045),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: width * 0.07),
                      CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0.14),
                        radius: width * 0.092,
                        child: Icon(
                          Icons.person,
                          size: width * 0.12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: width * 0.045),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user != null ? user!.displayName.toString() : '',
                            style: TextStyle(
                              fontSize: width * 0.043,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'ID - 98349123',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.03,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.638,
              color: Colors.grey.shade300.withOpacity(0.6),
            )
          ],
        ),
        Positioned(
          top: height * 0.25,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: width * 0.0125),
                padding: EdgeInsets.symmetric(vertical: width * 0.05),
                width: width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: mainbuttons(
                  'Unpaid',
                  'Shipping',
                  'To Review',
                  'All Orders',
                  Icons.account_balance_wallet,
                  Icons.class_,
                  Icons.forum,
                  Icons.receipt_long,
                  () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Data()));
                  },
                  () {},
                  () {},
                  () {
                    FirebaseAuth.instance.currentUser == null
                        ? signInWithGoogle(context, AllOrders())
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllOrders()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: width * 0.0125),
                padding: EdgeInsets.all(width * 0.025),
                width: width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desdfhdiufhiuufiudhfodihffhsdbfndsufhsdhfdsfhdsfhdsufhdsfidsfjsdhanfjksdnfjksadfnajsdfnsadfauifhdsiufhdsiufsdaiflifsidfhadsifhwaiufhdesaidhsfhsihsdsdjknfcsjakdnfsdkajn.',
                      style: TextStyle(fontSize: width * 0.034),
                    ),
                    SizedBox(height: height * 0.0032),
                    Text(
                      'Sgagseweqw',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height * 0.007),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: width * 0.0125),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: width * 0.045),
                width: width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Official Service',
                          style: TextStyle(
                            fontSize: width * 0.039,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: width * 0.035),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: width * 0.032,
                              color: Colors.grey.shade600,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: width * 0.032),
                    buttons(
                      'Online Service',
                      'Service Centers',
                      'Software Update',
                      'Bulk Order',
                      Icons.chat,
                      Icons.storefront,
                      Icons.cloud_download,
                      Icons.shopping_bag,
                      () {},
                      () {},
                      () {},
                      () {},
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: width * 0.0125),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: width * 0.045),
                width: width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Tools',
                          style: TextStyle(
                            fontSize: width * 0.039,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.027),
                    buttons(
                      'Coupons',
                      'R-Pass',
                      'Addresses',
                      'Account',
                      Icons.card_giftcard,
                      Icons.payment,
                      Icons.pin_drop,
                      Icons.account_circle,
                      () {},
                      () {
                        // auth.signOut();
                        FirebaseAuth.instance.signOut();
                      },
                      () {
                        context.read<UserAddress>().addressAvailable();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Address(
                                  buying: false,
                                )));
                      },
                      () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget mainbuttons(
    String text1,
    text2,
    text3,
    text4,
    IconData icon1,
    icon2,
    icon3,
    icon4,
    Function() fn1,
    Function() fn2,
    Function() fn3,
    Function() fn4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        mainLabel(text1, icon1, fn1),
        mainLabel(text2, icon2, fn2),
        mainLabel(text3, icon3, fn3),
        mainLabel(text4, icon4, fn4),
      ],
    );
  }

  Widget buttons(
    String text1,
    text2,
    text3,
    text4,
    IconData icon1,
    icon2,
    icon3,
    icon4,
    Function() fn1,
    Function() fn2,
    Function() fn3,
    Function() fn4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buttonLabel(text1, icon1, fn1),
        buttonLabel(text2, icon2, fn2),
        buttonLabel(text3, icon3, fn3),
        buttonLabel(text4, icon4, fn4),
      ],
    );
  }

  Widget mainLabel(String text, IconData icon, Function() fn) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: fn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: width * 0.1,
            color: Colors.yellow.shade900,
          ),
          SizedBox(height: width * 0.01),
          Container(
            width: width * 0.2,
            height: width * 0.04,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: width * 0.034),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonLabel(
    String text,
    IconData icon,
    Function() fn,
  ) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: fn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: width * 0.085,
            color: Colors.yellow.shade900,
          ),
          SizedBox(height: width * 0.01),
          Container(
            width: width * 0.2,
            height: width * 0.07,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: width * 0.032),
            ),
          ),
        ],
      ),
    );
  }
}
