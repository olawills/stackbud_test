import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/firebase/firebase_client.dart';
import 'package:stackbud_test/core/model/products_model.dart';

class FirebaseService extends GetxService implements FirebaseClient {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseService({
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> addProduct(Product product) async {
    await firestore.collection('products').add(product.toMap());
  }

  @override
  Future<List<Product>> getProducts() async {
    QuerySnapshot snapshot = await firestore.collection('products').get();
    return snapshot.docs
        .map((doc) =>
            Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<void> updateProduct(Product product) async {
    await firestore
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  @override
  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }

  @override
  Future<String> uploadImage(String filePath) async {
    File file = File(filePath);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child('product_images/$fileName');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
