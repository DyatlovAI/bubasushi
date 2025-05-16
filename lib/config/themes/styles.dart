import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const header1 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static const body1 = TextStyle(
      fontSize: 12, color: AppColors.textSecondary);

  static const caption = TextStyle(
      fontSize: 14, color: AppColors.textMuted);

  static const price2 = TextStyle(
      fontSize: 16, color: AppColors.textMuted);

  static const price = TextStyle(
      fontSize: 16, color: AppColors.textPrimary);
}
