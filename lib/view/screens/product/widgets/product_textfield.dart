import 'package:flutter/material.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';

import '../../../../services/services.dart';

class ProductTextFormField extends StatelessWidget {
  final ProductController productController;
  final String name;
  final String hintText;
  final IconData iconData;
  final bool type;
  final bool isMoreLines;
  const ProductTextFormField({
    super.key,
    required this.hintText,
    required this.iconData,
    this.type = false,
    required this.productController,
    required this.name,
    this.isMoreLines=false,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: TextInputAction.next,
        keyboardType: type
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        cursorColor: Colors.black,
        maxLines: isMoreLines?5:1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54,fontSize: 14),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: Icon(iconData),
          prefixIconColor: Colors.black54,
        ),
        onChanged: (value) {
          productController.newProduct.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        },
      ),
    );
  }
}
