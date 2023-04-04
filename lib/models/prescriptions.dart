import 'package:cloud_firestore/cloud_firestore.dart';

class prescriptions {
  final String prescriptionsid;
  final String prescriptionsname;
  final String prescriptionsdes;
  final String productid;
  final String moduleid;

  final List? material;

  const prescriptions({
    required this.prescriptionsid,
    required this.prescriptionsname,
    required this.productid,
    required this.material,
    required this.prescriptionsdes,
    required this.moduleid,
  });

  static prescriptions fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return prescriptions(
      prescriptionsid: snapshot["prescriptionsid"],
      prescriptionsname: snapshot["prescriptionsname"],
      productid: snapshot["productid"],
      material: snapshot["material"],
      prescriptionsdes: snapshot["prescriptionsdes"],
      moduleid: snapshot["moduleid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "prescriptionsid": prescriptionsid,
        "prescriptionsname": prescriptionsname,
        "productid": productid,
        "material": material,
        "prescriptionsdes": prescriptionsdes,
        "moduleid": moduleid
      };
}
