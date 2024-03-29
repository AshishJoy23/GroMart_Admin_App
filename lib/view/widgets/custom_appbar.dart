import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> actionList;
  final VoidCallback leadingOnPressed;
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.actionList,
    required this.leadingOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: leadingOnPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 26,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: actionList,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
