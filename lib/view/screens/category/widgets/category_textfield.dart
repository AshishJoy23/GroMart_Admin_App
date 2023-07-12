import 'package:flutter/material.dart';
import 'package:gromart_admin_app/controllers/controllers.dart';

class CategoryTextFormField extends StatelessWidget {
  final CategoryController categoryController;
  const CategoryTextFormField({
    super.key,
    required this.categoryController,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        //keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          hintText: 'Enter category name',
          hintStyle: TextStyle(color: Colors.black54,fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff388E3C),
            ),
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.category_outlined),
          prefixIconColor: Colors.black54,
        ),
        onChanged: (value) {
          categoryController.newProduct.update(
            'name',
            (_) => value,
            ifAbsent: () => value,
          );
        },
      ),
    );
  }
}
