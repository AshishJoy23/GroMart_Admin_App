import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controllers.dart';

class CustomDropDownWidget extends StatelessWidget {
  CustomDropDownWidget({
    super.key,
    required this.productController,
  });

  final ProductController productController;
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
        iconSize: 30,
        iconEnabledColor: Colors.black,
        dropdownColor: const Color(0xffC8E6C9),
        decoration: const InputDecoration(
          hintText: 'Enter category name',
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.category_outlined),
          prefixIconColor: Colors.black54,
        ),
        items: categoryController.categories.map((category) {
          return DropdownMenuItem(
              value: category.name,
              child: Text(
                category.name,
              ));
        }).toList(),
        onChanged: (value) {
          productController.newProduct.update(
            'category',
            (_) => value,
            ifAbsent: () => value,
          );
        },
      ),
    );
  }
}
