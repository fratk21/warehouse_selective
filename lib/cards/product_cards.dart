import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';
import 'package:warehouse_selective/screens/add_products/add_product.dart';
import 'package:warehouse_selective/services/firestoreMethods.dart';

import '../constants/constants.dart';
import '../screens/add_products/add_material_screen.dart';
import '../services/finance.dart';

class product_card extends StatefulWidget {
  final snap;
  const product_card({super.key, required this.snap});

  @override
  State<product_card> createState() => _product_cardState();
}

class _product_cardState extends State<product_card> {
  bool isloading = false;

  int moduleslength = 0;
  int preslength = 0;
  int matlength = 0;
  double mattl = 0;
  double mateuro = 0;
  double matdolar = 0;
  double matstr = 0;
  List modulesid = [];
  void getdata() async {
    isloading = true;

    var modules = await FirebaseFirestore.instance
        .collection('products')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("product")
        .doc(widget.snap["productid"])
        .collection("modules")
        .get();
    moduleslength = modules.docs.length;
    print(widget.snap["productid"] +
        " ürün id " +
        "modül uzunlığı" +
        modules.docs.length.toString());
    for (var i = 0; i < modules.docs.length; i++) {
      print(modules.docs[i].id + "modül id");
      var pres = await FirebaseFirestore.instance
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(widget.snap["productid"])
          .collection("modules")
          .doc(modules.docs[i].id)
          .collection("prescriptions")
          .get();
      preslength += pres.docs.length;
      for (var k = 0; k < pres.docs.length; k++) {
        print("fora gşr");
        var material = await FirebaseFirestore.instance
            .collection('products')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(widget.snap["productid"])
            .collection("modules")
            .doc(modules.docs[i].id)
            .collection("prescriptions")
            .doc(pres.docs[k].id)
            .get();
        print(k.toString() + "K");
        print(modules.docs[i].id);

        print(material["material"].length.toString() + "material");
        int a = material["material"].length;
        for (var j = 0; j < material["material"].length; j++) {
          mattl += material["material"][j]["total"];
          print(material["material"][j]["total"]);
        }
        matlength += a;
      }
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
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
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "Rapor Al",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
            ListTile(
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => add_product_screen(
                                productid: snap["productid"]),
                          ));
                    },
                    child: Center(
                      child: Text(
                        "Ürünü Düzenle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
            ListTile(
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      firestoreservices().productdelete(snap["productid"]);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "Ürünü Sil",
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              secenek(widget.snap);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).cardColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
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
                          child: widget.snap["productimage"] == ""
                              ? Icon(
                                  Icons.chair,
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
                                        image: NetworkImage(
                                            widget.snap["productimage"]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Center(
                                child: Container(
                                  width: width(context) - 156,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(50),
                                        topRight: Radius.circular(0)),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 8),
                                      child: Text(
                                        widget.snap["productname"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 200,
                                  child: Text(
                                    widget.snap["productdes"] == ""
                                        ? "Açıklama Girilmemiş"
                                        : widget.snap["productdes"],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Text("Modül Sayısı"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(moduleslength.toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Text("Reçete Sayısı"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(preslength.toString()),
                            ],
                          ),
                        ),
                        Card(
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Text("Malzeme Sayısı"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(matlength.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: width(context) - 100,
                      child: Card(
                        child: Center(child: Text("Ürün Maliyeti")),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            child: Column(
                              children: [
                                Text("TL"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(mattl.toStringAsFixed(2)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            child: Column(
                              children: [
                                Text("USD"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((mattl / globaldolar).toStringAsFixed(2)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            child: Column(
                              children: [
                                Text("EURO"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((mattl / globaleuro).toStringAsFixed(2)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(60)),
                            ),
                            color: Theme.of(context).cardColor,
                            child: Column(
                              children: [
                                Text("Sterlin"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    (mattl / globalsterlin).toStringAsFixed(2)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
