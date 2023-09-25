import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_admin_app/models/models.dart';

class DatabaseServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProducts() {
    return firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addProduct(ProductModel product) {
    return firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(ProductModel product) async {
    log('<<<<<<<<<<updated>>>>>>>>>>');
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get();
    log(querySnapshot.toString());
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      log(documentSnapshot.toString());
      String documentId = documentSnapshot.id;
      log(documentId);
      try {
        await firebaseFirestore.collection('products').doc(documentId).set(
              product.toMap(),
              SetOptions(merge: true),
            );
        log('Product updated successfully.');
      } catch (error) {
        log('Error updating product: $error');
      }
    } else {
      log('No matching document found.');
    }
  }

  Future<void> deleteProduct(int productId) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: productId)
        .get();
    log(querySnapshot.toString());
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      log(documentSnapshot.toString());
      String documentId = documentSnapshot.id;
      log(documentId);
      try {
        await firebaseFirestore.collection('products').doc(documentId).delete();
        log('Product deleted successfully.');
      } catch (error) {
        log('Error deleting product: $error');
      }
    } else {
      log('No matching document found.');
    }
  }

//for categories
  Stream<List<CategoryModel>> getCategories() {
    return firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    });
  }

  Future<void> addCategory(CategoryModel category) {
    return firebaseFirestore.collection('categories').add(category.toMap());
  }

  Future<void> updateCategory(CategoryModel category) async {
    log('<<<<<<<<<<updated>>>>>>>>>>');
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('categories')
        .where('id', isEqualTo: category.id)
        .get();
    log(querySnapshot.toString());
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      log(documentSnapshot.toString());
      String documentId = documentSnapshot.id;
      log(documentId);
      try {
        await firebaseFirestore.collection('categories').doc(documentId).set(
              category.toMap(),
              SetOptions(merge: true),
            );
        log('Category updated successfully.');
      } catch (error) {
        log('Error updating category: $error');
      }
    } else {
      log('No matching document found.');
    }
  }

  Future<void> deleteCategory(int productId) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('categories')
        .where('id', isEqualTo: productId)
        .get();
    log(querySnapshot.toString());
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      log(documentSnapshot.toString());
      String documentId = documentSnapshot.id;
      log(documentId);
      try {
        await firebaseFirestore
            .collection('categories')
            .doc(documentId)
            .delete();
        log('Category deleted successfully.');
      } catch (error) {
        log('Error deleting category: $error');
      }
    } else {
      log('No matching document found.');
    }
  }

  //for banners
  Stream<List<BannerModel>> getBanners() {
    return firebaseFirestore.collection('banners').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addBanner(BannerModel banner) {
    return firebaseFirestore.collection('banners').add(banner.toMap());
  }

  Future<void> deleteBanner(int productId) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('banners')
        .where('id', isEqualTo: productId)
        .get();
    log(querySnapshot.toString());
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      log(documentSnapshot.toString());
      String documentId = documentSnapshot.id;
      log(documentId);
      try {
        await firebaseFirestore.collection('banners').doc(documentId).delete();
        log('Banner deleted successfully.');
      } catch (error) {
        log('Error deleting banner: $error');
      }
    } else {
      log('No matching document found.');
    }
  }

  //for orders

  Stream<List<OrderModel>> getAllOrders() {
    log('<<<<<<<<<getting orders>>>>>>>>>');
    return FirebaseFirestore.instance
        .collectionGroup('orders')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> subDocData = doc.data();
        log(subDocData.toString());
        return OrderModel.fromSnapshot(subDocData);
      }).toList();
    });
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(order.email)
          .collection('orders')
          .doc(order.id)
          .set(
            order.toMap(),
            SetOptions(merge: true),
          );
      log('Order updated successfully.');
    } catch (error) {
      log('Error updating order: $error');
    }
  }
}
