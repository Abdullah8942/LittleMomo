import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No orders yet',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final items = List<Map<String, dynamic>>.from(data['items'] ?? []);
              final totalAmount = data['totalAmount'] ?? 0.0;
              final status = data['status'] ?? 'pending';
              final createdAt = data['createdAt'] as Timestamp?;
              final userId = data['userId'] ?? 'Unknown User';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ExpansionTile(
                  title: Text(
                    'Order #${doc.id.substring(0, 8)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: ₹${totalAmount.toStringAsFixed(2)}'),
                      Text('Status: ${status.toUpperCase()}'),
                      if (createdAt != null)
                        Text(
                          'Date: ${createdAt.toDate().toString().split('.')[0]}',
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User ID: $userId'),
                          const SizedBox(height: 8),
                          const Text(
                            'Items:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...items.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(item['name'] ?? 'Unknown Item'),
                                    ),
                                    Text(
                                      'Qty: ${item['quantity']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => _updateOrderStatus(
                                  context,
                                  doc.id,
                                  'processing',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text('Process'),
                              ),
                              ElevatedButton(
                                onPressed: () => _updateOrderStatus(
                                  context,
                                  doc.id,
                                  'completed',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Complete'),
                              ),
                              ElevatedButton(
                                onPressed: () => _updateOrderStatus(
                                  context,
                                  doc.id,
                                  'cancelled',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _updateOrderStatus(
    BuildContext context,
    String orderId,
    String status,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      if (context.mounted) {
        Flushbar(
          message: 'Order status updated to $status',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ).show(context);
      }
    } catch (e) {
      if (context.mounted) {
        Flushbar(
          message: 'Error updating order status: $e',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ).show(context);
      }
    }
  }
} 