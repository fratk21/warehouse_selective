import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';

AppBar customAppbar(bool leaing, BuildContext context, Color colors,
    String label, bool hidden, Function()? ontap) {
  return AppBar(
      automaticallyImplyLeading: leaing,
      backgroundColor: colors,
      centerTitle: true,
      actions: [],
      title: Row(
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
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
