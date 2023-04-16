import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_selective/cards/product_add_modules_card.dart';
import 'package:warehouse_selective/services/firestoreMethods.dart';

import '../../constants/constants.dart';
import '../../constants/thema_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/inputText.dart';

class add_product_screen extends StatefulWidget {
  final String productid;
  const add_product_screen({super.key, required this.productid});

  @override
  State<add_product_screen> createState() => _add_product_screenState();
}

class _add_product_screenState extends State<add_product_screen> {
  //textedit
  TextEditingController productname = TextEditingController();
  TextEditingController productdes = TextEditingController();
  TextEditingController modulesname = TextEditingController();
  TextEditingController modulesdes = TextEditingController();
  //textedit
  //image
  Uint8List? _image;
  Uint8List? _image1;
  String netimage = "";
  //image
  //variables
  String productuid = "";
  bool isvisibil = false;
  bool isloading = false;
  int controle = 0;
  //variables

  void control() {
    setState(() {
      isloading = true;
    });
    if (widget.productid == "") {
      productuid = const Uuid().v1();
      controle = 0;
    } else {
      productuid = widget.productid;
      controle = 1;
      getdata();
    }
    setState(() {
      isloading = false;
      controle;
    });

    print(productuid);
  }

  void getdata() async {
    setState(() {
      isloading = true;
    });
    var productSnap = await FirebaseFirestore.instance
        .collection("products")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("product")
        .doc(productuid)
        .get();
    productname.text = productSnap.data()!["productname"].toString();
    productdes.text = productSnap.data()!["productdes"].toString();
    netimage = productSnap.data()!["productimage"].toString();

    setState(() {
      isloading = false;
    });
  }

  selectImage(int a, int b) async {
    Uint8List? im;
    try {
      if (b == 1) {
        if (a == 1) {
          im = await pickImage(ImageSource.gallery);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        } else {
          im = await pickImage(ImageSource.camera);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        }
        setState(() {
          _image = im;
        });
      } else {
        if (a == 1) {
          im = await pickImage(ImageSource.gallery);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        } else {
          im = await pickImage(ImageSource.camera);
          if (im == null) {
          } else {
            showsnackbar(
                context,
                "Fotograf yükleniyor işlemlerinize devam edebilirsiniz",
                AnimatedSnackBarType.info);
          }
        }
        setState(() {
          _image1 = im;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future Modulpopop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: width(context),
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    image: _image1 != null
                                        ? DecorationImage(
                                            image: MemoryImage(_image1!),
                                            fit: BoxFit.fitWidth,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/add_product.jpg"),
                                            fit: BoxFit.fitWidth,
                                          )),
                              ),
                              Positioned(
                                top: 45,
                                // bottom: 100,
                                left: 100,
                                child: IconButton(
                                  iconSize: 60,
                                  onPressed: () => imagesecenek(1),
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: silverlake,
                                  ),
                                ),
                              )
                            ],
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
                                  Icons.view_module_rounded,
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
                                  controller: modulesname,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Modül Adı",
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
                                  Icons.view_module_outlined,
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
                                  controller: modulesdes,
                                  cursorColor:
                                      Theme.of(context).primaryColorDark,
                                  decoration: InputDecoration(
                                    labelText: "Modül Açıklaması",
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width(context),
                          height: 40,
                          child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                String modulessid = const Uuid().v1();

                                if (modulesname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen Modül Adı Giriniz",
                                      AnimatedSnackBarType.error);
                                } else {
                                  firestoreservices().productAdd_modules(
                                      modulessid,
                                      modulesname.text,
                                      productuid,
                                      [],
                                      _image1,
                                      modulesdes.text);
                                  Navigator.pop(context);
                                }

                                _image1 = null;
                              },
                              child: Text(
                                "Modul oluştur",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
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

  Future imagesecenek(
    int a,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            const Center(
              child: Icon(
                Icons.linear_scale_outlined,
                color: Colors.black,
                size: 25,
              ),
            ),
            ListTile(
                tileColor: Color.fromARGB(255, 220, 219, 219),
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      if (a == 1) {
                        await selectImage(2, 2);
                      } else if (a == 2) {
                        await selectImage(2, 1);
                      }
                    },
                    child: Center(
                      child: Text("fotograf çek"),
                    ))),
            ListTile(
                title: TextButton(
                    onPressed: () async {
                      print(a);
                      Navigator.pop(context);
                      if (a == 1) {
                        await selectImage(1, 2);
                      } else if (a == 2) {
                        await selectImage(1, 1);
                      }
                    },
                    child: Center(
                      child: Text("Galeriden yükle"),
                    ))),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    control();
  }

  @override
  Widget build(BuildContext context) {
    //thema
    final themeProvider = Provider.of<ThemeProvider>(context);
    //thema
    //query

    //query
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Ürün Oluşturma Ekranı"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: width(context),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: controle == 1
                                ? DecorationImage(
                                    // ignore: prefer_const_constructors
                                    image: netimage != ""
                                        ? NetworkImage(netimage)
                                        : NetworkImage(
                                            "https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg"),
                                    fit: BoxFit.fitWidth,
                                  )
                                : _image != null
                                    ? DecorationImage(
                                        image: MemoryImage(_image!),
                                        fit: BoxFit.fitWidth,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            "assets/add_product.jpg"),
                                        fit: BoxFit.fitWidth,
                                      )),
                      ),
                      Positioned(
                        top: 50,
                        // bottom: 100,
                        left: 134,
                        child: IconButton(
                          iconSize: 60,
                          onPressed: () => imagesecenek(2),
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: silverlake,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Container(
                    height: 50,
                    width: width(context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.chair,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          enabled: !isvisibil ? true : false,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          maxLines: 1,
                          controller: productname,
                          cursorColor: Theme.of(context).primaryColorDark,
                          decoration: InputDecoration(
                            labelText: "Ürün Adı",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Container(
                    height: 100,
                    width: width(context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.chair,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          enabled: !isvisibil ? true : false,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          maxLines: 3,
                          controller: productdes,
                          cursorColor: Theme.of(context).primaryColorDark,
                          decoration: InputDecoration(
                            labelText: "Ürün Açıklaması",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: controle == 0
                      ? !isvisibil
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: width(context),
                                child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  onPressed: () async {
                                    if (productname.text.isEmpty) {
                                      showsnackbar(
                                          context,
                                          "Lütfen Ürün Adını Giriniz",
                                          AnimatedSnackBarType.error);
                                    } else {
                                      await firestoreservices().productCreate(
                                          productuid,
                                          _image,
                                          productname.text,
                                          productdes.text);
                                      showsnackbar(context, "Ürün oluşturuldu",
                                          AnimatedSnackBarType.success);

                                      setState(() {
                                        isvisibil = true;
                                      });
                                    }
                                  },
                                  child: const Text("Ürün Oluştur"),
                                ),
                              ),
                            )
                          : Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: width(context),
                            child: ElevatedButton(
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              onPressed: () async {
                                if (productname.text.isEmpty) {
                                  showsnackbar(
                                      context,
                                      "Lütfen Ürün Adını Giriniz",
                                      AnimatedSnackBarType.error);
                                } else {
                                  await firestoreservices().productupdate(
                                      productuid,
                                      _image,
                                      productname.text,
                                      productdes.text);
                                  showsnackbar(context, "Ürün Güncelleştirildi",
                                      AnimatedSnackBarType.success);

                                  setState(() {
                                    isvisibil = true;
                                  });
                                }
                              },
                              child: const Text("Ürün Güncelleştir"),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 10,
                    child: Container(
                      height: 40,
                      width: width(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                          child: Text(
                        "Modüller",
                        style: TextStyle(fontSize: 20),
                      )),
                    )),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("product")
                      .doc(productuid)
                      .collection("modules")
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
                      height: snapshot.data!.docs.length * 350,
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
                            result = modules_card_product_add_screen(
                              context,
                              snapshot.data!.docs[index].data(),
                              productname.text,
                              productuid,
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
        ),
      ),
      floatingActionButton: !isvisibil
          ? Container()
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: 150,
              height: 40,
              child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () => Modulpopop(),
                  child: Text("Modül oluştur")),
            ),
    );
  }
}
