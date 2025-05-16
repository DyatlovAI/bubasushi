import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_category_model.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final _url = 'https://loving-thompson.82-148-16-193.plesk.page/api/menu';

  @override
  Future<List<MenuCategory>> fetchMenu() async {
    final res = await http.get(Uri.parse(_url));
    if (res.statusCode != 200) {
      throw Exception('Failed to load menu');
    }
    final list = json.decode(res.body) as List<dynamic>;
    return list
        .map((j) => MenuCategoryModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}
