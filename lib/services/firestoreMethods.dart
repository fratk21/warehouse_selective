// ignore: camel_case_types

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:warehouse_selective/models/material.dart' as materialModel;
import 'package:warehouse_selective/models/prescriptions.dart'
    as prescriptionsModel;
import 'package:warehouse_selective/services/storage_methods.dart';

import '../models/product.dart' as productModel;
import '../models/modules.dart' as modulesModel;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

class firestoreservices {
  Future<String?> productCreate(String productUid, Uint8List? file,
      String productname, String productdes) async {
    try {
      if (file == null) {
        print("object");
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: "",
            modules: [],
            price: "",
            priceType: "",
            productdes: productdes);
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
            modules: [],
            price: "",
            priceType: "",
            productdes: productdes);
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

  Future<String?> productupdate(String productUid, Uint8List? file,
      String productname, String productdes) async {
    try {
      if (file == null) {
        print("object");
        productModel.product products = productModel.product(
            productid: productUid,
            productname: productname,
            productimage: "",
            modules: [],
            price: "",
            priceType: "",
            productdes: productdes);
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
            modules: [],
            price: "",
            priceType: "",
            productdes: productdes);
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

  Future<String?> productAdd_modules(
      String modulessid,
      String modulesname,
      String productUid,
      List prescriptions,
      Uint8List? file,
      String modulesdes) async {
    try {
      if (file == null) {
        modulesModel.modules module = modulesModel.modules(
            modulesid: modulessid,
            modulesname: modulesname,
            modulesdes: modulesdes,
            modulesimage: "",
            prescription: prescriptions,
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .collection("modules")
            .doc(modulessid)
            .set(module.toJson());
      } else {
        String photoUrl =
            await StorageMethods().uploadImageToStorage('product', file, false);
        modulesModel.modules module = modulesModel.modules(
            modulesid: modulessid,
            modulesname: modulesname,
            modulesimage: photoUrl,
            modulesdes: modulesdes,
            prescription: prescriptions,
            price: "",
            priceType: "");
        await _firestore
            .collection("products")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(productUid)
            .collection("modules")
            .doc(modulessid)
            .set(module.toJson());
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
      String prescriptionsdes,
      String moduleid) async {
    try {
      prescriptionsModel.prescriptions prescriptions =
          prescriptionsModel.prescriptions(
              prescriptionsid: prescriptionsid,
              prescriptionsname: prescriptionsname,
              productid: productUid,
              material: material,
              prescriptionsdes: prescriptionsdes,
              moduleid: moduleid);
      await _firestore
          .collection("products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productUid)
          .collection("modules")
          .doc(moduleid)
          .collection("prescriptions")
          .doc(prescriptionsid)
          .set(prescriptions.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<String?> prescriptionsAdd_material(
    String materialid,
    String productid,
    String prescriptionsid,
    String modulsid,
    String materialname,
    String west,
    String unit,
    List price,
    List priceType,
    List suppliers,
  ) async {
    try {
      materialModel.material materials = materialModel.material(
          materialid: materialid,
          productid: productid,
          prescriptionsid: prescriptionsid,
          modulesid: modulsid,
          materialname: materialname,
          west: west,
          unit: unit,
          price: price,
          priceType: priceType,
          suppliers: suppliers);
      await _firestore
          .collection("products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productid)
          .collection("modules")
          .doc(modulsid)
          .collection("prescriptions")
          .doc(prescriptionsid)
          .update({
        "material": FieldValue.arrayUnion([materials.toJson()])
      });
    } catch (e) {
      print(e);
    }
  }
}
