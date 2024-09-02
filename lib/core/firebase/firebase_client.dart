import 'package:stackbud_test/core/model/products_model.dart';

abstract class FirebaseClient {
  Future<List<Product>> getProducts();
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<String> uploadImage(String filePath);
}
