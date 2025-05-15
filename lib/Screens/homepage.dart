import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'assets/images/ssset.png',
      'title': 'Саке сет',
      'price': '2440₽',
      'gramm': '345г',
      'oldPrice': null,
      'isNew': false,
      'description': 'Саке сет объединяет три классических вкуса японской кухни. Роллы Филадельфия радуют сливочным сыром и лососем. Маки с лососем и авокадо добавляют кремовый и насыщенности. Салями лосось завершает сет чистой свежестью.',
      'calories': '614.8 кКал',
    },
    {
      'imageUrl': 'assets/images/ssset.png',
      'title': 'Унаги сет',
      'price': '2280₽',
      'gramm': '345г',
      'oldPrice': null,
      'isNew': false,
      'description': 'Унаги сет — это сочетание нежного унаги с классическими роллами. Включает унаги маки и роллы с угрем и авокадо.',
      'calories': '580 кКал',
    },
  ];
  String selectedStore = 'BUBA Город Столиц';

  final List<String> stores = [
    'BUBA Город Столиц',
    'Улица Мира',
    'Центральная',
  ];
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
                // Обёртка DropdownButton2 в Row, чтобы текст и стрелка были в одной строке
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
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEFF2F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 10),
                  Image.asset('assets/images/promo1.png'),
                  SizedBox(width: 10),
                  Image.asset('assets/images/promo.png'),
                  SizedBox(width: 10),
                  Image.asset('assets/images/promo2.png'),
                ],
              ),
            ),
            SizedBox(height: 30),
            TabBarSection(
              selectedIndex: selectedTab,
              onTabSelected: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  children: products.map((p) {
                    return ProductCard(
                      imageUrl: p['imageUrl'],
                      title: p['title'],
                      price: p['price'],
                      gramm: p['gramm'],
                      oldPrice: p['oldPrice'],
                      isNew: p['isNew'],
                      product: p, // Передаем весь объект product
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,  // Это позволит видеть все метки всегда
        selectedItemColor: Colors.black,        // Цвет активной метки
        unselectedItemColor: Color(0xFF4E4F50),     // Цвет неактивных меток
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

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String gramm;
  final String? oldPrice;
  final bool isNew;
  final Map<String, dynamic> product; // Добавляем поле для полного объекта товара

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.gramm,
    this.oldPrice,
    this.isNew = false,
    required this.product,
  });

  bool get isLocalAsset => imageUrl.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showProductDetailSheet(context, product);
      },

      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: isLocalAsset
                      ? Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isNew)
                  const Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.red,
                      child: Text(
                        'New',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        gramm,
                        style: TextStyle(fontSize: 14, color: Color(0xFF6E6C6C), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (oldPrice != null)
                            Text(
                              oldPrice!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (oldPrice != null) const SizedBox(width: 6),
                          Text(
                            price,
                            style: TextStyle(fontSize: 16, color: Color(0xFF6E6C6C), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Добавить в корзину
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, size: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showProductDetailSheet(BuildContext context, Map<String, dynamic> product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;

      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF2F5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Stack(
            children: [

              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  product['imageUrl'],
                  width: screenWidth,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 320, 16, 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        product['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Граммовка и ккал с белым фоном и закруглениями
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${product['gramm']} • ${product['calories'] ?? ''}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF6C6D6E)),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Описание с белым фоном
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          product['description'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF4E4F50)),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Тонкая серая линия
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),

                      const SizedBox(height: 16),

                      // Название и цена рядом
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['title'],
                            style: const TextStyle(fontSize: 18, color: Color(0xFF4E4F50)),
                          ),
                          Text(
                            product['price'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Кнопка "В корзину" во всю ширину
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC8241E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'В корзину',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Крестик поверх картинки в правом верхнем углу
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.white, shadows: [
                    Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(1, 1))
                  ]),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class TabBarSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarSection({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<Map<String, String>> _tabs = const [
    {
      'iconActive': 'assets/images/set.png',
      'iconInactive': 'assets/images/set1.png',
    },
    {
      'iconActive': 'assets/images/rol.png',
      'iconInactive': 'assets/images/rol1.png',
    },
    {
      'iconActive': 'assets/images/ruchrol.png',
      'iconInactive': 'assets/images/ruchrol1.png',
    },
    {
      'iconActive': 'assets/images/sush.png',
      'iconInactive': 'assets/images/sush1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final tab = _tabs[index];

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Image.asset(
              isSelected ? tab['iconActive']! : tab['iconInactive']!,
              height: 30,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}