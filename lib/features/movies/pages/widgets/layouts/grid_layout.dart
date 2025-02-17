import 'package:flutter/material.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent = 250,
      this.controller,
      required this.itemBuilder});

  final int itemCount;
  final double? mainAxisExtent;
  final ScrollController? controller;
  final Widget? Function(BuildContext context, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}

class TSizes {
  //Pdding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  //Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  //Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  // Button sizes
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

  //AppBar sizes
  static const double appBarHeight = 56.0;

  // Image sizes
  static const double imageThumbSize = 56.0;

  // Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  //Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiuslg = 12.0;

  //Divider height
  static const double dividerHeight = 1.0;

  // Product item dimensions
  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;
  static const double productItemHeight = 160.0;

  //Input field
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // Card sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 16.0;
  static const double cardRadiusSm = 16.0;
  static const double cardRadiusXs = 16.0;
  static const double cardElevationXs = 2.0;

  //Image carousel height
  static const double imageCarouseHeight = 200.0;

  // Loading indicator size
  static const double loadingIndicatorSize = 36.0;

  //Grid view spacing
  static const double gridViewSpacing = 16.0;

  
}
