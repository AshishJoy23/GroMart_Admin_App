import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';
import 'package:gromart_admin_app/models/models.dart';
import 'package:gromart_admin_app/services/database_services.dart';
import 'package:gromart_admin_app/services/storage_services.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  final CategoryController categoryController;
  const EditCategoryScreen({
    super.key,
    required this.category,
    required this.categoryController,
  });

  @override
  Widget build(BuildContext context) {
    final StorageService storage = StorageService();
    final DatabaseServices database = DatabaseServices();

    categoryController.newProduct.addAll({
      'id': category.id,
      'name': category.name,
      'imageUrl': category.imageUrl,
    });
    categoryController.categoryImageUrl.value = category.imageUrl;

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
          title: 'Edit Product',
          actionList: const [],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: ListView(
          children: [
            const SectionTitleWidget(
              title: 'Update Information',
            ),
            const SizedBox(
              height: 10,
            ),
            CategoryAddImageWidget(
              categoryController: categoryController,
              storage: storage,
            ),
            CategoryTextFormField(categoryController: categoryController),
            const SizedBox(height: 24.0),
            MainButtonWidget(
              buttonText: 'Update Product',
              onPressed: () async {
                log('*****************');
                log(category.id.toString());
                await database.updateCategory(
                  CategoryModel(
                    id: categoryController.newProduct['id'] ?? category.id,
                    name: categoryController.newProduct['name'] ?? category.name,
                    imageUrl: categoryController.newProduct['imageUrl'].value ??
                        category.imageUrl,
                  ),
                );
                log('<<<<<<<<<<<<<<<<<<<here not edited>>>>>>>>>>>>>>>>>>>');
                log(categoryController.newProduct.toString());
                categoryController.onClose();
                log(categoryController.newProduct.toString());
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
