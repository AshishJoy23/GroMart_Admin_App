import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadProductImage(XFile image) async {
    try {
      await storage
          .ref('product_images/${image.name}')
          .putFile(File(image.path));
      log('image uploaded successfully');
    } catch (e) {
      log('Error while uploading product image: $e');
    }
  }

  Future<String> getProductImageURL(String imageName) async {
    try {
      String downloadURL =
          await storage.ref('product_images/$imageName').getDownloadURL();
      log('image gets successfully');
      return downloadURL;
    } catch (e) {
      log('Error while getting product image: $e');
    }
    return '';
  }

  Future<void> deleteProductImage(String imageUrl) async {
    try {
      final Uri uri = Uri.parse(imageUrl);
      final String imageName = uri.pathSegments.last;
      await storage.ref(imageName).delete();
      log('image deleted successfully');
    } catch (e) {
      log('Error while deleting product image: $e');
    }
  }

  Future<void> uploadCategoryImage(XFile image) async {
    try {
      await storage
          .ref('category_images/${image.name}')
          .putFile(File(image.path));
      log('image uploaded successfully');
    } catch (e) {
      log('Error while uploading product image: $e');
    }
  }

  Future<String> getCategoryImageURL(String imageName) async {
    try {
      String downloadURL =
          await storage.ref('category_images/$imageName').getDownloadURL();
      log('image gets successfully');
      return downloadURL;
    } catch (e) {
      log('Error while getting product image: $e');
    }
    return '';
  }

  Future<void> deleteCategoryImage(String imageUrl) async {
    try {
      final Uri uri = Uri.parse(imageUrl);
      final String imageName = uri.pathSegments.last;
      await storage.ref(imageName).delete();
      log('image deleted successfully');
    } catch (e) {
      log('Error while deleting product image: $e');
    }
  }

  Future<void> uploadBannerImage(XFile image) async {
    try {
      await storage
          .ref('banner_images/${image.name}')
          .putFile(File(image.path));
      log('image uploaded successfully');
    } catch (e) {
      log('Error while uploading product image: $e');
    }
  }

  Future<String> getBannerImageURL(String imageName) async {
    try {
      String downloadURL =
          await storage.ref('banner_images/$imageName').getDownloadURL();
      log('image gets successfully');
      return downloadURL;
    } catch (e) {
      log('Error while getting product image: $e');
    }
    return '';
  }

  Future<void> deleteBannerImage(String imageUrl) async {
    try {
      final Uri uri = Uri.parse(imageUrl);
      final String imageName = uri.pathSegments.last;
      await storage.ref(imageName).delete();
      log('image deleted successfully');
    } catch (e) {
      log('Error while deleting product image: $e');
    }
  }
}
