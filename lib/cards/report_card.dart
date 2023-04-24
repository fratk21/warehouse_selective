import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_selective/cards/report_pres.dart';
import 'package:warehouse_selective/services/finance.dart';

import '../constants/constants.dart';

class report_card extends StatefulWidget {
  final snap;
  const report_card({super.key, this.snap});

  @override
  State<report_card> createState() => _report_cardState();
}

class _report_cardState extends State<report_card> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.snap["productname"]),
            ),
            body: SingleChildScrollView(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("product")
                  .doc(widget.snap["productid"])
                  .collection("modules")
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  height: snapshot.data!.docs.length * 600,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length == 0
                        ? 1
                        : snapshot.data!.docs.length + 1,
                    itemBuilder: (context, index) {
                      Widget result;
                      if (snapshot.data!.docs.isEmpty) {
                        result = Container();
                      } else {
                        if (index == 0) {
                          result = Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: width(context),
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: widget.snap["productimage"] == ""
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  "https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg"),
                                              fit: BoxFit.fitWidth,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  widget.snap["productimage"]),
                                              fit: BoxFit.fitWidth,
                                            )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    //  elevation: 10,
                                    child: Container(
                                      height: 40,
                                      width: width(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Modüller",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                    )),
                              ],
                            ),
                          );
                        } else {
                          result = Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: Center(
                                      child: Text(snapshot.data!.docs[index - 1]
                                          .data()["modulesname"]),
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("product")
                                        .doc(widget.snap["productid"])
                                        .collection("modules")
                                        .doc(snapshot.data!.docs[index - 1].id)
                                        .collection("prescriptions")
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container(
                                        height:
                                            snapshot.data!.docs.length * 105,
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              snapshot.data!.docs.length == 0
                                                  ? 1
                                                  : 1,
                                          itemBuilder: (context, index) {
                                            Widget result;
                                            if (snapshot.data!.docs.isEmpty) {
                                              result = Container();
                                            } else {
                                              result = DataTable(
                                                columnSpacing: 2,
                                                showCheckboxColumn: false,
                                                border: TableBorder.all(
                                                    width: 0.2,
                                                    color: Color.fromARGB(
                                                        84, 0, 0, 0)),
                                                columns: [
                                                  DataColumn(
                                                    label: Text('Reçete Adı'),
                                                  ),
                                                  DataColumn(
                                                      label: Text(
                                                          'Varsayılan M.')),
                                                  DataColumn(
                                                      label: Text('Min M.')),
                                                  DataColumn(
                                                      label: Text('Max M.')),
                                                ],
                                                rows: List<DataRow>.generate(
                                                  snapshot.data!.docs.length,
                                                  (index) {
                                                    double max = 0,
                                                        min = 0,
                                                        vars = 0;
                                                    for (var i = 0;
                                                        i <
                                                            snapshot.data!
                                                                .docs[index]
                                                                .data()[
                                                                    "material"]
                                                                .length;
                                                        i++) {
                                                      max += snapshot
                                                              .data!.docs[index]
                                                              .data()[
                                                          "material"][i]["max"];
                                                      min += snapshot
                                                              .data!.docs[index]
                                                              .data()[
                                                          "material"][i]["min"];
                                                      vars += snapshot
                                                              .data!.docs[index]
                                                              .data()["material"]
                                                          [i]["total"];
                                                    }
                                                    return DataRow(
                                                      cells: [
                                                        DataCell(Text(snapshot
                                                            .data!.docs[index]
                                                            .data()[
                                                                "prescriptionsname"]
                                                            .toString())),
                                                        DataCell(Text(
                                                            vars.toString())),
                                                        DataCell(Text(
                                                            min.toString())),
                                                        DataCell(Text(
                                                            max.toString())),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            }

                                            return result;
                                          },
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }

                      return result;
                    },
                  ),
                );
              },
            )),
          );
  }
}
