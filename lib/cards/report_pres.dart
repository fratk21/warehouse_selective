import 'package:flutter/material.dart';

class report_pres extends StatefulWidget {
  final snap;
  const report_pres({super.key, this.snap});

  @override
  State<report_pres> createState() => _report_presState();
}

class _report_presState extends State<report_pres> {
  double max = 0, min = 0, vars = 0;
  void hesapla() {
    for (var i = 0; i < widget.snap["material"].length; i++) {
      max += widget.snap["material"][i]["max"];
      min += widget.snap["material"][i]["min"];
      vars += widget.snap["material"][i]["total"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hesapla();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 2,
      showCheckboxColumn: false,
      border: TableBorder.all(width: 0.2, color: Color.fromARGB(84, 0, 0, 0)),
      columns: [
        DataColumn(
          label: Text('Reçete Adı'),
        ),
        DataColumn(label: Text('Varsayılan M.')),
        DataColumn(label: Text('Min M.')),
        DataColumn(label: Text('Max M.')),
      ],
      rows: List<DataRow>.generate(
        widget.snap.length,
        (index) {
          return DataRow(
            cells: [
              DataCell(Text(widget.snap["prescriptionsname"].toString())),
              DataCell(Text(vars.toString())),
              DataCell(Text(min.toString())),
              DataCell(Text(max.toString())),
            ],
          );
        },
      ),
    );
  }
}
