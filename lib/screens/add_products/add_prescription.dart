import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/cards/prescription_add_card.dart';
import 'package:warehouse_selective/models/product.dart';
import 'package:warehouse_selective/utils/utils.dart';

import '../../constants/constants.dart';
import '../../services/firestoreMethods.dart';
import '../../widgets/inputText.dart';

class add_prescription_screen extends StatefulWidget {
  final modulesname;
  final productid;
  final modulesid;
  final productname;
  const add_prescription_screen(
      {super.key,
      required this.modulesid,
      required this.modulesname,
      required this.productid,
      required this.productname});

  @override
  State<add_prescription_screen> createState() =>
      _add_prescription_screenState();
}

class _add_prescription_screenState extends State<add_prescription_screen> {
  TextEditingController prescriptionsname = TextEditingController();
  TextEditingController prescriptiondes = TextEditingController();

  Future RecetePopup() {
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
                                  String prescriptionsid = const Uuid().v1();

                                  await firestoreservices()
                                      .productAdd_prescriptions(
                                          prescriptionsid,
                                          prescriptionsname.text,
                                          widget.productid,
                                          [],
                                          prescriptiondes.text,
                                          widget.modulesid);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Reçete oluştur")),
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
        title: Text(
          widget.productname,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                        topRight: Radius.circular(0)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text(widget.modulesname)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("product")
                        .doc(widget.productid)
                        .collection("modules")
                        .doc(widget.modulesid)
                        .collection("prescriptions")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        height: snapshot.data!.docs.length * 250,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length == 0
                              ? 1
                              : snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Widget result;
                            if (snapshot.data!.docs.isEmpty) {
                              result = Container();
                            } else {
                              result = prescription_add_card(
                                snap: snapshot.data!.docs[index].data(),
                              );
                            }

                            return result;
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: 150,
        height: 40,
        child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: RecetePopup,
            child: Text("Reçete oluştur")),
      ),
    );
  }
}
