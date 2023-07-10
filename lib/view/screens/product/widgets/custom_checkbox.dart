import 'package:flutter/material.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final ProductController productController;
  final String title;
  final String name;
  final bool? controllerValue;
  const CustomCheckboxWidget({
    super.key,
    required this.title,
    required this.productController,
    required this.name,
    required this.controllerValue,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.5,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Checkbox(
            value: (controllerValue == null) ? false : controllerValue,
            checkColor: Colors.black,
            activeColor: const Color(0xff388E3C).withAlpha(150),
            side: const BorderSide(color: Colors.black),
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ],
      ),
    );
  }
}
