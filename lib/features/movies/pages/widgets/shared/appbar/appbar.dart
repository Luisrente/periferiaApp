import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:periferiamovies/core/resources/styles.dart';
import 'package:periferiamovies/utils/device/device_utility.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
    {
    super.key, 
    this.title, 
    this.showBackArrow = true, 
    this.leadingIcon, 
    this.actions, 
    this.leadingOnPressed,
    this.leadingcolorIcon
    }
    );

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final Color? leadingcolorIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading:  false,
      leading: showBackArrow ? IconButton(onPressed: () {
        Navigator.of(context).pop();
      }, icon:  Icon(Iconsax.arrow_left_2 , color: Theme.of(context).extension<LzyctColors>()!.buttonText)) 
      : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon, color: leadingcolorIcon)) : null,
      title: Align(
        alignment: Alignment.center,
        child: title),
      actions: actions ??  [const SizedBox(width: 55,)] 
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarheight());
}