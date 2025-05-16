import 'package:flutter/cupertino.dart';

import '../../../../config/themes/colors.dart';
import '../../domain/entities/menu_category.dart';

class TabBarSection extends StatelessWidget {
  final List<MenuCategory> categories;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarSection({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  category.buttonImageUrl,
                  height: 30,
                  fit: BoxFit.contain,
                  /*color: isSelected ? AppColors.primary : AppColors.textMuted,*/
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/set.png',
                      height: 30,
                      fit: BoxFit.contain,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  category.name.isNotEmpty ? category.name : 'Без названия',
                  style: TextStyle(
                    color: isSelected ? AppColors.primary : AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}