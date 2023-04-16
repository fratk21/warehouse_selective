import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/screens/add_products/add_prescription.dart';

import '../services/firestoreMethods.dart';
import '../utils/utils.dart';

Widget modules_card_product_add_screen(
  BuildContext context,
  snap,
  String productname,
  String productid,
) {
  Uint8List? image1;
  TextEditingController modulesname = TextEditingController();
  TextEditingController modulesdes = TextEditingController();
  selectImage(int a, int b, BuildContext context) async {
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
      } else {
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

        image1 = im;
      }
    } catch (e) {
      print(e);
    }
  }

  Future imagesecenek(int a, BuildContext context) {
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
                      if (a == 1) {
                        await selectImage(2, 2, context);
                      } else if (a == 2) {
                        await selectImage(2, 1, context);
                      }
                    },
                    child: Center(
                      child: Text("fotograf çek"),
                    ))),
            ListTile(
                title: TextButton(
                    onPressed: () async {
                      print(a);
                      Navigator.pop(context);
                      if (a == 1) {
                        await selectImage(1, 2, context);
                      } else if (a == 2) {
                        await selectImage(1, 1, context);
                      }
                    },
                    child: Center(
                      child: Text("Galeriden yükle"),
                    ))),
          ],
        );
      },
    );
  }

  modulesname.text = snap["modulesname"].toString();
  modulesdes.text = snap["modulesdes"].toString();
  String mimage = snap["modulesimage"].toString();
  Future Modulpopop(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: width(context),
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    image: mimage == ""
                                        ? image1 != null
                                            ? DecorationImage(
                                                image: MemoryImage(image1!),
                                                fit: BoxFit.fitWidth,
                                              )
                                            : const DecorationImage(
                                                image: AssetImage(
                                                    "assets/add_product.jpg"),
                                                fit: BoxFit.fitWidth,
                                              )
                                        : DecorationImage(
                                            image: NetworkImage(mimage),
                                            fit: BoxFit.fitWidth,
                                          )),
                              ),
                              Positioned(
                                top: 45,
                                // bottom: 100,
                                left: 100,
                                child: IconButton(
                                  iconSize: 60,
                                  onPressed: () => imagesecenek(1, context),
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: silverlake,
                                  ),
                                ),
                              )
                            ],
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
                            height: 50,
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
                                  Icons.view_module_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextField(
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  maxLines: 1,
                                  controller: modulesname,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Modül Adı",
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
                                  Icons.view_module_outlined,
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
                                  controller: modulesdes,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Modül Açıklaması",
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width(context),
                          height: 40,
                          child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                if (modulesname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen Modül Adı Giriniz",
                                      AnimatedSnackBarType.error);
                                } else {
                                  firestoreservices().productupdate_modules(
                                      snap["modulesid"],
                                      modulesname.text,
                                      productid,
                                      [],
                                      image1,
                                      modulesdes.text);
                                  Navigator.pop(context);
                                }

                                image1 = null;
                              },
                              child: Text(
                                "Modul Güncelle",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
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
                      Modulpopop(context);
                    },
                    label: Center(
                      child: Text(
                        "Modül Düzenle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
          ],
        );
      },
    );
  }

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
