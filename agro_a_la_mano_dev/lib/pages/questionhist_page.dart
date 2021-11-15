import 'package:flutter/material.dart';
import 'package:get/get.dart';

//estilos, colores, iconos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
    as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
    as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/widgets/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/widgets/customAppBar.dart';


import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/data/repositories/models/row_loc_model.dart';
import 'package:agro_a_la_mano_dev/widgets/deletePostButton.dart';

class QuestionHistoryPage extends StatefulWidget {
  const QuestionHistoryPage({Key? key}) : super(key: key);

  final String title = "Historial";

  @override
  _QuestionHistoryPageState createState() => _QuestionHistoryPageState();
}

class _QuestionHistoryPageState extends State<QuestionHistoryPage> {
  bool sort = false;
  List<dynamic> filas = [];
  List<dynamic> filasSeleccionadas = [];

  HistoryController histController = Get.find<HistoryController>();

  @override
  void initState() {
    sort = false;
    filas = histController.rows;
    filasSeleccionadas = [];
    super.initState();
  }

  onSelectedRow(bool? selected, dynamic fila) async {
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
        List<dynamic> temp = [];
        temp.addAll(filasSeleccionadas);
        for (dynamic fila in temp) {
          histController.deleteQuestion(fila.id);
          filas.remove(fila);
          filasSeleccionadas.remove(fila);
        }
      }
    });
  }


  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(  
          children: <Widget>[
            DataTable(
              dataRowHeight: 150,
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
              ],
              rows: filas
                  .map(
                    (fila) => DataRow(
                        selected: filasSeleccionadas.contains(fila),
                        onSelectChanged: (b) {
                          String? fila_id = fila.question;
                          print("Onselect $fila_id: $b");
                          onSelectedRow(b, fila);
                        },
                        cells: <DataCell>[
                          DataCell(
                            SizedBox(
                              width: 300.0,
                              height: 150.0,
                              child: 
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 300.0,
                                        height: 10.0,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: colorCons.GREEN_BUTTON_COLOR,
                                              borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          child: Text(
                                              "Pregunta: ${fila.question}",
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                          ),
                                      ),
                                      SizedBox(
                                        width: 300.0,
                                        height: 10.0,
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            labelText: "Detalles",
                                            labelStyle: TextStyle(
                                              color: Colors.green,
                                              fontSize: 22,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorCons.GREEN_BUTTON_COLOR,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorCons.GREEN_BUTTON_COLOR,
                                              ),
                                              borderRadius: BorderRadius.circular(15.0),
                                            )),
                                        controller:
                                            TextEditingController(text: fila.details),
                                        onChanged: (text) {
                                          fila.details = text;
                                        },
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.report_gmailerrorred_sharp),
                                              tooltip: 'Conocer mas acerca de...',
                                              onPressed: () {
                                                Get.toNamed('/PostPage');
                                              },
                                            ),
                                        ],
                                      )

                                    ],
                                  ),
                              ),
                            ),
                          ),
                        ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCons.BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(79.0),
        child: Container(
          decoration: const BoxDecoration(
            color: colorCons.GREEN_BUTTON_COLOR,
          ),
          child: AppBarContent('Historial'),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('SELECTED ${filasSeleccionadas.length}'),
                  onPressed: () {

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: filasSeleccionadas.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
