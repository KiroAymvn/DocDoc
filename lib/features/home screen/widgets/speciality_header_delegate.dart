import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

class SpecialityHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SpecialityHeaderDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: shrinkOffset==0? 0:10,
        animationDuration: Duration(milliseconds: 500),
        shadowColor: Colors.black,
        animateColor: true,
        borderOnForeground: true,
        child: SizedBox.expand(child: child));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SpecialityHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
