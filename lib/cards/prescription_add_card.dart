import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/utils/utils.dart';

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
  String selectedValueprice = "TL";
  TextEditingController materialname = TextEditingController();
  TextEditingController waste = TextEditingController();
  TextEditingController price = TextEditingController();
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

  Future malzemePopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Card(
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
                                      image: _image != null
                                          ? DecorationImage(
                                              image: MemoryImage(_image!),
                                              fit: BoxFit.fitWidth,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  "assets/add_product.jpg"),
                                              fit: BoxFit.fitWidth,
                                            )),
                                ),
                                Positioned(
                                  top: 45,
                                  // bottom: 100,
                                  left: 100,
                                  child: IconButton(
                                    iconSize: 60,
                                    onPressed: () => imagesecenek(1),
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: silverlake,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20.0, right: 20, top: 20),
                            child: inputtext(
                              context: context,
                              control: materialname,
                              height: 50,
                              width: width(context),
                              maxline: 1,
                              maxLengh: 60,
                              hinttext: "Malzeme Adı",
                              icons: Icons.chair_alt,
                              texttip: TextInputType.name,
                              gizli: false,
                              color: white,
                              color2: lblue,
                              elevation: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: inputtext(
                                  context: context,
                                  control: waste,
                                  height: 50,
                                  width: width(context) / 3,
                                  maxline: 1,
                                  maxLengh: 60,
                                  hinttext: "Sarfiyat",
                                  icons: Icons.unarchive_outlined,
                                  texttip: TextInputType.number,
                                  gizli: false,
                                  color: white,
                                  color2: lblue,
                                  elevation: 10,
                                ),
                              ),
                              customCombo(
                                  bosluk: 30,
                                  color: white,
                                  iconsize: 20,
                                  items: dropdownItems,
                                  selectedValue: selectedValue,
                                  radius: 20,
                                  text: "Birim",
                                  textsize: 15),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20),
                            child: inputtext(
                              context: context,
                              control: materialname,
                              height: 50,
                              width: width(context),
                              maxline: 1,
                              maxLengh: 60,
                              hinttext: " 1.Tedarikçi Adı",
                              icons: Icons.location_city_outlined,
                              texttip: TextInputType.name,
                              gizli: false,
                              color: white,
                              color2: lblue,
                              elevation: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: inputtext(
                                  context: context,
                                  control: price,
                                  height: 50,
                                  width: width(context) / 3,
                                  maxline: 1,
                                  maxLengh: 60,
                                  hinttext: "Birim Fiyatı",
                                  icons: Icons.copyright_rounded,
                                  texttip: TextInputType.number,
                                  gizli: false,
                                  color: white,
                                  color2: lblue,
                                  elevation: 10,
                                ),
                              ),
                              customCombo(
                                  bosluk: 10,
                                  color: white,
                                  iconsize: 20,
                                  items: dropdownpricetype,
                                  selectedValue: selectedValueprice,
                                  radius: 20,
                                  text: "Cinsi",
                                  textsize: 15),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20),
                            child: inputtext(
                              context: context,
                              control: materialname,
                              height: 50,
                              width: width(context),
                              maxline: 1,
                              maxLengh: 60,
                              hinttext: " 2.Tedarikçi Adı",
                              icons: Icons.location_city_outlined,
                              texttip: TextInputType.name,
                              gizli: false,
                              color: white,
                              color2: lblue,
                              elevation: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: inputtext(
                                  context: context,
                                  control: price,
                                  height: 50,
                                  width: width(context) / 3,
                                  maxline: 1,
                                  maxLengh: 60,
                                  hinttext: "Birim Fiyatı",
                                  icons: Icons.copyright_rounded,
                                  texttip: TextInputType.number,
                                  gizli: false,
                                  color: white,
                                  color2: lblue,
                                  elevation: 10,
                                ),
                              ),
                              customCombo(
                                  bosluk: 10,
                                  color: white,
                                  iconsize: 20,
                                  items: dropdownpricetype,
                                  selectedValue: selectedValueprice,
                                  radius: 20,
                                  text: "Cinsi",
                                  textsize: 15),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20),
                            child: inputtext(
                              context: context,
                              control: materialname,
                              height: 50,
                              width: width(context),
                              maxline: 1,
                              maxLengh: 60,
                              hinttext: " 3.Tedarikçi Adı",
                              icons: Icons.location_city_outlined,
                              texttip: TextInputType.name,
                              gizli: false,
                              color: white,
                              color2: lblue,
                              elevation: 10,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: inputtext(
                                  context: context,
                                  control: price,
                                  height: 50,
                                  width: width(context) / 3,
                                  maxline: 1,
                                  maxLengh: 60,
                                  hinttext: "Birim Fiyatı",
                                  icons: Icons.copyright_rounded,
                                  texttip: TextInputType.number,
                                  gizli: false,
                                  color: white,
                                  color2: lblue,
                                  elevation: 10,
                                ),
                              ),
                              customCombo(
                                  bosluk: 10,
                                  color: white,
                                  iconsize: 20,
                                  items: dropdownpricetype,
                                  selectedValue: selectedValueprice,
                                  radius: 20,
                                  text: "Cinsi",
                                  textsize: 15),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: width(context),
                              child: ElevatedButton(
                                  // ignore: prefer_const_constructors
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(lblue),
                                      textStyle: MaterialStateProperty.all(
                                          TextStyle(fontSize: 20))),
                                  onPressed: () async {
                                    String materialid = const Uuid().v1();
                                    if (materialname.text.isEmpty) {
                                      showsnackbar(context, "text",
                                          AnimatedSnackBarType.error);
                                    } else {}
                                  },
                                  child: Text("Malzemeyi Reçeteye Ekle")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        malzemePopup();
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Card(
                    elevation: 5,
                    child:
                        Center(child: Text(widget.snap["prescriptionsname"]))),
              ),
              Container(
                height: 70,
                child: Card(
                    elevation: 5,
                    child:
                        Center(child: Text(widget.snap["prescriptionsdes"]))),
              ),
              Container(
                height: 50,
                child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Malzeme Sayısı"),
                          Text(widget.snap["material"].length.toString()),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.shape_line))
                        ],
                      ),
                    )),
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
