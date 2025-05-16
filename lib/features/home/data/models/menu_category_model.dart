import '../../domain/entities/menu_category.dart';
import 'menu_item_model.dart';

class MenuCategoryModel extends MenuCategory {
  MenuCategoryModel({
    required String id,
    required String name,
    required String buttonImageUrl,
    required List<MenuItemModel> items,
  }) : super(
    id: id,
    name: name,
    buttonImageUrl: buttonImageUrl,
    items: items,
  );

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((i) => MenuItemModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return MenuCategoryModel(
      id: json['id'],
      name: json['name'],
      buttonImageUrl: json['buttonImageUrl'] ?? '',
      items: items,
    );
  }
}