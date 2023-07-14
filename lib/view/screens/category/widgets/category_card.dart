import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/category_controller.dart';
import '../../../../models/models.dart';
import '../../../../services/services.dart';
import '../../screens.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryController categoryController;
  final CategoryModel category;
  CategoryCardWidget({
    super.key,
    required this.category,
    required this.categoryController,
  });

  final DatabaseServices database = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    var heightScrn = MediaQuery.of(context).size.height / 5;
    var widthScrn = MediaQuery.of(context).size.width / 2.5;
    return GestureDetector(
      onTap: () {
        log(category.name);
        Get.to(()=> EachCategoryScreen(category: category));
      },
      child: Stack(
        children: [
          SizedBox(
            width: widthScrn,
            height: heightScrn,
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Container(
              width: widthScrn,
              height: heightScrn,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(80),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  iconSize: 30,
                  padding: const EdgeInsets.all(1.0),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Edit",
                      child: TextButton(
                        onPressed: () async {
                          await Get.to(() => EditCategoryScreen(
                            category: category,
                            categoryController: categoryController,
                              ));
                          Get.back();
                        },
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "Delete",
                      child: TextButton(
                        onPressed: () async {
                          await database.deleteCategory(category.id);
                          Get.back();
                        },
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: widthScrn,
              height: heightScrn * 0.35,
              decoration: BoxDecoration(
                color: const Color(0xff388E3C).withAlpha(230),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
