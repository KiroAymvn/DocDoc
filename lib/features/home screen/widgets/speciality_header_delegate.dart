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
    // Because minHeight == maxHeight, shrinkOffset will always be 0.
    // We must use overlapsContent to know when the user scrolls under it.
    final bool isScrolled = overlapsContent || shrinkOffset > 0;

    return Material(
      elevation: isScrolled ? 6 : 0,
      animationDuration: const Duration(milliseconds: 1000),
      shadowColor: AppColors.kDarkText,
      color: AppColors.kBackGround,
      child: SizedBox.expand(child: child),
    );
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
