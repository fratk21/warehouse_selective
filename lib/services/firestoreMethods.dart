// ignore: camel_case_types

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
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

  Future<String?> productdelete(String productUid) async {
    try {
      await _firestore
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productUid)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> presdelete(
      String productUid, String modulessid, String prescriptionsid) async {
    try {
      await _firestore
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productUid)
          .collection("modules")
          .doc(modulessid)
          .collection("prescriptions")
          .doc(prescriptionsid)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> materialdelete(snap) async {
    try {
      materialModel.material materials1 = materialModel.material(
          materialid: snap["materialid"].toString(),
          productid: snap["productid"].toString(),
          prescriptionsid: snap["prescriptionsid"].toString(),
          modulesid: snap["modulesid"].toString(),
          materialname: snap["materialname"].toString(),
          west: snap["west"].toString(),
          unit: snap["unit"].toString(),
          price: snap["price"],
          priceType: snap["priceType"],
          suppliers: snap["suppliers"],
          total: double.parse(snap["total"].toString()),
          max: snap["max"],
          min: snap["min"]);
      await _firestore
          .collection("products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(snap["productid"])
          .collection("modules")
          .doc(snap["modulesid"])
          .collection("prescriptions")
          .doc(snap["prescriptionsid"])
          .update({
        "material": FieldValue.arrayRemove([materials1.toJson()])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String?> moduledelete(String productUid, String modulessid) async {
    try {
      await _firestore
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(productUid)
          .collection("modules")
          .doc(modulessid)
          .delete();
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

  Future<String?> productupdate_modules(
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
            .update(module.toJson());
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
            .update(module.toJson());
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

  Future<String?> productupdate_prescriptions(
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
    double total,
    double max,
    double min,
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
          suppliers: suppliers,
          total: total,
          max: max,
          min: min);
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
      addsystemMaterial(materials, materialname);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> addsystemMaterial(
      materialModel.material material, String materialname) async {
    String materialid = const Uuid().v1();
    var searchmaterial = await _firestore
        .collection("products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("material")
        .where("materialname", isEqualTo: materialname)
        .snapshots();
    if (await searchmaterial.isEmpty) {
    } else {
      await _firestore
          .collection("products")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("material")
          .doc(materialid)
          .set(material.toJson());
    }
  }

  Future<String?> prescriptionsupdate_material(
    snap,
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
    double totals,
    int index,
    double max,
    double min,
  ) async {
    materialModel.material materials1 = materialModel.material(
        materialid: snap["materialid"].toString(),
        productid: snap["productid"].toString(),
        prescriptionsid: snap["prescriptionsid"].toString(),
        modulesid: snap["modulesid"].toString(),
        materialname: snap["materialname"].toString(),
        west: snap["west"].toString(),
        unit: snap["unit"].toString(),
        price: snap["price"],
        priceType: snap["priceType"],
        suppliers: snap["suppliers"],
        total: double.parse(snap["total"].toString()),
        max: max,
        min: min);
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
      "material": FieldValue.arrayRemove([materials1.toJson()])
    });
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
        suppliers: suppliers,
        total: totals,
        max: max,
        min: min);
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
  }

  Future<String?> thema(bool tema) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"thema": tema});
  }
}
