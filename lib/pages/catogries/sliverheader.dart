import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:realme_clone/models/change-model.dart';

import 'detail.dart';

class MyDetailDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final double width;
  MyDetailDelegate(this.tabBar, this.width);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: width * 0.2),
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + width * 0.25;

  @override
  double get minExtent => tabBar.preferredSize.height + width * 0.25;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MyDetailDelegate2 extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Map<String, dynamic> e;
  MyDetailDelegate2(this.maxHeight, this.minHeight, this.e);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        buildAppBar(shrinkOffset, width * 0.01, width),
        buildBackground(shrinkOffset, height, width, e),
        Positioned(
          top: height * 0.007,
          child: SafeArea(
            child: Container(
              height: width * 0.1,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<MyProduct>().updateAll();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: width * 0.1,
                      height: width * 0.1,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.022),
                      padding: EdgeInsets.only(left: width * 0.02),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white12),
                      child: Icon(Icons.arrow_back_ios,
                          size: width * 0.06, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width * 0.1,
                      height: width * 0.1,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.022),
                      padding: EdgeInsets.only(right: width * 0.007),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white12,
                      ),
                      child: Icon(Icons.share,
                          size: width * 0.06, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBackground(
          double shrinkOffset, height, width, Map<String, dynamic> e) =>
      Opacity(
          opacity: dissapear(shrinkOffset),
          child: SingleChildScrollView(
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: height * 0.535,
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.031),
                        Expanded(child: ProductImageView(e: e)),
                        Container(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                ],
              )));
  double dissapear(double shrinkOffset) => 1 - shrinkOffset / maxHeight;

  double appear(double shrinkOffset) => shrinkOffset / maxHeight;

  Widget buildAppBar(double shrinkOffset, double height, width) => Opacity(
        opacity: appear(shrinkOffset),
        child: Container(
          padding:
              EdgeInsets.only(left: width * 0.125, top: width * 0.054),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.grey.shade300.withOpacity(0.7),
                width: 1,
              ),
            ),
          ),
          height: height,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Text('Details',
              style: TextStyle(
                  fontSize: width * 0.047, fontWeight: FontWeight.w500)),
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
