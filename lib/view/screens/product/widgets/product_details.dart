import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controllers.dart';
import '../../screens.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.productController,
    this.hintTexts = const [],
    this.editPage = false,
  });

  final ProductController productController;
  final List<String> hintTexts;
  final bool editPage;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ProductTextFormField(
            hintText: (editPage)?hintTexts[0]:'Enter product name',
            iconData: Icons.info_outline,
            productController: productController,
            name: 'name',
          ),
          ProductTextFormField(
            hintText: (editPage)?hintTexts[1]:'Enter category name',
            iconData: Icons.category_outlined,
            productController: productController,
            name: 'category',
          ),
          ProductTextFormField(
            hintText: (editPage)?hintTexts[2]:'Enter description',
            iconData: Icons.description_outlined,
            productController: productController,
            name: 'description',
            isMoreLines: true,
          ),
          ProductTextFormField(
            hintText: (editPage)?hintTexts[3]:'Enter price',
            iconData: Icons.money_outlined,
            productController: productController,
            name: 'price',
            type: true,
          ),
          ProductTextFormField(
            hintText: (editPage)?hintTexts[4]:'Enter quantity',
            iconData: Icons.numbers_outlined,
            productController: productController,
            name: 'quantity',
            type: true,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomCheckboxWidget(
            productController: productController,
            title: 'Recommended',
            name: 'isRecommended',
            controllerValue: productController.isRecommended,
          ),
          CustomCheckboxWidget(
            productController: productController,
            title: 'Most Popular',
            name: 'isPopular',
            controllerValue: productController.isPopular,
          ),
          CustomCheckboxWidget(
            productController: productController,
            title: 'Top Rated',
            name: 'isTopRated',
            controllerValue: productController.isTopRated,
          ),
          CustomCheckboxWidget(
            productController: productController,
            title: "Today's Special",
            name: 'isTodaySpecial',
            controllerValue: productController.isTodaySpecial,
          ),
        ],
      ),
    );
  }
}
