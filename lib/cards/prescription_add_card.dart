import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/screens/add_products/add_material.dart';
import 'package:warehouse_selective/screens/add_products/add_material_screen.dart';
import 'package:warehouse_selective/utils/utils.dart';

import '../services/finance.dart';
import '../services/firestoreMethods.dart';
import '../services/material_finance.dart';
import '../widgets/combo.dart';
import '../widgets/inputText.dart';

class prescription_add_card extends StatefulWidget {
  final snap;
  const prescription_add_card({super.key, required this.snap});

  @override
  State<prescription_add_card> createState() => _prescription_add_cardState();
}

class _prescription_add_cardState extends State<prescription_add_card> {
  String selectedValue = "Kg";
  String selectedValueprice1 = "TL";
  String selectedValueprice2 = "TL";
  String selectedValueprice3 = "TL";

  TextEditingController materialname = TextEditingController();
  TextEditingController tedarik1 = TextEditingController();
  TextEditingController tedarik2 = TextEditingController();
  TextEditingController tedarik3 = TextEditingController();
  TextEditingController tedarik1price = TextEditingController();
  TextEditingController tedarik2price = TextEditingController();
  TextEditingController tedarik3price = TextEditingController();
  TextEditingController tedarik1ype = TextEditingController();
  TextEditingController tedarik2type = TextEditingController();
  TextEditingController tedarik3type = TextEditingController();

  TextEditingController waste = TextEditingController();

  Uint8List? _image;
  selectImage(int a, int b) async {
    Uint8List? im;
    try {
      if (b == 1) {
        if (a == 1) {
          im = await pickImage(ImageSource.gallery);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        } else {
          im = await pickImage(ImageSource.camera);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        }
        setState(() {
          _image = im;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future imagesecenek(
    int a,
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
                tileColor: Color.fromARGB(255, 220, 219, 219),
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);

                      await selectImage(2, 1);
                    },
                    child: Center(
                      child: Text("fotograf çek"),
                    ))),
            ListTile(
                title: TextButton(
                    onPressed: () async {
                      print(a);
                      Navigator.pop(context);

                      await selectImage(1, 1);
                    },
                    child: Center(
                      child: Text("galeriden yükle"),
                    ))),
          ],
        );
      },
    );
  }

  TextEditingController prescriptionsname = TextEditingController();
  TextEditingController prescriptiondes = TextEditingController();

  Future RecetePopup(snap) {
    prescriptionsname.text = snap["prescriptionsname"];
    prescriptiondes.text = snap["prescriptionsdes"];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.zero,
            content: Stack(
              children: <Widget>[
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Container(
                            height: 60,
                            width: width(context),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.discount_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextField(
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  maxLines: 2,
                                  controller: prescriptionsname,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Reçete Adı",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Container(
                            height: 100,
                            width: width(context),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.dashboard_customize_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextField(
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  maxLines: 3,
                                  controller: prescriptiondes,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Reçete Açıklaması",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 10, bottom: 10),
                        child: Container(
                          width: width(context),
                          child: ElevatedButton(

                              // ignore: prefer_const_constructors
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                if (prescriptionsname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen Reçete Adı giriniz",
                                      AnimatedSnackBarType.error);
                                } else {
                                  await firestoreservices()
                                      .productupdate_prescriptions(
                                          snap["prescriptionsid"],
                                          prescriptionsname.text,
                                          snap["productid"],
                                          [],
                                          prescriptiondes.text,
                                          snap["moduleid"]);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Reçete Güncelleştir")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future secenek(snap) {
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
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => add_material_per_screen(
                              snap: snap,
                              index: 9274824373436,
                            ),
                          ));
                    },
                    child: Center(
                      child: Text(
                        "Malzeme Ekle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
            ListTile(
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      RecetePopup(snap);
                    },
                    child: Center(
                      child: Text(
                        "Reçete Düzenle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
            ListTile(
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      firestoreservices().presdelete(snap["productid"],
                          snap["moduleid"], snap["prescriptionsid"]);
                    },
                    child: Center(
                      child: Text(
                        "Reçete Sil",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        secenek(widget.snap);
      },
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(0)),
                ),
                child: Center(
                    child: Text(
                  widget.snap["prescriptionsname"],
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
              ),
              Container(
                height: 50,
                child: Center(
                    child: Text(
                  widget.snap["prescriptionsdes"] == ""
                      ? "Açıklama Girilmemiş"
                      : widget.snap["prescriptionsdes"],
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
              ),
              Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Malzeme Sayısı",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        widget.snap["material"].length.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => add_material_screen(
                                    snap: widget.snap,
                                    moduleid: widget.snap["moduleid"],
                                    presid: widget.snap["prescriptionsid"],
                                    productid: widget.snap["productid"],
                                    itemcount: widget.snap["material"].length,
                                    presname: widget.snap["prescriptionsname"],
                                  ),
                                ));
                          },
                          icon: Icon(
                            Icons.account_tree,
                            color: Theme.of(context).iconTheme.color,
                          ))
                    ],
                  ),
                ),
              ),
              //  Container(
              //    height: 40,
              //    child: Card(
              //         elevation: 5,
              //         child: Center(child: Text("Reçete Fiyatı"))),
              //   ),
              //  Row(
              //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //    children: [
              //      Container(
              //        width: 80,
              //        child: Card(
              //          elevation: 5,
              //          child: Column(
              //            children: [
              //              Text("TL"),
              //              SizedBox(
              //                height: 4,
              //              ),
              //              Text("${a[0]}"),
              //            ],
              //          ),
              //        ),
              //      ),
              //      Container(
              //        width: 80,
              //        child: Card(
              //         elevation: 5,
              //          child: Column(
              //            children: [
              //              Text("USD"),
              //              SizedBox(
              //                height: 4,
              //              ),
              //              Text("345"),
              //            ],
              //          ),
              //        ),
              //     ),
              //     Container(
              //       width: 80,
              //       child: Card(
              //         elevation: 5,
              //         child: Column(
              //           children: [
              //             Text("EUR"),
              //             SizedBox(
              //               height: 4,
              //             ),
              //             Text("3456"),
              //          ],
              //        ),
              //       ),
              //      ),
              //      Container(
              //        width: 80,
              //        child: Card(
              //          elevation: 5,
              //          child: Column(
              //            children: [
              //              Text("GBP"),
              //              SizedBox(
              //               height: 4,
              //             ),
              //             Text("234"),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> timeitems = [
    const DropdownMenuItem(
        value: "Lt",
        child: Text(
          "Litre",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "m2",
        child: Text(
          "m2",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "m3",
        child: Text(
          "m3",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "Kg",
        child: Text(
          "Kg",
          style: TextStyle(fontSize: 14),
        )),
  ];
  return timeitems;
}

List<DropdownMenuItem<String>> get dropdownpricetype {
  List<DropdownMenuItem<String>> timeitems = [
    const DropdownMenuItem(
        value: "TL",
        child: Text(
          "TL",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "EURO",
        child: Text(
          "EURO",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "DOLAR",
        child: Text(
          "DOLAR",
          style: TextStyle(fontSize: 14),
        )),
  ];
  return timeitems;
}
