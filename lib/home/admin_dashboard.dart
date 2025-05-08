import 'package:flutter/material.dart';
import 'package:littlemomo/home/add_product_screen.dart';
import 'package:littlemomo/home/manage_products_screen.dart';
import 'package:littlemomo/home/admin_orders_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardItem(
            context,
            'Add Product',
            Icons.add_circle,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductScreen()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Manage Products',
            Icons.edit,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManageProductsScreen()),
            ),
          ),
          _buildDashboardItem(
            context,
            'View Orders',
            Icons.shopping_cart,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminOrdersScreen()),
            ),
          ),
          _buildDashboardItem(
            context,
            'Analytics',
            Icons.analytics,
            Colors.purple,
            () {
              // TODO: Implement analytics screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Analytics coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 