import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:stackbud_test/core/firebase/firebase_client.dart';
import 'package:stackbud_test/core/firebase/firebase_service.dart';
import 'package:stackbud_test/features/controller/product_controller.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseFirestore.instance, fenix: true);
    Get.lazyPut(() => FirebaseStorage.instance, fenix: true);

    // Register our firebase service
    Get.lazyPut<FirebaseClient>(
      () => FirebaseService(firestore: Get.find(), storage: Get.find()),
      fenix: true,
    );

    // Register our controller
    Get.lazyPut(() => ProductController(client: Get.find()));
  }
}
