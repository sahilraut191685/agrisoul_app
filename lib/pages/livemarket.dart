import 'package:flutter/material.dart';

// --- Data Model for a Product ---
// Using an enum makes the trend property safer and clearer
enum PriceTrend { up, down, stable }

class Product {
  final String name;
  final IconData icon;
  final double price;
  final String unit;
  final PriceTrend trend;

  Product({
    required this.name,
    required this.icon,
    required this.price,
    required this.unit,
    required this.trend,
  });
}


// --- Main Page Widget ---
class MarketPricePage extends StatelessWidget {
  MarketPricePage({super.key});

  // DUMMY DATA: In a real app, you would fetch this from a live API
  final List<Product> products = [
    Product(name: 'Onions (Pune)', icon: Icons.eco, price: 2250.00, unit: 'quintal', trend: PriceTrend.up),
    Product(name: 'Tomatoes', icon: Icons.local_florist, price: 1800.00, unit: 'quintal', trend: PriceTrend.down),
    Product(name: 'Potatoes (Agra)', icon: Icons.spa, price: 1950.00, unit: 'quintal', trend: PriceTrend.stable),
    Product(name: 'Wheat', icon: Icons.grain, price: 2100.00, unit: 'quintal', trend: PriceTrend.up),
    Product(name: 'Soybean', icon: Icons.grass, price: 4500.00, unit: 'quintal', trend: PriceTrend.down),
    Product(name: 'Cotton', icon: Icons.filter_vintage, price: 7200.00, unit: 'quintal', trend: PriceTrend.stable),
    Product(name: 'Sugarcane', icon: Icons.energy_savings_leaf, price: 315.00, unit: 'quintal', trend: PriceTrend.stable),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APMC Market Prices'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}


// --- UI Widget for a Single Product Card ---
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  // Helper function to get the correct icon and color for the price trend
  Widget _getTrendIcon() {
    switch (product.trend) {
      case PriceTrend.up:
        return const Icon(Icons.arrow_upward, color: Colors.green, size: 18);
      case PriceTrend.down:
        return const Icon(Icons.arrow_downward, color: Colors.red, size: 18);
      case PriceTrend.stable:
        return const Icon(Icons.horizontal_rule, color: Colors.grey, size: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(product.icon, size: 28, color: Colors.green.shade800),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            // Using \u20B9 for the Rupee symbol
                            '\u20B9${product.price.toStringAsFixed(2)} / ${product.unit}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _getTrendIcon(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green.shade700,
                      content: Text('Contacting buyers for ${product.name}...'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Sell in Bulk'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}