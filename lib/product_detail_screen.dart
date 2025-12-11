import 'package:flutter/material.dart';

const Color kNewDarkBlue = Color(0xFF235789);
const Color kLightContainer = Color(0xFFF7F7F7);
const Color kTextColor = Color(0xFF333333);

class ProductDetailScreen extends StatelessWidget {
  final String imageAsset;
  final String name;
  final String price;
  final double rating;
  final String description;
  final int reviews;

  const ProductDetailScreen({
    super.key,
    required this.imageAsset,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.reviews,
  });

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
        title: Image.asset(
          'assets/logo.png',
          height: 30,
          color: kNewDarkBlue,
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kLightContainer,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        imageAsset,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price.replaceAll('₱', '\₱'),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '$rating',
                          style: const TextStyle(fontSize: 16, color: kTextColor, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' (${reviews.toStringAsFixed(3)}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const Text(
                          ')',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const Spacer(),
                        const Text(
                          'See all review',
                          style: TextStyle(
                            fontSize: 14,
                            color: kNewDarkBlue,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Text(
                      description,
                      style: const TextStyle(fontSize: 16, color: kTextColor),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                      },
                      child: const Text(
                        'See more',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: kTextColor),
                    onPressed: () {  },
                  ),
                  const Text('1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add, color: kTextColor),
                    onPressed: () {  },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {  },
                icon: const Icon(Icons.shopping_bag_outlined, size: 24),
                label: const Text('Add to Basket', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kNewDarkBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}