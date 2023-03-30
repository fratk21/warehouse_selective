import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';

AppBar customAppbar(bool leaing, BuildContext context, Color colors,
    String label, bool hidden, Function()? ontap) {
  return AppBar(
      automaticallyImplyLeading: leaing,
      backgroundColor: colors,
      centerTitle: true,
      actions: [
        TextButton.icon(
            onPressed: ontap,
            icon: Icon(
              Icons.save,
              color: white,
            ),
            label: Text(
              "Kaydet",
              style: TextStyle(color: white),
            )),
      ],
      title: Row(
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          InkWell(
            child: CircleAvatar(
              backgroundColor: colors,
              radius: 20,
              child: const Image(
                image: AssetImage("assets/icons/package.png"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
              text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontSize: kIsWeb ? 25 : 19,
                    fontWeight: FontWeight.bold,
                  )))
        ],
      ));
}
