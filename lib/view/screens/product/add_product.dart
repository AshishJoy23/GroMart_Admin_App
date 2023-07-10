import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/services/database_services.dart';
import 'package:gromart_admin_app/services/storage_services.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final StorageService storage = StorageService();
    final DatabaseServices database = DatabaseServices();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: 'Add New Product',
          actionList: const [],
          leadingOnPressed: () {
            productController.onClose();
            Get.back();
          },
        ),
        body: ListView(
          children: [
            ProductAddImageWidget(
                productController: productController, storage: storage),
            const SizedBox(
              height: 10,
            ),
            const SectionTitleWidget(
              title: 'Product Information',
            ),
            ProductDetailsWidget(productController: productController),
            const SizedBox(height: 24.0),
            MainButtonWidget(
              buttonText: 'Add Product',
              onPressed: () async {
                DateTime currentTime = DateTime.now();
                int milliseconds = currentTime.millisecondsSinceEpoch;
                log(milliseconds.toString());
                productController.newProduct.update(
                  'id',
                  (_) => milliseconds,
                  ifAbsent: () => milliseconds,
                );
                database.addProduct(
                  ProductModel(
                    id: productController.newProduct['id'],
                    name: productController.newProduct['name'],
                    category: productController.newProduct['category'],
                    description: productController.newProduct['description'],
                    imageUrls: productController.newProduct['imageUrls'],
                    isRecommended:
                        productController.newProduct['isRecommended'] ?? false,
                    isPopular:
                        productController.newProduct['isPopular'] ?? false,
                    isTopRated:
                        productController.newProduct['isTopRated'] ?? false,
                    isTodaySpecial:
                        productController.newProduct['isTodaySpecial'] ?? false,
                    price: double.parse(productController.newProduct['price']),
                    quantity:
                        int.parse(productController.newProduct['quantity']),
                  ),
                );

                log(productController.newProduct.toString());
                productController.onClose();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
