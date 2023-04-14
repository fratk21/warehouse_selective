// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List> material_finance(
    String productid, String modulesid, String presid) async {
  List a = [];
  var control;
  try {
    control = await FirebaseFirestore.instance
        .collection('products')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("product")
        .doc(productid)
        .collection("modules")
        .doc(modulesid)
        .collection("prescriptions")
        .doc(presid)
        .get();
  } catch (e) {}
  return control.data()!["material"];
}
