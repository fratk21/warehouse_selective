import 'package:cloud_firestore/cloud_firestore.dart';

class material {
  final String materialid;
  final String productid;
  final String prescriptionsid;
  final String modulesid;
  final String materialname;
  final String west;
  final String unit;
  List? price;
  List? priceType;
  List? suppliers;
  double total;

  material({
    required this.materialid,
    required this.productid,
    required this.prescriptionsid,
    required this.modulesid,
    required this.materialname,
    required this.west,
    required this.unit,
    required this.price,
    required this.priceType,
    required this.suppliers,
    required this.total,
  });

  static material fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return material(
        materialid: snapshot["materialid"],
        materialname: snapshot["materialname"],
        west: snapshot["west"],
        unit: snapshot["unit"],
        price: snapshot["price"],
        priceType: snapshot["priceType"],
        productid: snapshot["productid"],
        prescriptionsid: snapshot["prescriptionsid"],
        modulesid: snapshot["modulesid"],
        suppliers: snapshot["suppliers"],
        total: snapshot["total"]);
  }

  Map<String, dynamic> toJson() => {
        "materialid": materialid,
        "materialname": materialname,
        "west": west,
        "unit": unit,
        "price": price,
        "priceType": priceType,
        "prescriptionsid": prescriptionsid,
        "productid": productid,
        "modulesid": modulesid,
        "suppliers": suppliers,
        "total": total
      };
}
