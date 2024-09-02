import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stackbud_test/core/model/products_model.dart';
import 'package:stackbud_test/features/controller/product_controller.dart';

class ProductEditView extends GetView<ProductController> {
  const ProductEditView({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract the boolean flag from the arguments passed to the widget
    final bool isEditing = Get.arguments as bool;
    // Set the isEditing in the controller
    controller.isEditing = isEditing;

    if (isEditing == true) {
      final product = controller.selectedProduct;
      controller.nameController.text = product!.name!;
      controller.descriptionController.text = product.description!;
      controller.priceController.text = product.price.toString();
      controller.categoryController.text = product.category!;
    }
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            controller: scrollController,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: controller.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                controller: controller.priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a price' : null,
              ),
              TextFormField(
                controller: controller.categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a category' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Choose Image'),
                onPressed: () => pickImage(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text(isEditing ? 'Update Product' : 'Add Product'),
                onPressed: () => submitForm(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await controller.uploadImage(image.path);
    }
  }

  void submitForm() {
    if (controller.formKey.currentState!.validate()) {
      final product = Product(
        id: controller.isEditing ? controller.selectedProduct?.id : null,
        name: controller.nameController.text,
        description: controller.descriptionController.text,
        price: int.parse(controller.priceController.text),
        category: controller.categoryController.text,
      );
      if (controller.isEditing) {
        controller.updateProduct(product);
      } else {
        controller.addProduct(product);
      }
      Get.back();
    }
  }
}
