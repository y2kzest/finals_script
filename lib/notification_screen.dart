import 'package:flutter/material.dart';
import 'search_screen.dart'; 
import 'favorite_screen.dart'; 

const Color kNewDarkBlue = Color(0xFF235789);
const Color kLightContainer = Color(0xFFF7F7F7);
const Color kTextColor = Color(0xFF333333);
const Color kAccentRed = Color(0xFFE53935);

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isNew;
  final bool isPromotion;

  const NotificationItem({ 
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isNew = false,
    this.isPromotion = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 3;

  final List<NotificationItem> notifications = const [
    NotificationItem(
      title: 'Order Confirmed!',
      message: 'Your order #12345 has been successfully confirmed and is being prepared.',
      time: '5 min ago',
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      isNew: true,
    ),
    NotificationItem(
      title: 'Flash Sale Alert!',
      message: 'Up to 70% off selected tees! Tap here to grab the deals.',
      time: '1 hour ago',
      icon: Icons.local_fire_department_outlined,
      iconColor: kAccentRed,
      isNew: true,
      isPromotion: true,
    ),
    NotificationItem(
      title: 'Review Reminder',
      message: 'Tell us what you thought about your last purchase.',
      time: '3 hours ago',
      icon: Icons.star_border,
      iconColor: Colors.amber,
    ),
    NotificationItem(
      title: 'Payment Failed',
      message: 'The payment for order #12340 could not be processed. Please update.',
      time: 'Yesterday',
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
    ),
    NotificationItem(
      title: 'Shipping Update',
      message: 'Your package is out for delivery today. Estimated arrival: 2 PM.',
      time: '2 days ago',
      icon: Icons.local_shipping_outlined,
      iconColor: kNewDarkBlue,
    ),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }

    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst); 
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FavoritesScreen()),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context), 
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read!')),
              );
            },
            child: const Text(
              'Mark All Read',
              style: TextStyle(color: kNewDarkBlue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Updates',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: kLightContainer,
                ),
                itemBuilder: (context, index) {
                  return _NotificationTile(item: notifications[index]);
                },
              ),
            ),
            _CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;

  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on: ${item.title}')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        color: item.isNew ? kLightContainer : Colors.white, 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.iconColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        item.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: item.isNew ? kNewDarkBlue : Colors.grey.shade600,
                          fontWeight: item.isNew ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.isPromotion) const SizedBox(height: 6),
                  if (item.isPromotion)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: kAccentRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Promo - Tap to View',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (item.isNew)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kNewDarkBlue,
                    shape: BoxShape.circle,
                  ),
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
              icon: Icons.notifications_active_outlined, 
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