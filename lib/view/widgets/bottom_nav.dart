import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/view/screens/category/category_screen.dart';
import 'package:gromart_admin_app/view/screens/home/home_screen.dart';
import 'package:gromart_admin_app/view/screens/profile/profile_screen.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.transparent,
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Get.to(()=>HomeScreen());
                //Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.home,size: 26,),
            ),
            IconButton(
              onPressed: () {
                Get.to(()=> CategoryScreen());
                //Navigator.pushNamed(context, '/category');
              },
              icon: const Icon(Icons.category,size: 26,),
            ),
            IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/wishlist');
              },
              icon: const Icon(Icons.track_changes,size: 26,),
            ),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/notification');
            //   },
            //   icon: const Icon(Icons.notifications,size: 26,),
            // ),
            IconButton(
              onPressed: () {
                Get.to(()=>const ProfileScreen());
                //Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person,size: 26,),
            ),
          ],
        ),
      ),
    );
  }
}
