import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import 'dart:convert';

class finance {
  Future<String?> fetchDolar() async {
    try {
      final url = Uri.parse("https://altin.in/");
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);
      final dolar =
          html.querySelectorAll("#dfiy").map((e) => e.innerHtml.trim());
      String dkur = dolar.toString();
      dkur = dkur.substring(1, dkur.length - 3);
      print(dkur);
      return dkur;
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<String?> fetcheuro() async {
    try {
      final url = Uri.parse("https://altin.in/");
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);
      final dolar =
          html.querySelectorAll("#efiy").map((e) => e.innerHtml.trim());
      String dkur = dolar.toString();
      dkur = dkur.substring(1, dkur.length - 3);
      print(dkur);
      return dkur;
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<String?> fetchsterlin() async {
    try {
      final url = Uri.parse("https://altin.in/");
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);
      final dolar =
          html.querySelectorAll("#sfiy").map((e) => e.innerHtml.trim());
      String dkur = dolar.toString();
      dkur = dkur.substring(1, dkur.length - 3);

      return dkur;
    } on Exception catch (e) {
      // TODO
    }
  }
}
