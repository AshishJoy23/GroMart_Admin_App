import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/models/category_model.dart';
import 'package:gromart_admin_app/view/screens/category/widgets/category_textfield.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';
import 'package:gromart_admin_app/view/widgets/widgets.dart';
import '../../../controllers/controllers.dart';
import '../../../services/services.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());
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
          title: 'Add New Category',
          actionList: const [],
          leadingOnPressed: () {
            categoryController.onClose();
            Get.back();
          },
        ),
        body: ListView(
          children: [
            const SectionTitleWidget(
              title: 'Category Information',
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
            Row(
              children: [
                MainButtonWidget(
                  buttonText: 'Add Category',
                  onPressed: () async {
                    DateTime currentTime = DateTime.now();
                    int milliseconds = currentTime.millisecondsSinceEpoch;
                    log(milliseconds.toString());
                    categoryController.newProduct.update(
                      'id',
                      (_) => milliseconds,
                      ifAbsent: () => milliseconds,
                    );
                    database.addCategory(
                      CategoryModel(
                        id: categoryController.newProduct['id'],
                        name: categoryController.newProduct['name'],
                        imageUrl: categoryController.newProduct['imageUrl'].value,
                      ),
                    );
                    log(categoryController.newProduct.toString());
                    categoryController.onClose();
                    log(categoryController.newProduct.toString());
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
