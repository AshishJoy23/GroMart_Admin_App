import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/models.dart';

class MainAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool isOrder;
  final double heightFactor;
  const MainAppBarWidget({
    super.key,
    required this.title,
    this.scaffoldKey,
    this.isOrder = false,
    this.heightFactor = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4CAF50),
              Color(0xff4CAF50),Color(0xff4CAF50),Color(0xff4CAF50),Color(0xff4CAF50),
              Color.fromARGB(255, 123, 210, 126),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            scaffoldKey!.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        bottom: (isOrder)
            ? TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: Theme.of(context).textTheme.titleLarge,
                unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
                indicator: const BoxDecoration(
                  color: Color(0xff388E3C),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                indicatorWeight: 1.0,
                tabs: const [
                  Tab(
                    text: "Pending",
                  ),
                  Tab(
                    text: "Active",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              )
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(heightFactor);
}
