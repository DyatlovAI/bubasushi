import '../../domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  MenuItemModel({
    required String sku,
    required String name,
    required String description,
    required String itemId,
    double? portionWeightGrams, // Изменено на double?
    double? price,
    required String buttonImageUrl,
  }) : super(
    sku: sku,
    name: name,
    description: description,
    itemId: itemId,
    portionWeightGrams: portionWeightGrams,
    price: price,
    buttonImageUrl: buttonImageUrl,
  );

  factory MenuItemModel.fromJson(Map<String, dynamic> j) {
    return MenuItemModel(
      sku: j['sku'],
      name: j['name'],
      description: j['description'] ?? '',
      itemId: j['itemId'],
      portionWeightGrams: (j['portionWeightGrams'] as num?)?.toDouble(),
      price: (j['price'] as num?)?.toDouble(),
      buttonImageUrl: j['buttonImageUrl'] ?? '',
    );
  }
}