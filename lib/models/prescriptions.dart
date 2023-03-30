import 'package:cloud_firestore/cloud_firestore.dart';

class prescriptions {
  final String prescriptionsid;
  final String prescriptionsname;
  final String prescriptionsdes;
  final String productid;
  final List? material;

  const prescriptions({
    required this.prescriptionsid,
    required this.prescriptionsname,
    required this.productid,
    required this.material,
    required this.prescriptionsdes,
  });

  static prescriptions fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return prescriptions(
      prescriptionsid: snapshot["prescriptionsid"],
      prescriptionsname: snapshot["prescriptionsname"],
      productid: snapshot["productid"],
      material: snapshot["material"],
      prescriptionsdes: snapshot["prescriptionsdes"],
    );
  }

  Map<String, dynamic> toJson() => {
        "prescriptionsid": prescriptionsid,
        "prescriptionsname": prescriptionsname,
        "productid": productid,
        "material": material,
        "prescriptionsdes": prescriptionsdes,
      };
}
