import 'package:cloud_firestore/cloud_firestore.dart';

class modules {
  final String modulesid;
  final String modulesname;
  final String? modulesimage;
  final String modulesdes;
  final String price;
  final String priceType;
  final List? prescription;

  const modules({
    required this.modulesid,
    required this.modulesname,
    required this.modulesimage,
    required this.modulesdes,
    required this.prescription,
    required this.price,
    required this.priceType,
  });

  static modules fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return modules(
        modulesid: snapshot["modulesid"],
        modulesname: snapshot["modulesname"],
        modulesimage: snapshot["modulesimage"],
        modulesdes: snapshot["modulesdes"],
        prescription: snapshot["prescription"],
        price: snapshot["price"],
        priceType: snapshot["priceType"]);
  }

  Map<String, dynamic> toJson() => {
        "modulesid": modulesid,
        "modulesname": modulesname,
        "modulesimage": modulesimage,
        "modulesdes": modulesdes,
        "prescription": prescription,
        "price": price,
        "priceType": priceType
      };
}
