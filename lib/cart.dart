import 'package:flutter/material.dart';
import 'search_screen.dart'; 
import 'favorite_screen.dart'; 


const Color kNewDarkBlue = Color(0xFF235789);
const Color kLightContainer = Color(0xFFF7F7F7);
const Color kTextColor = Color(0xFF333333);
const Color kAccentRed = Color(0xFFE53935); 
const Color kDiscountGreen = Color(0xFF00B050);


class CartItem {
  final String id;
  final String name;
  final String imageAsset;
  final String color;
  final String size;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 1,
  });
}


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int _selectedIndex = 3;


  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Cherry Red Graphic Tee',
      imageAsset: 'assets/shirt2.png', 
      color: 'Red',
      size: 'M',
      price: 699.00,
      quantity: 1,
    ),
    CartItem(
      id: '2',
      name: 'New Life Oversized Hoodie',
      imageAsset: 'assets/shirt.png', 
      color: 'White',
      size: 'L',
      price: 699.00,
      quantity: 1,
    ),
  ];


  void _updateQuantity(String itemId, int change) {
    setState(() {
      final item = cartItems.firstWhere((i) => i.id == itemId);
      item.quantity += change;
      if (item.quantity <= 0) {
        cartItems.removeWhere((i) => i.id == itemId);
      }
    });
  }

  void _removeItem(String itemId) {
    setState(() {
      cartItems.removeWhere((i) => i.id == itemId);
    });
  }
  

  void _onItemTapped(int index) {


    if (index == _selectedIndex) return;

    if (index == 0) {
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

  }

  double get _subtotal => cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  double get _shippingCost => cartItems.isEmpty ? 0.0 : 50.00; 
  double get _total => _subtotal + _shippingCost;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Cart (${cartItems.length} Items)',
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      ...cartItems.map((item) => _CartItemTile(
                            item: item,
                            onQuantityChanged: (change) => _updateQuantity(item.id, change),
                            onRemove: () => _removeItem(item.id),
                          )).toList(),
                      
                      const SizedBox(height: 20),
                      
                      _PriceSummaryCard(
                        subtotal: _subtotal,
                        shipping: _shippingCost,
                        total: _total,
                      ),
                      
                      const SizedBox(height: 80), 
                    ],
                  ),
          ),
          

          _CheckoutSection(total: _total),
          _CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}


class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemTile({
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item.imageAsset,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                      width: 80, height: 80, 
                      child: Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text('Size: ${item.size} | Color: ${item.color}',
                          style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 8),
                      Text(
                        '₱ ${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: kNewDarkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  onPressed: onRemove,
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kLightContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove, 
                          onTap: () => onQuantityChanged(-1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add, 
                          onTap: () => onQuantityChanged(1),
                          color: kNewDarkBlue,
                        ),
                      ],
                    ),
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


class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _QuantityButton({required this.icon, required this.onTap, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 20,
        color: color,
      ),
    );
  }
}


class _PriceSummaryCard extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double total;

  const _PriceSummaryCard({required this.subtotal, required this.shipping, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
          ),
          const Divider(height: 20),
          _buildSummaryRow('Subtotal', '₱ ${subtotal.toStringAsFixed(2)}', false),
          _buildSummaryRow('Shipping', shipping > 0 ? '₱ ${shipping.toStringAsFixed(2)}' : 'Free', false),
          const Divider(height: 20),
          _buildSummaryRow('Total', '₱ ${total.toStringAsFixed(2)}', true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isTotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isTotal ? kTextColor : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              color: isTotal ? kNewDarkBlue : kTextColor,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


class _CheckoutSection extends StatelessWidget {
  final double total;

  const _CheckoutSection({required this.total});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.white.withOpacity(0.95), 
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Proceeding to Checkout!')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kNewDarkBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'CHECKOUT NOW (₱ ${total.toStringAsFixed(2)})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
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
              icon: Icons.shopping_bag, 
              label: 'Bag', 
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