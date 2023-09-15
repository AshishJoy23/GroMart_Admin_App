import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/controllers/product_controller.dart';
import '../../../models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        key: scaffoldKey,
        appBar: MainAppBarWidget(
          title: 'Hey Admin!!!',
          scaffoldKey: scaffoldKey,
        ),
        drawer: const CustomDrawerWidget(),
        body: ListView(
          children: [
            const SearchBarWidget(),
            CustomBannerWidget(),
            const SectionTitleWidget(
              title: 'ALL PRODUCTS',
            ),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemCount: productController.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: ProductCardWidget(
                      product: productController.products[index],
                      productController: productController,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddProductScreen());
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
