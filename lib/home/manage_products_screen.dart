import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data['imageUrl'] ?? ''),
                    radius: 30,
                  ),
                  title: Text(data['name'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: ₹${data['price']?.toString() ?? '0'}'),
                      Text('Stock: ${data['inStock'] == true ? 'In Stock' : 'Out of Stock'}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showUpdateDialog(doc.id, data),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDeleteConfirmation(doc.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showUpdateDialog(String productId, Map<String, dynamic> data) async {
    final TextEditingController nameController = TextEditingController(text: data['name']);
    final TextEditingController priceController = TextEditingController(text: data['price']?.toString());
    final TextEditingController descriptionController = TextEditingController(text: data['description']);
    bool inStock = data['inStock'] ?? true;
    String? imageUrl = data['imageUrl'];

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Update Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('In Stock:'),
                    Switch(
                      value: inStock,
                      onChanged: (value) => setState(() => inStock = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final ref = _storage.ref().child('products/${DateTime.now().millisecondsSinceEpoch}');
                      await ref.putFile(File(image.path));
                      imageUrl = await ref.getDownloadURL();
                      setState(() {});
                    }
                  },
                  child: const Text('Change Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _firestore.collection('products').doc(productId).update({
                    'name': nameController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'description': descriptionController.text,
                    'inStock': inStock,
                    if (imageUrl != null) 'imageUrl': imageUrl,
                  });

                  if (mounted) {
                    Navigator.pop(context);
                    Flushbar(
                      message: 'Product updated successfully',
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ).show(context);
                  }
                } catch (e) {
                  if (mounted) {
                    Flushbar(
                      message: 'Error updating product: $e',
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ).show(context);
                  }
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(String productId) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firestore.collection('products').doc(productId).delete();
                if (mounted) {
                  Navigator.pop(context);
                  Flushbar(
                    message: 'Product deleted successfully',
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ).show(context);
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                  Flushbar(
                    message: 'Error deleting product: $e',
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ).show(context);
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 