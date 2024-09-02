import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/config/route/app_pages.dart';
import 'package:stackbud_test/features/controller/product_controller.dart';

class ProductsCatalogScreen extends GetView<ProductController> {
  const ProductsCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Catalog'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait(
            [
              controller.fetchProducts(),
              controller.fetchProducts(),
            ],
          );
        },
        child: Obx(() {
          final filteredProducts =
              controller.filterProducts(controller.products);
          if (filteredProducts.isEmpty) {
            const Center(child: Text('No Products Available'));
          }
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return ListTile(
                title: Text(product.name!),
                subtitle: Text('\$${product.price?.toStringAsFixed(2)}'),
                trailing: Text(product.category!),
                onTap: () {
                  controller.selectProduct(product);
                  Get.toNamed(Routes.productDetails);
                },
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.productEdit, arguments: controller.isAdding),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Filter Products'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: controller.setCategory,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Min Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.setPriceRange(
                      double.tryParse(value) ?? 0.0,
                      controller.maxPrice.value,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Max Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.setPriceRange(
                      controller.minPrice.value,
                      double.tryParse(value) ?? double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Reset'),
            onPressed: () {
              controller.resetFilters();
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Apply'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
