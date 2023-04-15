import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../constants/constants.dart';
import '../../services/firestoreMethods.dart';
import '../../utils/utils.dart';

class add_material_per_screen extends StatefulWidget {
  final snap;
  const add_material_per_screen({super.key, this.snap});

  @override
  State<add_material_per_screen> createState() =>
      _add_material_per_screenState();
}

class _add_material_per_screenState extends State<add_material_per_screen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.snap["prescriptionsname"]),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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

                                  await firestoreservices()
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
                                          sup);
                                }
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Malzemeyi Reçeteye Ekle",
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
