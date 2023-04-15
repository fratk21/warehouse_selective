import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
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

  void getdata() async {
    isloading = true;
    try {
      var modules = await FirebaseFirestore.instance
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(widget.snap["productid"])
          .collection("modules")
          .get();
      moduleslength = modules.docs.length;

      for (var i = 0; i < modules.docs.length; i++) {
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

        for (var k = 0; k < pres.docs.length; i++) {
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
          print(pres.docs[k].id);
          int a = material["material"].length;
          for (var i = 0; i < material["material"].length; i++) {
            mattl += double.parse(material["material"][i]["total"]);
            print(material["material"][i]["total"]);
          }
          matlength += a;
        }
      }
    } catch (e) {}

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

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Card(
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
                          padding: const EdgeInsets.only(bottom: 8, left: 8),
                          child: Container(
                            width: width(context) - 130,
                            height: 30,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(0)),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10.0, left: 8),
                                child: Text(
                                  widget.snap["productname"],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                                widget.snap["productdes"] == ""
                                    ? "Açıklama Girilmemiş"
                                    : widget.snap["productdes"],
                                style: Theme.of(context).textTheme.bodyMedium,
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
                  children: [
                    Card(
                      color: Theme.of(context).cardColor,
                      child: Column(
                        children: [
                          Text("TL"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(mattl.toString()),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
