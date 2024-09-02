import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/enums/common_enums.dart';
import 'package:stackbud_test/core/firebase/firebase_client.dart';
import 'package:stackbud_test/core/model/products_model.dart';

class ProductController extends GetxController {
  final FirebaseClient client;

  ProductController({required this.client});

  final RxList<Product> _products = <Product>[].obs;
  final Rx<Product?> _selectedProduct = Rx<Product?>(null);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<Product> get products => _products;
  set products(List<Product> value) => _products.value = value;

  Product? get selectedProduct => _selectedProduct.value;
  set selectedProduct(Product? value) {
    _selectedProduct.value = value;
    fetchProducts();
  }

  // Loading indicator
  final status = Status.success.obs;

  // Applying our filter to the product
  final RxString selectedCategory = ''.obs;
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = double.infinity.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    products.value = await client.getProducts();
  }

  Future<void> addProduct(Product product) async {
    await client.addProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await client.updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await client.deleteProduct(id);
    await fetchProducts();
  }

  void selectProduct(Product product) {
    _selectedProduct.value = product;
  }

  // ** Method to get image from device and upload it to firebase storage
  Future<String> uploadImage(String filePath) async {
    return await client.uploadImage(filePath);
  }

  // ** Filter Logic

  List<Product> filterProducts(List<Product> products) {
    return products.where((product) {
      bool categoryMatch = selectedCategory.isEmpty ||
          product.category == selectedCategory.value;
      bool priceMatch =
          product.price! >= minPrice.value && product.price! <= maxPrice.value;
      return categoryMatch && priceMatch;
    }).toList();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setPriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void resetFilters() {
    selectedCategory.value = '';
    minPrice.value = 0.0;
    maxPrice.value = double.infinity;
  }
}
