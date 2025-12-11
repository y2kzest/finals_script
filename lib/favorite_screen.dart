import 'package:flutter/material.dart';
import 'search_screen.dart'; 
import 'notification_screen.dart'; 


const Color kNewDarkBlue = Color(0xFF235789);
const Color kLightContainer = Color(0xFFF7F7F7);
const Color kTextColor = Color(0xFF333333);

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }

    if (index == 0) {
      Navigator.pop(context);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()),
      );
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 15.0),
            child: Text(
              'My Wishlist (2 Items)',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: const <Widget>[
                _FavoriteProductCard(
                  imageAsset: 'assets/shirt2.png',
                  name: 'Cherry Red',
                  price: '₱ 699',
                  size: 'M',
                ),
                SizedBox(height: 15),
                _FavoriteProductCard(
                  imageAsset: 'assets/shirt.png',
                  name: 'New Life ',
                  price: '₱ 699',
                  size: 'L',
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          
          _CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}

class _FavoriteProductCard extends StatelessWidget {
  final String imageAsset;
  final String name;
  final String price;
  final String size;

  const _FavoriteProductCard({
    required this.imageAsset,
    required this.name,
    required this.price,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kLightContainer, 
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageAsset,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                width: 100, height: 100, 
                child: Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Size: $size',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: const TextStyle(
                    color: kNewDarkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                onPressed: () {
                },
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: kNewDarkBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ],
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
              icon: Icons.favorite, 
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