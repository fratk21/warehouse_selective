import 'package:cloud_firestore/cloud_firestore.dart';

class material {
  final String materialid;
  final String materialname;
  final String west;
  final String unit;
  final String price;
  final String priceType;

  const material({
    required this.materialid,
    required this.materialname,
    required this.west,
    required this.unit,
    required this.price,
    required this.priceType,
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
    );
  }

  Map<String, dynamic> toJson() => {
        "materialid": materialid,
        "materialname": materialname,
        "west": west,
        "unit": unit,
        "price": price,
        "priceType": priceType
      };
}
