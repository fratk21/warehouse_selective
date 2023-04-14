import 'package:flutter/material.dart';
import 'package:warehouse_selective/screens/add_products/add_prescription.dart';

Widget modules_card_product_add_screen(
  BuildContext context,
  snap,
  String productname,
  String productid,
) {
  return InkWell(
    onTap: () {
      cards_options(context, productid, snap["modulesid"], snap["modulesname"],
          productname);
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                  child: snap["modulesimage"] == ""
                      ? Icon(Icons.document_scanner_sharp)
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Image(
                              image: NetworkImage(snap["modulesimage"]),
                              fit: BoxFit.scaleDown),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      width: 250,
                      height: 30,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 5,
                        child: Center(child: Text(snap["modulesname"])),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                        child: Center(
                            child: Text(snap["modulesdes"] == ""
                                ? "Açıklama Girilmemiş"
                                : snap["modulesdes"])),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          //      Padding(
          //        padding: const EdgeInsets.all(2.0),
          //        child: Container(
          //          decoration: BoxDecoration(
          //            borderRadius: BorderRadius.all(Radius.circular(12)),
          //          ),
          //          height: 70,
          //           width: MediaQuery.of(context).size.width,
          //           child: Card(
          //            shape: RoundedRectangleBorder(
          //              borderRadius: BorderRadius.circular(12.0),
          //            ),
          //            elevation: 5,
          //            child: Column(
          //              children: [
          //                Center(
          //                    child: Text("Price"),
          //                  ),
          //                  Row(
          //                    children: [
          //                      Column(
          //                       children: [Text("TL"), Text("data")],
          //                    )
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
        ],
      ),
    ),
  );
}

Future cards_options(
  BuildContext context,
  String productid,
  String moduleid,
  String modulesname,
  String productname,
) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          const Center(
            child: Icon(
              Icons.linear_scale_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
          ListTile(
              title: TextButton.icon(
                  icon: Icon(Icons.create_new_folder),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => add_prescription_screen(
                              modulesid: moduleid,
                              modulesname: modulesname,
                              productid: productid,
                              productname: productname),
                        ));
                  },
                  label: Center(
                    child: Text("Reçete Oluştur"),
                  ))),
        ],
      );
    },
  );
}
