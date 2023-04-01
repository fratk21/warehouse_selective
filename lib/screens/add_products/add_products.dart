import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/models/prescriptions.dart' as model;
import 'package:warehouse_selective/models/material.dart' as modelmaterial;
import 'package:warehouse_selective/services/firestoreMethods.dart';
import 'package:warehouse_selective/widgets/appbar.dart';
import 'package:warehouse_selective/widgets/combo.dart';
import 'package:warehouse_selective/widgets/inputText.dart';

import '../../utils/utils.dart';

// ignore: camel_case_types
class add_product extends StatefulWidget {
  const add_product({super.key});

  @override
  State<add_product> createState() => _add_productState();
}

class _add_productState extends State<add_product> {
  TextEditingController productname = TextEditingController();

  TextEditingController prescriptionsname = TextEditingController();

  TextEditingController materialname = TextEditingController();

  TextEditingController prescriptiondes = TextEditingController();
  TextEditingController waste = TextEditingController();
  TextEditingController price = TextEditingController();
  bool visibilty = false;

  Uint8List? _image;
  String selectedValue = "0";
  List<model.prescriptions> prescrip = [];
  List<modelmaterial.material> materials = [];
  String productuid = const Uuid().v1();

  List save = ["1"];
  selectImage() async {
    Uint8List? im;
    try {
      im = await pickImage(ImageSource.gallery);
    } catch (e) {
      print(e);
    }
    setState(() {
      _image = im;
    });
  }

  Future malzemePopup(int index, String prescriptionsid, String productid) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                      Card(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 60,
                          child: const Center(
                              child: Text("Malzeme Ekle",
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Helvetica"))),
                        ),
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
                          hinttext: "Malzeme Adı",
                          icons: Icons.chair_alt,
                          texttip: TextInputType.name,
                          gizli: false,
                          color: white,
                          color2: orange,
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
                              color2: orange,
                              elevation: 10,
                            ),
                          ),
                          customCombo(
                              bosluk: 10,
                              color: white,
                              iconsize: 20,
                              items: dropdownItems,
                              selectedValue: selectedValue,
                              radius: 20,
                              text: "Birim",
                              textsize: 15),
                        ],
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
                              color2: orange,
                              elevation: 10,
                            ),
                          ),
                          customCombo(
                              bosluk: 10,
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
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: width(context),
                          child: ElevatedButton(
                              // ignore: prefer_const_constructors
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(orange),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 20))),
                              onPressed: () {
                                String materialid = const Uuid().v1();

                                modelmaterial.material materialmodel =
                                    modelmaterial.material(
                                        materialid: materialid,
                                        prescriptionsid: prescriptionsid,
                                        productid: productuid,
                                        materialname: materialname.text,
                                        west: waste.text,
                                        unit: selectedValue.toString(),
                                        price: price.text,
                                        priceType: "tl");
                                print("reçete id $prescriptionsid");
                                for (var i = 0; i < prescrip.length; i++) {
                                  if (prescrip[i].prescriptionsid.toString() ==
                                      prescriptionsid) {
                                    prescrip[i].material!.add(materialmodel);
                                  } else {
                                    print("reçete farklı");
                                  }
                                }

                                setState(() {
                                  prescrip[index].material!;
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Ekle")),
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

  Future RecetePopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                      Card(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 60,
                          child: const Center(
                              child: Text("Reçete Ekle",
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Helvetica"))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: inputtext(
                          context: context,
                          control: prescriptionsname,
                          height: 50,
                          width: width(context),
                          maxline: 1,
                          maxLengh: 40,
                          hinttext: "Reçete Adı",
                          icons: Icons.document_scanner_sharp,
                          texttip: TextInputType.name,
                          gizli: false,
                          color: white,
                          color2: orange,
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: inputtext(
                          context: context,
                          control: prescriptiondes,
                          height: 100,
                          width: width(context),
                          maxline: 5,
                          maxLengh: 150,
                          hinttext: "Açıklama",
                          icons: Icons.description,
                          texttip: TextInputType.name,
                          gizli: false,
                          color: white,
                          color2: orange,
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: width(context),
                          child: ElevatedButton(

                              // ignore: prefer_const_constructors
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor: orange,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                if (prescriptionsname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen Reçete Adını Yazınız",
                                      AnimatedSnackBarType.error);
                                } else {
                                  String prescriptionsid = const Uuid().v1();
                                  await firestoreservices()
                                      .productAdd_prescriptions(
                                          prescriptionsid,
                                          prescriptionsname.text,
                                          productuid,
                                          [],
                                          prescriptiondes.text);

                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Ekle")),
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

  Widget getCardItem(int indexs, String Name, String Description,
      String prescriptionsid, String productid) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: RoundedExpansionTile(
          title: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: const Icon(Icons.document_scanner_sharp,
                          size: 24, color: orange),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          Name,
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        "2100",
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child:
                        const Icon(Icons.description, size: 24, color: orange),
                    padding: const EdgeInsets.all(12),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        Description,
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: width(context),
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        print(indexs);
                        malzemePopup(indexs, prescriptionsid, productid);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        backgroundColor: grey_yellow,
                      ),
                      child: Text("Malzeme Ekle")),
                ),
              )
            ],
          ),
          children: [
            Container(
              height: prescrip[indexs].material!.isEmpty
                  ? MediaQuery.of(context).size.height / 25
                  : (MediaQuery.of(context).size.height / 25) *
                      prescrip[indexs].material!.length,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: prescrip[indexs].material!.isEmpty
                    ? save.length
                    : prescrip[indexs].material!.length,
                itemBuilder: (context, index) {
                  return prescrip[index].material!.isEmpty
                      ? Container()
                      : Container(
                          child: getCardDetails(prescrip[index].material![index]
                              as modelmaterial.material),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCardDetails(modelmaterial.material material) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Text(material.materialname),
            SizedBox(
              width: 2,
            ),
            Text(material.materialid),
          ],
        ),
        Divider(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(true, context, orange, "Ürün Ekle", true, () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: width(context),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: _image != null
                                ? DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.fitWidth,
                                  )
                                : const DecorationImage(
                                    image: AssetImage("assets/add_product.jpg"),
                                    fit: BoxFit.fitWidth,
                                  )),
                      ),
                      Positioned(
                        top: 50,
                        // bottom: 100,
                        left: 150,
                        child: IconButton(
                          iconSize: 60,
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: grey_yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                inputtex(
                  context,
                  productname,
                  50,
                  width(context),
                  1,
                  60,
                  "Ürün Adı",
                  Icons.chair,
                  TextInputType.name,
                  false,
                  white,
                  orange,
                  10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: width(context),
                  child: ElevatedButton(

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                          backgroundColor: orange,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (productname.text.isEmpty) {
                          showsnackbar(context, "Lütfen ürün adını yazınız",
                              AnimatedSnackBarType.error);
                          // print(productname.text);
                        } else {
                          if (visibilty) {
                            await firestoreservices().productupdate(
                                productuid, _image, productname.text);
                          } else {
                            await firestoreservices().productCreate(
                                productuid, _image, productname.text);
                          }

                          setState(() {
                            visibilty = true;
                          });
                        }
                      },
                      child: visibilty
                          ? Text("Ürünü Güncelle")
                          : Text("Ürün oluştur")),
                ),
                visibilty ? Divider() : Container(),
                visibilty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Reçete Oluştur"),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: RecetePopup, icon: Icon(Icons.add)),
                          )
                        ],
                      )
                    : Container(),
                visibilty
                    ? Container(
                        height: prescrip.isEmpty
                            ? MediaQuery.of(context).size.height
                            : (MediaQuery.of(context).size.height / 2) *
                                prescrip.length,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              prescrip.isEmpty ? save.length : prescrip.length,
                          itemBuilder: (context, index) {
                            print("card görüntüleme index $index");
                            print(prescrip.isEmpty
                                ? 1
                                : prescrip[index].prescriptionsid);
                            return prescrip.isEmpty
                                ? Container()
                                : Container(
                                    child: getCardItem(
                                      index,
                                      prescrip[index].prescriptionsname,
                                      prescrip[index].prescriptionsdes,
                                      prescrip[index].prescriptionsid,
                                      prescrip[index].productid,
                                    ),
                                  );
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> timeitems = [
    const DropdownMenuItem(
        value: "0",
        child: Text(
          "Litre",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "1",
        child: Text(
          "m2",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "2",
        child: Text(
          "m3",
          style: TextStyle(fontSize: 14),
        )),
    const DropdownMenuItem(
        value: "3",
        child: Text(
          "Kg",
          style: TextStyle(fontSize: 14),
        )),
  ];
  return timeitems;
}
