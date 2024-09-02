import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/config/route/app_pages.dart';
import 'package:stackbud_test/features/controller/product_controller.dart';

class ProductDetailScreen extends GetView<ProductController> {
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Get.toNamed(Routes.productEdit,
                arguments: controller.isEditing),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: Obx(() {
        final product = controller.selectedProduct;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(product!.imageUrl!),
            if (product!.imageUrl != null)
              Container(
                width: double.infinity,
                height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      product.imageUrl!,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name: ${product.name}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Price: ',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: '\$${product.price?.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                      // style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category: ${product.category}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Description',
                      //     style: const TextStyle(
                      //         fontSize: 14, color: Colors.black),
                      //     children: [
                      //       TextSpan(
                      //           text: product.description,
                      //           style: const TextStyle(
                      //               fontSize: 14, color: Colors.black)),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              controller.deleteProduct(controller.selectedProduct!.id!);
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
