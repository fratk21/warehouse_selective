import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/services/finance.dart';

import '../../cards/product_cards.dart';
import '../../constants/thema_provider.dart';

class analysis_screen extends StatefulWidget {
  const analysis_screen({super.key});

  @override
  State<analysis_screen> createState() => _analysis_screenState();
}

class _analysis_screenState extends State<analysis_screen> {
  bool isloading = false;
  void get() {
    isloading = true;
    setState(() {
      globaldolar;
      globaleuro;
      globalsterlin;
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Analiz"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        child: Card(
                          color: Theme.of(context).cardColor,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 172,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Dolar",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              Text(
                                                globaldolar.toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Sterlin",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              Text(
                                                globalsterlin.toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Euro",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              Text(
                                                globaleuro.toString(),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "\$/€",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              Text(
                                                "${(globaldolar / globaleuro).toStringAsFixed(3)}",
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: double.infinity,
                                width: width(context) - 222,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100.0),
                                      bottomLeft: Radius.circular(100.0),
                                      bottomRight: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "HOŞGELDİNiZ",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Son eklenen ürünler",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8),
                        child: Divider(
                          color: Theme.of(context).hintColor,
                          height: 5,
                        ),
                      ),
                      Container(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("product")
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
                            return Container(
                              height: snapshot.data!.docs.length * 250,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length == 0
                                    ? 1
                                    : snapshot.data!.docs.length > 2
                                        ? 2
                                        : snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Widget result;

                                  if (snapshot.data!.docs.isEmpty) {
                                    result = Container(
                                        child: Center(
                                            child: Text(
                                                "Herhangi bir ürün bulunmamaktadır.")));
                                  } else {
                                    result = product_card(
                                        snap:
                                            snapshot.data!.docs[index].data());
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
    );
  }
}
