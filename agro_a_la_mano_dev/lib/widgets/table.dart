import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';

class Tabla extends StatefulWidget {
  const Tabla({Key? key}) : super(key: key);

  final String title = "Historial";

  @override
  _TablaState createState() => _TablaState();
}

class _TablaState extends State<Tabla> {
  bool sort = false;
  List<RowLoc> filas = [];
  List<RowLoc> filasSeleccionadas = [];

  HistoryController histController = Get.find<HistoryController>();

  @override
  void initState() {
    sort = false;
    filas = histController.rows;
    filasSeleccionadas = [];
    super.initState();
  }
  
  onSelectedRow(bool? selected, RowLoc fila) async {
    setState(() {
      if (selected!) {
        filasSeleccionadas.add(fila);
      } else {
        filasSeleccionadas.remove(fila);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (filasSeleccionadas.isNotEmpty) {
        List<RowLoc> temp = [];
        temp.addAll(filasSeleccionadas);
        for (RowLoc fila in temp) {
          filas.remove(fila);
          filasSeleccionadas.remove(fila);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          DataTable(
            sortAscending: sort,
            sortColumnIndex: 0,
            columns: [
              DataColumn(
                  label: Text("Tus preguntas"),
                  numeric: false,
                  tooltip: "This is Question",
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                  }),
              DataColumn(
                  label: Text(""),
                  numeric: false,
                  tooltip: "This is more",
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                  }),
            ],
            rows: filas
                .map(
                  (fila) => DataRow(
                          selected: filasSeleccionadas.contains(fila),
                          onSelectChanged: (b) {
                            String? fila_id = fila.id;
                            print("Onselect $fila_id: $b");
                            onSelectedRow(b, fila);
                          },
                          cells: <DataCell>[
                            DataCell(
                              TextField(
                                decoration: InputDecoration(labelText: fila.id),
                                controller: TextEditingController(text: fila.question),
                                onChanged: (text) {
                                  fila.question = text;
                                },
                              ),
                            ),
                            DataCell(
                              TextButton(
                                onPressed: () {
                                  //Get.to(() => SignUpPage());
                                },
                                child: Text("read more"),
                              )
                            ),
                          ]),
                )
                .toList(),
          ),
        ], 
      ),
    );
  }
}