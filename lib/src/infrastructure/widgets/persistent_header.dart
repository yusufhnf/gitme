import 'package:flutter/material.dart';
import 'package:gitme/src/infrastructure/theme/dimension.dart';
import 'package:gitme/src/infrastructure/theme/pallet.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final bool withElevation;

  PersistentHeader({required this.widget, this.withElevation = false});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: Dimension.height50,
      child: Card(
        margin: EdgeInsets.zero,
        color: Pallet.neutralWhite,
        elevation: withElevation ? 2.0 : 0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => Dimension.height50;

  @override
  double get minExtent => Dimension.height50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
