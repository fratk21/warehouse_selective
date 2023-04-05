import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController modulesname = TextEditingController();
  TextEditingController modulesdes = TextEditingController();
  int screensize = 1;
  int screensizemodul = 1;

  bool visibilty = false;

  Uint8List? _image;
  Uint8List? _image1;

  String selectedValue = "Kg";
  String selectedValueprice = "TL";

  List<model.prescriptions> prescrip = [];
  List<modelmaterial.material> materials = [];
  String productuid = const Uuid().v1();

  List save = ["1"];
  selectImage(int a) async {
    Uint8List? im;
    try {
      im = await pickImage(ImageSource.gallery);
    } catch (e) {
      print(e);
    }
    if (a == 1) {
      setState(() {
        _image = im;
      });
    } else {
      setState(() {
        _image1 = im;
      });
    }
  }

  @override
  dispose() {
    // you need this
    super.dispose();
  }

  Future malzemePopup(
    String productid,
    String modulid,
    String prescriptionsid,
  ) {
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
                              color: lblue,
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
                                      MaterialStateProperty.all(lblue),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 20))),
                              onPressed: () async {
                                String materialid = const Uuid().v1();
                                await firestoreservices()
                                    .prescriptionsAdd_material(
                                        materialid,
                                        productid,
                                        prescriptionsid,
                                        modulid,
                                        materialname.text,
                                        waste.text,
                                        selectedValue,
                                        price.text,
                                        selectedValueprice);
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

  Future RecetePopup(String modulid) {
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
                              color: lblue,
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
                          color2: lblue,
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
                          color2: lblue,
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
                                  backgroundColor: lblue,
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
                                          prescriptiondes.text,
                                          modulid);
                                  setState(() {
                                    screensizemodul += 1;
                                  });
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

  Widget getCardItem(snap, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ExpansionTileCard(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          colorCurve: Curves.easeInOutExpo,
          duration: Duration(milliseconds: 500),
          baseColor: darkgray,
          expandedColor: darkgray,
          expandedTextColor: white,
          leading: snap["modulesimage"] == ""
              ? Icon(
                  Icons.view_module_rounded,
                  color: platinyum,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(snap["modulesimage"]),
                  radius: 20,
                ),
          title: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExpandableText(
                    "Modul Name : ${snap["modulesname"]}",
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 1,
                    linkColor: lblue,
                    animation: true,
                    style: TextStyle(color: platinyum),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExpandableText(
                    "Modul Description : ${snap["modulesdes"]}",
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 1,
                    linkColor: lblue,
                    animation: true,
                    style: TextStyle(color: platinyum),
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: width(context),
                  height: 40,
                  child: ElevatedButton(

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          backgroundColor: lblue,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        RecetePopup(snap["modulesid"]);
                      },
                      child: Text(
                        "Reçete Oluştur",
                        style: TextStyle(color: white),
                      )),
                ),
              )
            ],
          ),
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("product")
                  .doc(productuid)
                  .collection("modules")
                  .doc(snap["modulesid"])
                  .collection("prescriptions")
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return snapshot.data!.docs.isEmpty
                    ? Container()
                    : Container(
                        height: screensizemodul == 1
                            ? MediaQuery.of(context).size.height
                            : MediaQuery.of(context).size.height *
                                (screensizemodul - screensizemodul / 2),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, index) => Container(
                              child: getCardDetails(snap["modulesid"],
                                  snapshot.data!.docs[index].data())),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget getCardDetails(String Modulid, snap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ExpansionTileCard(
          leading: Icon(Icons.document_scanner_rounded),
          title: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExpandableText(
                    "Prescriptions Name : ${snap["prescriptionsname"]}",
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 1,
                    linkColor: lblue,
                    animation: true,
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExpandableText(
                    "Prescriptions Description : ${snap["prescriptionsdes"]}",
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 1,
                    linkColor: lblue,
                    animation: true,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: width(context),
                  height: 40,
                  child: ElevatedButton(

                      // ignore: prefer_const_constructors
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          backgroundColor: silverlake,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        malzemePopup(
                            productuid, Modulid, snap["prescriptionsid"]);
                      },
                      child: Text("Malzeme Ekle")),
                ),
              )
            ],
          ),
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("product")
                  .doc(productuid)
                  .collection("modules")
                  .doc(snap["modulesid"])
                  .collection("prescriptions")
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return snapshot.data!.docs.isEmpty
                    ? Container()
                    : Container(
                        height: screensizemodul == 1
                            ? MediaQuery.of(context).size.height
                            : MediaQuery.of(context).size.height *
                                (screensizemodul - screensizemodul / 2),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                snapshot.data!.docs[0]["material"].lenght,
                            itemBuilder: (ctx, index) => Container(
                                  child: Text("data"),
                                )),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  Future Modulpopop() {
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
                              color: lblue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 60,
                          child: const Center(
                              child: Text("Modül Oluştur",
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Helvetica"))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                                left: 85,
                                child: IconButton(
                                  iconSize: 60,
                                  onPressed: () => selectImage(1),
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
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: inputtext(
                          context: context,
                          control: modulesname,
                          height: 50,
                          width: width(context),
                          maxline: 1,
                          maxLengh: 40,
                          hinttext: "Modül Adı",
                          icons: Icons.document_scanner_sharp,
                          texttip: TextInputType.name,
                          gizli: false,
                          color: white,
                          color2: lblue,
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: inputtext(
                          context: context,
                          control: modulesdes,
                          height: 100,
                          width: width(context),
                          maxline: 5,
                          maxLengh: 150,
                          hinttext: "Açıklama",
                          icons: Icons.description,
                          texttip: TextInputType.name,
                          gizli: false,
                          color: white,
                          color2: lblue,
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: width(context),
                          height: 40,
                          child: ElevatedButton(

                              // ignore: prefer_const_constructors
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  backgroundColor: lblue,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                String modulessid = const Uuid().v1();
                                if (modulesname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen  Modül adı Yazınız",
                                      AnimatedSnackBarType.warning);
                                } else {
                                  firestoreservices().productAdd_modules(
                                      modulessid,
                                      modulesname.text,
                                      productuid,
                                      [],
                                      _image1,
                                      modulesdes.text);
                                  setState(() {
                                    screensize += 1;
                                  });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lblue,
      ),
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
                          onPressed: () => selectImage(1),
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: silverlake,
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
                  silverlake,
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
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          backgroundColor: lblue,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (productname.text.isEmpty) {
                          showsnackbar(context, "Lütfen ürün adını yazınız",
                              AnimatedSnackBarType.warning);
                          print(productname.text);
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
                            child: Text("Modül Oluştur"),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: Modulpopop, icon: Icon(Icons.add)),
                          )
                        ],
                      )
                    : Container(),
                visibilty
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("product")
                            .doc(productuid)
                            .collection("modules")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return snapshot.data!.docs.isEmpty
                              ? Container()
                              : Container(
                                  height: snapshot.data!.docs.isEmpty
                                      ? 250
                                      : (MediaQuery.of(context).size.height *
                                          screensize),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (ctx, index) => Container(
                                        child: getCardItem(
                                            snapshot.data!.docs[index].data(),
                                            snapshot.data!.docs.length)),
                                  ),
                                );
                        },
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
