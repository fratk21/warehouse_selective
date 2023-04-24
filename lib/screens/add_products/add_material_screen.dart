import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/services/finance.dart';

import '../../constants/constants.dart';
import '../../services/firestoreMethods.dart';
import '../../utils/utils.dart';

class add_material_per_screen extends StatefulWidget {
  final snap;
  final int index;
  const add_material_per_screen({super.key, this.snap, required this.index});

  @override
  State<add_material_per_screen> createState() =>
      _add_material_per_screenState();
}

class _add_material_per_screenState extends State<add_material_per_screen> {
  int control = 0;
  bool showmaterial = false;
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
  TextEditingController waste = TextEditingController();
  void controle() {
    if (widget.index == 9274824373436) {
      control = 0;
    } else {
      control = 1;
      materialname.text = widget.snap["materialname"].toString();
      tedarik1.text = widget.snap["suppliers"][0].toString();
      tedarik2.text = widget.snap["suppliers"][1].toString();
      tedarik3.text = widget.snap["suppliers"][2].toString();
      tedarik1price.text = widget.snap["price"][0].toString();
      tedarik2price.text = widget.snap["price"][1].toString();
      tedarik3price.text = widget.snap["price"][2].toString();
      selectedValueprice1 = widget.snap["priceType"][0].toString();
      selectedValueprice2 = widget.snap["priceType"][1].toString();
      selectedValueprice3 = widget.snap["priceType"][2].toString();
      waste.text = widget.snap["west"].toString();
      selectedValue = widget.snap["unit"].toString();
    }
    setState(() {
      control;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Malzeme Ekle"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).cardColor,
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
                                  Icons.chair_alt,
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
                                  controller: materialname,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Material Adı",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  onChanged: (value) {
                                    setState(() {
                                      if (materialname.text.isEmpty) {
                                        showmaterial = false;
                                      } else {
                                        showmaterial = true;
                                      }
                                    });
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: !showmaterial
                              ? Container()
                              : Container(
                                  height: 100,
                                  child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("products")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("material")
                                        .where("materialname",
                                            isGreaterThanOrEqualTo:
                                                materialname.text)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView.builder(
                                        itemCount: (snapshot.data! as dynamic)
                                            .docs
                                            .length,
                                        itemBuilder: (context, index) {
                                          Widget result;
                                          if ((snapshot.data! as dynamic)
                                                  .docs
                                                  .length ==
                                              0) {
                                            result = Center(
                                              child: Text("Malzeme Bulunamadı"),
                                            );
                                          } else {
                                            result = InkWell(
                                              onTap: () {
                                                setState(() {
                                                  materialname.text = (snapshot
                                                              .data! as dynamic)
                                                          .docs[index]
                                                      ['materialname'];
                                                  waste.text = (snapshot.data!
                                                          as dynamic)
                                                      .docs[index]['west'];
                                                  selectedValue = (snapshot
                                                          .data! as dynamic)
                                                      .docs[index]['unit'];
                                                  tedarik1.text = (snapshot
                                                              .data! as dynamic)
                                                          .docs[index]
                                                      ['suppliers'][0];
                                                  tedarik1price.text = (snapshot
                                                          .data! as dynamic)
                                                      .docs[index]['price'][0];
                                                  selectedValueprice1 =
                                                      (snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['priceType'][0];
                                                  //
                                                  tedarik2.text = (snapshot
                                                              .data! as dynamic)
                                                          .docs[index]
                                                      ['suppliers'][1];
                                                  tedarik2price.text = (snapshot
                                                          .data! as dynamic)
                                                      .docs[index]['price'][1];
                                                  selectedValueprice2 =
                                                      (snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['priceType'][1];
                                                  //
                                                  tedarik3.text = (snapshot
                                                              .data! as dynamic)
                                                          .docs[index]
                                                      ['suppliers'][2];
                                                  tedarik3price.text = (snapshot
                                                          .data! as dynamic)
                                                      .docs[index]['price'][2];
                                                  selectedValueprice3 =
                                                      (snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['priceType'][2];
                                                  showmaterial = false;
                                                });
                                              },
                                              child: Card(
                                                color:
                                                    Theme.of(context).cardColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                elevation: 1,
                                                child: Container(
                                                    height: 40,
                                                    width: width(context),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                    child: Center(
                                                      child: Text((snapshot.data!
                                                                  as dynamic)
                                                              .docs[index]
                                                          ['materialname']),
                                                    )),
                                              ),
                                            );
                                          }
                                          return result;
                                        },
                                      );
                                    },
                                  ),
                                )),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              child: Container(
                                height: 50,
                                width: (width(context) / 2),
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
                                      keyboardType: TextInputType.number,
                                      obscureText: false,
                                      maxLines: 1,
                                      controller: waste,
                                      cursorColor:
                                          Theme.of(context).primaryColorDark,
                                      decoration: InputDecoration(
                                        labelText: "Sarfiyat",
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Birim",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: selectedValue,
                                        onChanged: (String? newValue) {
                                          selectedValue = newValue!;
                                          setState(() {
                                            selectedValue;
                                          });
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        iconSize: 20,
                                        icon: const Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        items: dropdownItems),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).cardColor,
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
                                  Icons.contact_emergency_sharp,
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
                                  controller: tedarik1,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "1. Tedarikçi Adı",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              child: Container(
                                height: 50,
                                width: (width(context) / 2),
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
                                      keyboardType: TextInputType.number,
                                      obscureText: false,
                                      maxLines: 1,
                                      controller: tedarik1price,
                                      cursorColor:
                                          Theme.of(context).primaryColorDark,
                                      decoration: InputDecoration(
                                        labelText: "Birim Fiyat",
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Cinsi",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: selectedValueprice1,
                                        onChanged: (String? newValue) {
                                          selectedValueprice1 = newValue!;
                                          setState(() {
                                            selectedValueprice1;
                                          });
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        iconSize: 20,
                                        icon: const Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        items: dropdownpricetype),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).cardColor,
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
                                  Icons.contact_emergency_sharp,
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
                                  controller: tedarik2,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "2. Tedarikçi Adı",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              child: Container(
                                height: 50,
                                width: (width(context) / 2),
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
                                      keyboardType: TextInputType.number,
                                      obscureText: false,
                                      maxLines: 1,
                                      controller: tedarik2price,
                                      cursorColor:
                                          Theme.of(context).primaryColorDark,
                                      decoration: InputDecoration(
                                        labelText: "Birim Fiyat",
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Cinsi",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: selectedValueprice2,
                                        onChanged: (String? newValue) {
                                          selectedValueprice2 = newValue!;
                                          setState(() {
                                            selectedValueprice2;
                                          });
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        iconSize: 20,
                                        icon: const Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        items: dropdownpricetype),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).cardColor,
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
                                  Icons.contact_emergency_sharp,
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
                                  controller: tedarik3,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "3. Tedarikçi Adı",
                                    border: InputBorder.none,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              child: Container(
                                height: 50,
                                width: (width(context) / 2),
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
                                      keyboardType: TextInputType.number,
                                      obscureText: false,
                                      maxLines: 1,
                                      controller: tedarik3price,
                                      cursorColor:
                                          Theme.of(context).primaryColorDark,
                                      decoration: InputDecoration(
                                        labelText: "Birim Fiyat",
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Cinsi",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: selectedValueprice3,
                                        onChanged: (String? newValue) {
                                          selectedValueprice3 = newValue!;
                                          setState(() {
                                            selectedValueprice3;
                                          });
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        iconSize: 20,
                                        icon: const Icon(Icons
                                            .arrow_drop_down_circle_outlined),
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        items: dropdownpricetype),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: width(context),
                          child: ElevatedButton(
                              // ignore: prefer_const_constructors
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                String materialid = const Uuid().v1();
                                if (materialname.text.isEmpty ||
                                    waste.text.isEmpty ||
                                    tedarik1.text.isEmpty ||
                                    tedarik1price.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen boş alanları doldurunuz",
                                      AnimatedSnackBarType.error);
                                } else {
                                  String materialid = const Uuid().v1();
                                  List<String> price = [
                                    tedarik1price.text,
                                    tedarik2price.text,
                                    tedarik3price.text
                                  ];
                                  print(selectedValueprice1);

                                  List<String> pricetype = [
                                    selectedValueprice1,
                                    selectedValueprice2,
                                    selectedValueprice3,
                                  ];
                                  List<String> sup = [
                                    tedarik1.text,
                                    tedarik2.text,
                                    tedarik3.text
                                  ];
                                  double total = 0;
                                  List tlprices = [];
                                  for (var i = 0; i < 3; i++) {
                                    if (pricetype[i] == "TL" &&
                                        price[i] != "") {
                                      tlprices.add(double.parse(price[i]) *
                                          double.parse(waste.text));
                                    } else if (pricetype[i] == "EURO" &&
                                        price[i] != "") {
                                      tlprices.add(double.parse(price[i]) *
                                          globaleuro *
                                          double.parse(waste.text));
                                    } else if (pricetype[i] == "DOLAR" &&
                                        price[i] != "") {
                                      tlprices.add(double.parse(price[i]) *
                                          globaldolar *
                                          double.parse(waste.text));
                                    }
                                  }
                                  double max, min;

                                  max =
                                      tlprices.reduce((a, b) => a > b ? a : b);
                                  min =
                                      tlprices.reduce((a, b) => a < b ? a : b);
                                  if (selectedValueprice1 == "TL") {
                                    total = double.parse(tedarik1price.text) *
                                        double.parse(waste.text);
                                  }
                                  if (selectedValueprice1 == "DOLAR") {
                                    total = (double.parse(tedarik1price.text) *
                                            globaldolar) *
                                        double.parse(waste.text);
                                  }
                                  if (selectedValueprice1 == "EURO") {
                                    total = (double.parse(tedarik1price.text) *
                                            globaleuro) *
                                        double.parse(waste.text);
                                  }
                                  widget.index == 9274824373436
                                      ? await firestoreservices()
                                          .prescriptionsAdd_material(
                                              materialid,
                                              widget.snap["productid"],
                                              widget.snap["prescriptionsid"],
                                              widget.snap["moduleid"],
                                              materialname.text,
                                              waste.text,
                                              selectedValue,
                                              price,
                                              pricetype,
                                              sup,
                                              total,
                                              max,
                                              min)
                                      : await firestoreservices()
                                          .prescriptionsupdate_material(
                                              widget.snap,
                                              materialid,
                                              widget.snap["productid"],
                                              widget.snap["prescriptionsid"],
                                              widget.snap["moduleid"],
                                              materialname.text,
                                              waste.text,
                                              selectedValue,
                                              price,
                                              pricetype,
                                              sup,
                                              total,
                                              widget.index,
                                              max,
                                              min);
                                }
                                Navigator.pop(context);
                              },
                              child: Text(
                                control == 0
                                    ? "Malzemeyi Reçeteye Ekle"
                                    : "Malzeme Güncelle",
                              )),
                        ),
                      )
                    ],
                  ),
                ),
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
