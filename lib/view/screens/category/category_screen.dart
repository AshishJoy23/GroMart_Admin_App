import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/category_controller.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: const MainAppBarWidget(
          title: 'Category',
        ),
        body: Obx(
          () => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            itemCount: categoryController.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.15,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Center(
                  child: CategoryCardWidget(
                category: categoryController.categories[index],
                categoryController: categoryController,
              ));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddCategoryScreen());
          },
          backgroundColor: const Color(0xff388E3C),
          child: const Icon(
            Icons.add,
          ),
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
