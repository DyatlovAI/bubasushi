import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../config/themes/colors.dart';
import '../../../../config/themes/styles.dart';
import '../../domain/entities/menu_category.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/usecases/get_menu_usecase.dart';
import '../widgets/product_card.dart';
import '../widgets/tab_bar_section.dart';


void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String selectedStore = 'BUBA Город Столиц';
  final List<String> stores = [
    'BUBA Город Столиц',
    'Улица Мира',
    'Центральная',
  ];

  late Future<List<MenuCategory>> _menuFuture;

  @override
  void initState() {
    super.initState();
    final repo = MenuRepositoryImpl();
    final getMenuUseCase = GetMenuUseCase(repo);
    _menuFuture = getMenuUseCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    value: selectedStore,
                    isDense: true,
                    isExpanded: false,
                    customButton: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedStore,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    items: stores.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStore = value!;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Самовывоз',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Image.asset('assets/images/bonus.png', height: 40),
          const SizedBox(width: 10),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: SizedBox(height: 20),
        ),
      ),
      body: FutureBuilder<List<MenuCategory>>(
        future: _menuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Меню недоступно'));
          }

          final menuCategories = snapshot.data!;
          final selectedCategory = menuCategories[selectedTab];
          final items = selectedCategory.items;

          return Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 10),
                      Image.asset('assets/images/promo1.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/images/promo.png'),
                      const SizedBox(width: 10),
                      Image.asset('assets/images/promo2.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TabBarSection(
                  categories: menuCategories,
                  selectedIndex: selectedTab,
                  onTabSelected: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      children: items.map((item) => ProductCard(item: item)).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF4E4F50),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/menu1.png', width: 50, height: 40),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/menu2.png',width: 50, height: 40),
            label: 'Акции',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/menu3.png', width: 40, height: 40),
            label: 'Рестораны',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/menu4.png', width: 40, height: 40),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }
}