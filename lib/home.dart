import 'package:flutter/material.dart';
import 'search_screen.dart'; 
import 'favorite_screen.dart'; 
import 'product_detail_screen.dart'; 
import 'notification_screen.dart'; 
import 'cart.dart'; 
import 'main.dart'; 

const Color kNewDarkBlue = Color(0xFF235789);
const Color kLightContainer = Color(0xFFF7F7F7);
const Color kTextColor = Color(0xFF333333);
const Color kProfileBgColor = Colors.white; 

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  int _selectedIndex = 0; 
  String _selectedCategory = 'Popular Now'; 
  
  bool _showProfileMenu = false; 

  void _toggleProfileMenu() {
    setState(() {
      _showProfileMenu = !_showProfileMenu;
    });
  }

  void _onItemTapped(int index) {
    if (_showProfileMenu) {
      _toggleProfileMenu();
    }
    
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) { 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    } else if (index == 2) { 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavoritesScreen()),
      );
    } else if (index == 3) { 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()),
      );
    }
  }

  void _onCategoryTapped(String category) {
    if (_showProfileMenu) {
      _toggleProfileMenu();
    }
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, 
      body: Stack( 
        children: [
          
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  top: true,
                  bottom: false, 
                  child: _HomeContent(
                    selectedCategory: _selectedCategory,
                    onCategoryTapped: _onCategoryTapped,
                    onProfileIconTapped: _toggleProfileMenu, 
                  ),
                ),
              ),
              _CustomBottomNavBar(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ],
          ),

          
          if (_showProfileMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleProfileMenu, 
                child: Container(
                  color: Colors.black54.withOpacity(0.0), 
                  alignment: Alignment.topLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 60.0, left: 16.0), 
                    child: _ProfilePopUp(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryTapped;
  final VoidCallback onProfileIconTapped; 

  const _HomeContent({
    required this.selectedCategory, 
    required this.onCategoryTapped,
    required this.onProfileIconTapped, 
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _CustomHeader(onProfileIconTapped: onProfileIconTapped), 
          const _LocationBar(),
          const _DiscountBanner(),
          const SizedBox(height: 20),
          _CategoryTabsRow(
            selectedCategory: selectedCategory,
            onCategoryTapped: onCategoryTapped,
          ),
          const SizedBox(height: 12),
          const _PopularProductRow(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ProfilePopUp extends StatelessWidget {
  const _ProfilePopUp();

  @override
  Widget build(BuildContext context) {
    return Material( 
      color: Colors.transparent,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: kProfileBgColor, 
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              children: [
                const Icon(Icons.person_outline, color: kTextColor, size: 28),
                const SizedBox(width: 8),
                Text('Hi, Aaron', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
              ],
            ),
            const Divider(height: 16),

            
            const Text('Account Settings', style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor)),
            const SizedBox(height: 4),
            const Text('Email: aaron.crp28@gmail.com', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const Text('Name: Aaron Carpio', style: TextStyle(fontSize: 12, color: Colors.grey)),
            
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: kNewDarkBlue,
                  side: const BorderSide(color: kNewDarkBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Edit Profile'),
              ),
            ),

            const SizedBox(height: 16),
            
            
            _PopUpButton(label: 'Start Selling', onPressed: () {}),
            const SizedBox(height: 8),
            _PopUpButton(label: 'Affiliates Programs', onPressed: () {}),
            
            const SizedBox(height: 20),
            
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginApp()), 
                    (Route<dynamic> route) => false, 
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kNewDarkBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopUpButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PopUpButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: kTextColor,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label),
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  final VoidCallback onProfileIconTapped;

  const _CustomHeader({required this.onProfileIconTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          GestureDetector(
            onTap: onProfileIconTapped, 
            child: Row(
              children: [
                const Icon(Icons.person_outline, color: kTextColor, size: 28),
                const SizedBox(width: 8),
                Text(
                  'Hi, Aaron',
                  style: const TextStyle(fontSize: 18, color: kTextColor),
                ),
              ],
            ),
          ),
          
          
          Image.asset(
            'assets/logo.png', 
            height: 40,
            color: kNewDarkBlue,
            errorBuilder: (context, error, stackTrace) => const Text(
                'LOGO',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: kNewDarkBlue),
              ),
          ),
          
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            child: const Icon(Icons.shopping_cart_outlined, color: kTextColor, size: 28),
          ),
        ],
      ),
    );
  }
}


class _LocationBar extends StatelessWidget {
  const _LocationBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.location_on_outlined, color: kNewDarkBlue, size: 24),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Send to', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    'San Fernando, Pampanga',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kTextColor),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kNewDarkBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  minimumSize: Size.zero,
                ),
                child: const Text('Change', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountBanner extends StatelessWidget {
  const _DiscountBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: kNewDarkBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't miss out -",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const Text(
                    'Save up to 50% on your favorite products.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kNewDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Image(image: AssetImage('assets/shirt.png'), fit: BoxFit.fitHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTabsRow extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryTapped;

  const _CategoryTabsRow({
    required this.selectedCategory,
    required this.onCategoryTapped,
  });

  final List<String> categories = const [
    'Popular Now',
    'New Arrivals',
    'Oversize',
    'Vintage',
    'Sale',
    'Graphics',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isActive = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => onCategoryTapped(category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? kNewDarkBlue : kLightContainer,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive ? kNewDarkBlue : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.white : kTextColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PopularProductRow extends StatelessWidget {
  const _PopularProductRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: const <Widget>[
          _ProductCard(
            imageAsset: 'assets/shirt2.png',
            name: 'Cherry Red',
            price: '₱ 699',
            rating: 4.8,
          ),
          SizedBox(width: 16),
          _ProductCard(
            imageAsset: 'assets/shirt3.png',
            name: 'New Life',
            price: '₱ 699',
            rating: 4.9,
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageAsset;
  final String name;
  final String price;
  final double rating;
  final String description; 
  final int reviews; 

  const _ProductCard({
    required this.imageAsset,
    required this.name,
    required this.price,
    required this.rating,
    this.description = 'The New Life Tee is a simple yet classic essential designed for everyday wear.', 
    this.reviews = 1205, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              imageAsset: imageAsset,
              name: name,
              price: price,
              rating: rating,
              description: description,
              reviews: reviews,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: kLightContainer,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(imageAsset, fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: kTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$rating',
                            style: const TextStyle(fontSize: 12, color: kTextColor),
                          ),
                          const Icon(Icons.star, color: Colors.amber, size: 12),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('See more', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () { 
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    imageAsset: imageAsset,
                                    name: name,
                                    price: price,
                                    rating: rating,
                                    description: description,
                                    reviews: reviews,
                                  ),
                                ),
                              );
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kNewDarkBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            minimumSize: Size.zero,
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.add, size: 14),
                              Text('Add to cart'),
                            ],
                          ),
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

class _CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const _CustomBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 70 + bottomPadding, 
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _BottomNavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: selectedIndex == 0,
              activeColor: kNewDarkBlue,
              onTap: () => onTap(0),
            ),
            _BottomNavItem(
              icon: Icons.search,
              label: 'Search',
              isActive: selectedIndex == 1,
              activeColor: kNewDarkBlue,
              onTap: () => onTap(1),
            ),
            _BottomNavItem(
              icon: Icons.favorite_border,
              label: 'Favorites',
              isActive: selectedIndex == 2,
              activeColor: kNewDarkBlue,
              onTap: () => onTap(2),
            ),
            _BottomNavItem(
              icon: Icons.notifications_none_outlined, 
              label: 'Notifs', 
              isActive: selectedIndex == 3,
              activeColor: kNewDarkBlue,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: isActive
                ? BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 24,
            ),
          ),
          if (!isActive)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}