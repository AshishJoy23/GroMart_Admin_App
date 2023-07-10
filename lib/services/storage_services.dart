import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadProductImage(XFile image) async {
    await storage.ref('product_images/${image.name}').putFile(File(image.path));
  }

  Future<String> getProductImageURL(String imageName) async {
    String downloadURL = await storage.ref('product_images/$imageName').getDownloadURL();
    return downloadURL;
  }

  Future<void> uploadCategoryImage(XFile image) async {
    await storage.ref('category_images/${image.name}').putFile(File(image.path));
  }

  Future<String> getCategoryImageURL(String imageName) async {
    String downloadURL = await storage.ref('category_images/$imageName').getDownloadURL();
    return downloadURL;
  }
}
