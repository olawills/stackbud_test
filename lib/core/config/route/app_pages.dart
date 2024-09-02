import 'package:get/get.dart';
import 'package:stackbud_test/features/bindings/product_binding.dart';
import 'package:stackbud_test/features/presentation/products/product_detail_view.dart';
import 'package:stackbud_test/features/presentation/products/product_edit_view.dart';
import 'package:stackbud_test/features/presentation/products/products_catalog.dart';
import 'package:stackbud_test/features/presentation/startup/splash_screen.dart';

part 'app_route.dart';

abstract class AppPages {
  static final pages = [
    // Splash Screen
    GetPage(
      name: Routes.start,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductsCatalogScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => const ProductDetailScreen(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.productEdit,
      page: () => const ProductEditView(),
      binding: ProductsBinding(),
    ),
  ];
}
