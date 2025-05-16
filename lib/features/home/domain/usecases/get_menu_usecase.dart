import '../entities/menu_category.dart';
import '../repositories/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repo;
  GetMenuUseCase(this.repo);
  Future<List<MenuCategory>> call() => repo.fetchMenu();
}
