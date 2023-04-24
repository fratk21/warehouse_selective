import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_selective/cards/material_add_card.dart';

import 'add_material_screen.dart';

class add_material_screen extends StatefulWidget {
  final snap;
  final String productid;
  final String moduleid;
  final String presid;
  final int itemcount;
  final String presname;
  const add_material_screen(
      {super.key,
      required this.snap,
      required this.moduleid,
      required this.presid,
      required this.productid,
      required this.itemcount,
      required this.presname});

  @override
  State<add_material_screen> createState() => _add_material_screenState();
}

class _add_material_screenState extends State<add_material_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.presname),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('products')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("product")
                .doc(widget.productid)
                .collection("modules")
                .doc(widget.moduleid)
                .collection("prescriptions")
                .where("prescriptionsid", isEqualTo: widget.presid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                height:
                    ((snapshot.data! as dynamic).docs[0]["material"].length) *
                        300.0,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (snapshot.data! as dynamic).docs.length == 0
                      ? 1
                      : (snapshot.data! as dynamic).docs[0]["material"].length,
                  itemBuilder: (context, index) {
                    Widget result;
                    if ((snapshot.data! as dynamic).docs.length == 0) {
                      result = Container();
                    } else {
                      result = materialadd_card(
                        snap: (snapshot.data! as dynamic).docs[0]["material"]
                            [index],
                        index: index,
                      );
                    }

                    return result;
                  },
                ),
              );
            },
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => add_material_per_screen(
                      snap: widget.snap,
                      index: 9274824373436,
                    ),
                  ));
            },
            child: Text("Malzeme Ekle")),
      ),
    );
  }
}
