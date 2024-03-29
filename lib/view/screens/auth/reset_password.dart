import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../config/config.dart';
import '../../widgets/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
        appBar: CustomAppBarWidget(
          title: 'Reset Password',
          actionList: [],
          leadingOnPressed: () {
            Get.back();
          },
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to reset\nyour password.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Enter Email..',
                    labelText: 'Email',
                    floatingLabelStyle: TextStyle(
                      color: Color(0xff388E3C),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff388E3C),
                      ),
                    ),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.black54,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) {
                    return email != '' ? null : 'Email required!!';
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff388E3C),
                            minimumSize: const Size.fromHeight(55)),
                        onPressed: () async {
                          //log('choose from camera');
                          FocusManager.instance.primaryFocus?.unfocus();
                          resetPassword();
                          //await signIn(context);
                        },
                        child: Text(
                          'Reset Password',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xff388E3C),
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Utils.showSnackBar(
        'Password Reset Email Sent',Colors.green,
      );
      navigatorKey.currentState!.pushNamed('/getStarted');
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      Utils.showSnackBar(
        e.message!,Colors.red
      );
      Navigator.of(context).pop();
    }
  }
}
