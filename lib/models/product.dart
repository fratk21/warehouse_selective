import 'package:cloud_firestore/cloud_firestore.dart';

class product {
  final String productid;
  final String productname;
  final String productdes;
  final String? productimage;
  final String price;
  final String priceType;
  final List? modules;

  const product({
    required this.productid,
    required this.productname,
    required this.productimage,
    required this.modules,
    required this.price,
    required this.priceType,
    required this.productdes,
  });

  static product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return product(
        productid: snapshot["productid"],
        productname: snapshot["productname"],
        productimage: snapshot["productimage"],
        modules: snapshot["modules"],
        price: snapshot["price"],
        productdes: snapshot["productdes"],
        priceType: snapshot["priceType"]);
  }

  Map<String, dynamic> toJson() => {
        "productid": productid,
        "productname": productname,
        "productimage": productimage,
        "modules": modules,
        "price": price,
        "priceType": priceType,
        "productdes": productdes
      };
}
