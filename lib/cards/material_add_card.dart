import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/services/finance.dart';
import 'package:warehouse_selective/services/firestoreMethods.dart';

import '../screens/add_products/add_material_screen.dart';

class materialadd_card extends StatefulWidget {
  final snap;
  final index;
  const materialadd_card({super.key, required this.snap, required this.index});

  @override
  State<materialadd_card> createState() => _materialadd_cardState();
}

class _materialadd_cardState extends State<materialadd_card> {
  int tvalue = 3;
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
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => add_material_per_screen(
                                snap: widget.snap, index: widget.index),
                          ));
                    },
                    child: Center(
                      child: Text(
                        "Malzeme Düzenle",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ))),
            ListTile(
                tileColor: Theme.of(context).cardColor,
                title: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      firestoreservices().materialdelete(snap);
                    },
                    child: Center(
                      child: Text(
                        "Malzeme Sil",
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
    if (widget.snap["suppliers"][1] == "") {
      tvalue -= 1;
    }
    if (widget.snap["suppliers"][2] == "") {
      tvalue -= 1;
    }
    return InkWell(
      onTap: () {
        secenek(widget.snap);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 40,
                width: width(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(60),
                      topRight: Radius.circular(0)),
                ),
                child: Center(child: Text(widget.snap["materialname"])),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    child: Card(
                      child: Column(
                        children: [
                          Text("Sarfiyat"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.snap["west"]),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    child: Card(
                      child: Column(
                        children: [
                          Text("birim"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.snap["unit"]),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    child: Card(
                      child: Column(
                        children: [
                          Text("tedarikçi sayısı"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(tvalue.toString()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 30,
                width: width(context),
                child: Card(
                  child: Center(child: Text("Tedarikçi ve Malzeme Fiyatı")),
                ),
              ),
              Container(
                height: 30,
                width: width(context),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: widget.snap["suppliers"][1] == ""
                        ? BorderRadius.only(bottomRight: Radius.circular(60))
                        : BorderRadius.all(Radius.zero),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("1. Tedarikçi :" + widget.snap["suppliers"][0]),
                        Text(widget.snap["price"][0] +
                            " " +
                            widget.snap["priceType"][0]),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: widget.snap["suppliers"][1] == "" ? 1 : 30,
                width: width(context),
                child: widget.snap["suppliers"][1] == ""
                    ? Container()
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: widget.snap["suppliers"][2] == ""
                              ? BorderRadius.only(
                                  bottomRight: Radius.circular(60))
                              : BorderRadius.all(Radius.zero),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("2. Tedarikçi :" +
                                  widget.snap["suppliers"][1]),
                              Text(widget.snap["price"][1] +
                                  " " +
                                  widget.snap["priceType"][1]),
                            ],
                          ),
                        ),
                      ),
              ),
              Container(
                height: widget.snap["suppliers"][2] == "" ? 1 : 30,
                width: width(context),
                child: widget.snap["suppliers"][2] == ""
                    ? Container()
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(60)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("3. Tedarikçi :" +
                                  widget.snap["suppliers"][2]),
                              Text(widget.snap["price"][2] +
                                  " " +
                                  widget.snap["priceType"][2]),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
