import 'package:cloud_firestore/cloud_firestore.dart';

class product {
  final String productid;
  final String productname;
  final String? productimage;
  final String price;
  final String priceType;
  final List? prescriptions;

  const product({
    required this.productid,
    required this.productname,
    required this.productimage,
    required this.prescriptions,
    required this.price,
    required this.priceType,
  });

  static product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return product(
        productid: snapshot["productid"],
        productname: snapshot["productname"],
        productimage: snapshot["productimage"],
        prescriptions: snapshot["prescriptions"],
        price: snapshot["price"],
        priceType: snapshot["priceType"]);
  }

  Map<String, dynamic> toJson() => {
        "productid": productid,
        "productname": productname,
        "productimage": productimage,
        "prescriptions": prescriptions,
        "price": price,
        "priceType": priceType
      };
}
