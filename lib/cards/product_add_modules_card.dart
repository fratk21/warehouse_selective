import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';
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
      color: Theme.of(context).cardColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
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
                child: snap["modulesimage"] == ""
                    ? Icon(
                        Icons.document_scanner_rounded,
                        color: Theme.of(context).iconTheme.color,
                        size: 50,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48),
                          child: Image(
                              image: NetworkImage(snap["modulesimage"]),
                              fit: BoxFit.cover),
                        ),
                      ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      width: width(context) - 140,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 8),
                          child: Text(
                            snap["modulesname"],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 250,
                        child: Text(
                          snap["modulesdes"] == ""
                              ? "Açıklama Girilmemiş"
                              : snap["modulesdes"],
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                ],
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
          Center(
            child: Icon(
              Icons.linear_scale_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
          ),
          ListTile(
              title: TextButton.icon(
                  icon: Icon(
                    Icons.create_new_folder,
                    color: Theme.of(context).iconTheme.color,
                  ),
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
                    child: Text(
                      "Reçete Oluştur",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ))),
          ListTile(
              title: TextButton.icon(
                  icon: Icon(
                    Icons.edit_document,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  label: Center(
                    child: Text(
                      "Reçete Oluştur",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ))),
        ],
      );
    },
  );
}
