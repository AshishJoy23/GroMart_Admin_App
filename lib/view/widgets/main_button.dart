import 'dart:developer';

import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  final String buttonText;
  final double heightFactor;
  const MainButtonWidget({
    super.key,
    required this.buttonText,
    this.heightFactor = 0.07,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: size.height * heightFactor,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Color(0xff388E3C),
                  ),
                ),
                onPressed: () {
                  log('choose from camera');
                },
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}