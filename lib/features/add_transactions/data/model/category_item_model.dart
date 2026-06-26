import 'package:flutter/material.dart';

class CategoryItemModel {
  final String svgName;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const CategoryItemModel({
    required this.svgName,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });
}
