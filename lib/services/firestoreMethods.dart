// ignore: camel_case_types
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:warehouse_selective/models/prescriptions.dart'
    as prescriptionsModel;
import 'package:warehouse_selective/services/storage_methods.dart';

import '../models/product.dart' as productModel;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

class firestoreservices {
  Future<String?> productCreate(
      String productUid, Uint8List? file, String productname) async {
    try {
      if (file == null) {
        print("object");
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: "",
            prescriptions: [],
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .set(products.toJson());
      } else {
        String photoUrl =
            await StorageMethods().uploadImageToStorage('product', file, false);
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: photoUrl,
            prescriptions: [],
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .set(products.toJson());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> productupdate(
      String productUid, Uint8List? file, String productname) async {
    try {
      if (file == null) {
        print("object");
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: "",
            prescriptions: [],
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .update(products.toJson());
      } else {
        String photoUrl =
            await StorageMethods().uploadImageToStorage('product', file, false);
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: photoUrl,
            prescriptions: [],
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .update(products.toJson());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> productAdd_prescriptions(
      String prescriptionsid,
      String prescriptionsname,
      String productUid,
      List material,
      String prescriptionsdes) async {
    try {
      prescriptionsModel.prescriptions prescriptions =
          prescriptionsModel.prescriptions(
              prescriptionsid: prescriptionsid,
              prescriptionsname: prescriptionsname,
              productid: productUid,
              material: material,
              prescriptionsdes: prescriptionsdes);
      List<prescriptionsModel.prescriptions> prescription = [];
      prescription.add(prescriptions);
      await _firestore
          .collection("products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productUid)
          .update({
        "prescriptions": FieldValue.arrayUnion([prescriptions.toJson()])
      });
    } catch (e) {
      print(e);
    }
  }
}
