import '../entities/menu_category.dart';

abstract class MenuRepository {
  Future<List<MenuCategory>> fetchMenu();
}

