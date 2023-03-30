import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/models/prescriptions.dart' as model;
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

  Uint8List? _image;
  String selectedValue = "0";
  List<model.prescriptions> prescrip = [];
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

  Future malzemePopup() {
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
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: inputtext(
                          context: context,
                          control: price,
                          height: 50,
                          width: width(context),
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
                              onPressed: () {},
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
                              onPressed: () {
                                model.prescriptions _prescripton = model
                                    .prescriptions(
                                        prescriptionsid: "1",
                                        prescriptionsname:
                                            prescriptionsname.text,
                                        productid: "1",
                                        prescriptionsdes: prescriptiondes.text,
                                        material: []);
                                prescrip.add(_prescripton);
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

  Widget getCardItem(String Name, String Description) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        child: Column(
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
                  child: const Icon(Icons.description, size: 24, color: orange),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      backgroundColor: orange,
                    ),
                    child: Text("data")),
              ),
            )
          ],
        ),
      ),
    );
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
                inputtext(
                  context: context,
                  control: productname,
                  height: 50,
                  width: width(context),
                  maxline: 1,
                  maxLengh: 60,
                  hinttext: "Ürün Adı",
                  icons: Icons.chair,
                  texttip: TextInputType.name,
                  gizli: false,
                  color: white,
                  color2: orange,
                  elevation: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Row(
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: prescrip.isEmpty ? save.length : prescrip.length,
                    itemBuilder: (context, index) {
                      return prescrip.isEmpty
                          ? Container()
                          : Container(
                              child: getCardItem(
                                  prescrip[index].prescriptionsname,
                                  prescrip[index].prescriptionsdes),
                            );
                    },
                  ),
                )
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
