import 'package:flutter/material.dart';
import 'package:periferiamovies/utils/services/hive/main_box.dart';

class DataHelper {
  String? title;
  String? desc;
  String? iconPath;
  IconData? icon;
  String? url;
  String? type;
  int? id;
  bool isSelected;
  ActiveTheme activeTheme;

  DataHelper({
    this.title,
    this.desc,
    this.iconPath,
    this.icon,
    this.url,
    this.type,
    this.id,
    this.isSelected = false,
    this.activeTheme = ActiveTheme.light,
  });
}