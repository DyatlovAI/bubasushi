import 'menu_item.dart';

class MenuCategory {
  final String id;
  final String name;
  final String buttonImageUrl;
  final List<MenuItem> items;

  MenuCategory({
    required this.id,
    required this.name,
    required this.buttonImageUrl,
    required this.items,
  });
}

