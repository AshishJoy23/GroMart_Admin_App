import 'dart:developer';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
        backgroundColor: Colors.transparent,
        appBar: const MainAppBarWidget(
          title: 'Profile',
        ),
        body: ListView(
          children: [
            const ProfilePhotoWidget(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abcdefg Hijkl',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SectionTitleWidget(title: 'PERSONAL DETAILS'),
            CustomTextFormField(
              textController: nameController,
              hintText: 'Enter your Name..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.person,
            ),
            CustomTextFormField(
              textController: emailController,
              hintText: 'Enter your Email..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.email,
            ),
            CustomTextFormField(
              textController: phoneController,
              hintText: 'Enter your Phone..',
              labelText: 'Abcdefg Hijkl',
              iconData: Icons.phone,
            ),
            MainButtonWidget(
              buttonText: 'Save Changes',
              onPressed: (){},
            ),
          ],
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
