import 'package:flutter/material.dart';

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
      'gramm': '• 345г',
      'oldPrice': null,
      'isNew': false,
    },
    {
      'imageUrl': 'assets/images/ssset.png',
      'title': 'Унаги сет',
      'price': '2280₽',
      'gramm': '• 345г',
      'oldPrice': null,
      'isNew': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BUBA', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Самовывоз', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Image.asset('assets/images/bonus.png', height: 40),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: SizedBox(height: 20),
        ),
      ),
      body:
      Container(
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
                  childAspectRatio: 0.8,
                  children: products.map((p) {
                    return ProductCard(
                      imageUrl: p['imageUrl'],
                      title: p['title'],
                      price: p['price'],
                      gramm: p['gramm'],
                      oldPrice: p['oldPrice'],
                      isNew: p['isNew'],
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Меню'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Акции'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Рестораны'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
        ],
      ),
    );
  }

  Widget _promoCard(String text) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Center(child: Text(text, textAlign: TextAlign.center)),
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

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.gramm,
    this.oldPrice,
    this.isNew = false,
  });

  bool get isLocalAsset => imageUrl.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    return Card(
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
                /// Название + граммовка
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

                /// Цена + кнопка "+"
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
                        // добавить в корзину
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
    );
  }
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
      height: 40, // Высота области для кнопок
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



// class TabBarSection extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTabSelected;
//
//   const TabBarSection({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   final List<Map<String, String>> _tabs = const [
//     {
//       'label': 'Сеты',
//       'iconActive': 'assets/images/set-color.png',
//       'iconInactive': 'assets/images/set-grey.png',
//     },
//     {
//       'label': 'Роллы',
//       'iconActive': 'assets/images/rollie-color.png',
//       'iconInactive': 'assets/images/rollie-grey.png',
//     },
//     {
//       'label': 'Ручные роллы',
//       'iconActive': 'assets/images/hand-rolls-color.png',
//       'iconInactive': 'assets/images/hand-rolls-grey.png',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 1),
//       child: SizedBox(
//         height: 50,
//         child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           itemCount: _tabs.length,
//           separatorBuilder: (_, __) => const SizedBox(width: 8),
//           itemBuilder: (context, index) {
//             final isSelected = index == selectedIndex;
//             final tab = _tabs[index];
//
//             return GestureDetector(
//               onTap: () => onTabSelected(index),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.white : Colors.transparent,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: isSelected ? Colors.orange : Colors.grey.shade400,
//                     width: 1,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       isSelected ? tab['iconActive']! : tab['iconInactive']!,
//                       height: 40,
//                       width: 40,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       tab['label']!,
//                       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
