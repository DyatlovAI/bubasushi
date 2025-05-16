class MenuItem {
  final String sku;
  final String name;
  final String description;
  final String itemId;
  final double? portionWeightGrams;
  final double? price;
  final String buttonImageUrl;

  MenuItem({
    required this.sku,
    required this.name,
    required this.description,
    required this.itemId,
    this.portionWeightGrams,
    this.price,
    required this.buttonImageUrl,
  });
}