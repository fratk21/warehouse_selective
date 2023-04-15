import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/cards/product_cards.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';

class products_screen extends StatefulWidget {
  const products_screen({super.key});

  @override
  State<products_screen> createState() => _products_screenState();
}

class _products_screenState extends State<products_screen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Ürünler"),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                  result =
                      product_card(snap: snapshot.data!.docs[index].data());
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
