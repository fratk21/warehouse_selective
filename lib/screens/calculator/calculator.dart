import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/constants/thema_provider.dart';

class calculator_screen extends StatefulWidget {
  const calculator_screen({super.key});

  @override
  State<calculator_screen> createState() => _calculator_screenState();
}

class _calculator_screenState extends State<calculator_screen> {
  String ara = '';
  String son = '';
  bool isloading = false;
  String selected = "Lütfen bir ürün seçiniz";
  int moduleslength = 0;
  int preslength = 0;
  int matlength = 0;
  double mattl = 0;
  double mateuro = 0;
  double matdolar = 0;
  double matstr = 0;
  List modulesid = [];
  List<String> productname = [];
  void getdata() async {
    isloading = true;
    var product = await FirebaseFirestore.instance
        .collection('products')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("product")
        .get();
    for (var i = 0; i < product.docs.length; i++) {
      var productnames = await FirebaseFirestore.instance
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(product.docs[i].id)
          .get();
      productname.add(productnames.data()!["productname"]);
      var modules = await FirebaseFirestore.instance
          .collection('products')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("product")
          .doc(product.docs[i].id)
          .collection("modules")
          .get();
      moduleslength = modules.docs.length;

      for (var i = 0; i < modules.docs.length; i++) {
        print(modules.docs[i].id + "modül id");
        var pres = await FirebaseFirestore.instance
            .collection('products')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("product")
            .doc(product.docs[i].id)
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
              .doc(product.docs[i].id)
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
    }
    productname.add(selected);
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

  Future productPopup(BuildContext contex) {
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
                      Center(
                        child: DropdownButton<String>(
                            value: selected,
                            items: productname
                                .map((produtname) => DropdownMenuItem<String>(
                                      value: produtname,
                                      child: Text(produtname),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selected = value!;
                              });
                              print(value);
                            }),
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
                              onPressed: () async {},
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

  void Calculate(String x) {
    setState(() {
      if (x == "Ü") {
        productPopup(context);
        x = "25";
      }
      List<String> temizlik = ['C', 'DE', '='];

      if (!temizlik.contains(x) && son != '') {
        ara = son;
        son = '';
        ara += x;
      } else if (!temizlik.contains(x)) {
        ara += x;
      } else if (x == 'DE') {
        if (ara.isNotEmpty) {
          ara = ara.substring(0, ara.length - 1);
        }
      } else if (x == 'C') {
        ara = '';
        son = '';
      } else {
        if (ara.isNotEmpty) {
          Parser parser = Parser();
          Expression e = parser.parse(ara.replaceAll('x', '*'));
          ContextModel cm = ContextModel();
          son = e.evaluate(EvaluationType.REAL, cm).toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 35,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: _getTexts(),
            ),
          ),
          Expanded(
            flex: 65,
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    _getButtons("Ü", 'C', 'DE', '(', ')'),
                    _getButtons("", '7', '8', '9', '/'),
                    _getButtons("", '4', '5', '6', 'x'),
                    _getButtons("", '1', '2', '3', '+'),
                    _getButtons("", '.', '0', '=', '-'),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _getTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          ara,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        Text(
          son,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _getButtons(String t0, String t1, String t2, String t3, String t4) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t0),
                child: Text(t0),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t1),
                child: Text(t1),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t2),
                child: Text(t2),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t3),
                child: Text(t3),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: TextButton(
                onPressed: () => Calculate(t4),
                child: Text(t4),
                style: TextButton.styleFrom(
                  backgroundColor: darkgray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
