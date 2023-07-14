import 'package:flutter/material.dart';

class AddImageButtonWidget extends StatelessWidget {
  final VoidCallback onTapFunction;
  const AddImageButtonWidget({
    super.key,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        color: Colors.black,
        height: size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const Icon(
                Icons.add_circle,
                color: Colors.white,
                size: 36,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Choose an image',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}