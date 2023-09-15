import 'package:flutter/material.dart';
import 'package:gromart_admin_app/controllers/banner_controller.dart';
import 'package:gromart_admin_app/services/services.dart';
import '../../models/models.dart';

class CarouselCardWidget extends StatelessWidget {
  final String title;
  final BannerModel banner;
  final VoidCallback onPressed;
  final BannerController bannerController;
  final StorageService storage;
  final DatabaseServices database;
  const CarouselCardWidget({
    super.key,
    required this.banner,
    required this.bannerController,
    required this.storage,
    required this.title,
    required this.onPressed,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 12.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(
              banner.imageUrl,
              fit: BoxFit.fill,
              width: 1000.0,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff388E3C),
                    backgroundColor: Colors.white,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: SizedBox(
                height: size.height * 0.26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      onPressed: () async {
                        // Delete the image from storage and remove it from the list
                        await storage.deleteBannerImage(banner.imageUrl);
                        await database.deleteBanner(banner.id);
                      },
                      backgroundColor: Colors.black87,
                      child: const Icon(
                        Icons.delete_forever,
                        size: 24,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: onPressed,
                      backgroundColor: Colors.black87,
                      child: const Icon(
                        Icons.add_photo_alternate,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
