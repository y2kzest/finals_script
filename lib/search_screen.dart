import 'package:flutter/material.dart';
import 'favorite_screen.dart'; 
import 'notification_screen.dart'; 

const Color primaryBlue = Color(0xFF235789);
const Color kNewDarkBlue = primaryBlue;
const Color offWhiteBackground = Color(0xFFF5F5F5);
const Color lightTextColor = Color(0xFF888888);
const Color kTextColor = Color(0xFF333333);
const Color discountGreen = Color(0xFF00B050);
const Color favoriteRed = Color(0xFFD32F2F);

const String logoAssetPath = 'assets/logo.png';
const String greenShoeAssetPath = 'assets/shirt3.png';
const String pinkShoeAssetPath = 'assets/shirt4.png';
const String brownShoeAssetPath = 'assets/shirt5.png';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SearchContentScreen();
  }
}

class _SearchContentScreen extends StatefulWidget {
  const _SearchContentScreen();

  @override
  State<_SearchContentScreen> createState() => _SearchContentScreenState();
}

class _SearchContentScreenState extends State<_SearchContentScreen> {
  int _selectedIndex = 1; 

  void _onItemTapped(int index) {
    if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      return;
    }
    
    Navigator.pop(context); 

    if (index == 2) { 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteBackground,
      appBar: _buildAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            _SearchBox(),
            SizedBox(height: 16),
            _CategoryFilters(),
            SizedBox(height: 32),
            _BestSellersSection(),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: offWhiteBackground, 
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          logoAssetPath,
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Text(
            'LOGO',
            style: TextStyle(
              fontWeight: FontWeight.w900, 
              fontSize: 24, 
              color: kNewDarkBlue
            ),
          ),
        ),
      ),
      centerTitle: false,
      
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


class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: lightTextColor),
            fillColor: Colors.white, 
            filled: true,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: lightTextColor),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          ),
        ),
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _CategoryChip(label: 'All', isSelected: true),
          _CategoryChip(label: 'T-Shirts'),
          _CategoryChip(label: 'Hoodies'),
          _CategoryChip(label: 'Jackets'),
          _CategoryChip(label: 'Pants'),
          _CategoryChip(label: 'Accessories'),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isSelected
              ? BorderSide.none
              : const BorderSide(color: lightTextColor, width: 0.5),
        ),
      ),
    );
  }
}

class _BestSellersSection extends StatelessWidget {
  const _BestSellersSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Best Sellers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, 
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 16),
        _BestSellerItem(
          title: 'Graphic Tee - Sunset Print',
          description: 'Men\'s T-shirt', 
          rating: 5.0,
          price: '₱ 480',
          discount: '8% OFF',
          shoeAssetKey: 'green_shoe',
        ),
        _BestSellerItem(
          title: 'Vintage Pullover Hoodie',
          description: 'Casual Wear', 
          rating: 5.0,
          price: '₱ 580',
          discount: '5% OFF',
          shoeAssetKey: 'pink_shoe',
        ),
        _BestSellerItem(
          title: 'Slim-Fit Denim Jacket',
          description: 'Outerwear', 
          rating: 4.9,
          price: '₱ 580',
          discount: '5% OFF',
          shoeAssetKey: 'brown_shoe',
        ),
      ],
    );
  }
}

class _BestSellerItem extends StatelessWidget {
  final String title;
  final String description; 
  final double rating;
  final String price;
  final String? discount;
  final String shoeAssetKey;

  const _BestSellerItem({
    required this.title,
    this.description = 'Apparel', 
    required this.rating,
    required this.price,
    this.discount,
    required this.shoeAssetKey,
  });

  @override
  Widget build(BuildContext context) {
    Color shoeBgColor;
    String assetPath;

    if (shoeAssetKey == 'green_shoe') {
      shoeBgColor = const Color(0xFFC7E2D1);
      assetPath = greenShoeAssetPath;
    } else if (shoeAssetKey == 'pink_shoe') {
      shoeBgColor = const Color(0xFFE8D0D0);
      assetPath = pinkShoeAssetPath;
    } else {
      shoeBgColor = offWhiteBackground;
      assetPath = brownShoeAssetPath;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: shoeBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  width: 90, height: 90, 
                  child: Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16, color: kTextColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: lightTextColor, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kNewDarkBlue),
                      ),
                      if (discount != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: discountGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            discount!,
                            style: const TextStyle(
                                color: discountGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('$rating', style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 8),
                      const Icon(Icons.favorite_border,
                          color: favoriteRed, size: 16),
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