import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('cart').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear Cart'),
                      content: const Text(
                          'Are you sure you want to remove all items from your cart?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            try {
                              final batch = FirebaseFirestore.instance.batch();
                              for (var doc in snapshot.data!.docs) {
                                batch.delete(doc.reference);
                              }
                              await batch.commit();
                              if (mounted) {
                                Flushbar(
                                  message: 'Cart cleared successfully',
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ).show(context);
                              }
                            } catch (e) {
                              if (mounted) {
                                Flushbar(
                                  message: 'Failed to clear cart: $e',
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ).show(context);
                              }
                            }
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Browse Menu'),
                  ),
                ],
              ),
            );
          }

          final cartItems = snapshot.data!.docs;
          double totalAmount = 0;
          for (var doc in cartItems) {
            final data = doc.data() as Map<String, dynamic>;
            totalAmount += (data['price'] as num) * (data['quantity'] as num);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final doc = cartItems[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final cartId = doc.id;
                    final productName = data['name'] as String;
                    final price = data['price'] as num;
                    final quantity = data['quantity'] as num;
                    final imageUrl = data['imageUrl'] as String;

                    return Dismissible(
                      key: Key(cartId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(cartId)
                              .delete();
                          if (mounted) {
                            Flushbar(
                              message: 'Item removed from cart',
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ).show(context);
                          }
                        } catch (e) {
                          if (mounted) {
                            Flushbar(
                              message: 'Failed to remove item: $e',
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ).show(context);
                          }
                        }
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, size: 50);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${price.toString()}',
                                      style: const TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.deepOrange),
                                    onPressed: () async {
                                      if (quantity > 1) {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cartId)
                                              .update({
                                            'quantity': quantity - 1
                                          });
                                        } catch (e) {
                                          if (mounted) {
                                            Flushbar(
                                              message: 'Failed to update quantity: $e',
                                              duration: const Duration(seconds: 2),
                                              backgroundColor: Colors.red,
                                            ).show(context);
                                          }
                                        }
                                      } else {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('cart')
                                              .doc(cartId)
                                              .delete();
                                        } catch (e) {
                                          if (mounted) {
                                            Flushbar(
                                              message: 'Failed to remove item: $e',
                                              duration: const Duration(seconds: 2),
                                              backgroundColor: Colors.red,
                                            ).show(context);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.deepOrange),
                                    onPressed: () async {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(cartId)
                                            .update({
                                          'quantity': quantity + 1
                                        });
                                      } catch (e) {
                                        if (mounted) {
                                          Flushbar(
                                            message: 'Failed to update quantity: $e',
                                            duration: const Duration(seconds: 2),
                                            backgroundColor: Colors.red,
                                          ).show(context);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _proceedToCheckout(totalAmount),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _proceedToCheckout(double totalAmount) {
    if (totalAmount <= 0) {
      Flushbar(
        message: 'Your cart is empty',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ).show(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Order'),
        content: Text(
            'Your order total is ₹${totalAmount.toStringAsFixed(2)}. Proceed with checkout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                // Create order in Firestore
                await FirebaseFirestore.instance.collection('orders').add({
                  'items': await FirebaseFirestore.instance.collection('cart').get().then(
                    (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
                  ),
                  'totalAmount': totalAmount,
                  'status': 'pending',
                  'createdAt': FieldValue.serverTimestamp(),
                });

                // Clear cart
                final batch = FirebaseFirestore.instance.batch();
                final cartSnapshot = await FirebaseFirestore.instance.collection('cart').get();
                for (var doc in cartSnapshot.docs) {
                  batch.delete(doc.reference);
                }
                await batch.commit();

                if (mounted) {
                  Flushbar(
                    message: 'Order placed successfully!',
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ).show(context);
                  Navigator.pop(context);
                }
              } catch (e) {
                if (mounted) {
                  Flushbar(
                    message: 'Failed to place order: $e',
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ).show(context);
                }
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
} 