//import 'package:agro_a_la_mano_dev/domain/controllers/authentication_controller.dart';
//import 'package:agro_a_la_mano_dev/ui/pages/authentication/signup_page.dart';
import 'package:agro_a_la_mano_dev/controllers/messages_controller.dart';
import 'package:agro_a_la_mano_dev/pages/comentarios_page.dart';
import 'package:agro_a_la_mano_dev/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//estilos, colores, iconos
import 'package:agro_a_la_mano_dev/stylingConstants/color_constants.dart'
as colorCons;
import 'package:agro_a_la_mano_dev/stylingConstants/textStyle_constants.dart'
as textCons;
import 'package:agro_a_la_mano_dev/assets/icons.dart' as Icons_constants;

//Botton Navigation Bar y Navigation Bar personalizados
import 'package:agro_a_la_mano_dev/ui/customBottomNavBar.dart';
import 'package:agro_a_la_mano_dev/ui/customAppBar.dart';




class QuestionHistoryPage extends StatefulWidget {
  const QuestionHistoryPage({Key? key}) : super(key: key);

  final String title = "Historial";

  @override
  _QuestionHistoryPageState createState() => _QuestionHistoryPageState();
}

class _QuestionHistoryPageState extends State<QuestionHistoryPage> {
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

  @override
  onSelectedRow(bool? selected, RowLoc fila) async {
    setState(() {
      if (selected!) {
        filasSeleccionadas.add(fila);
      } else {
        filasSeleccionadas.remove(fila);
      }
    });
  }

  @override
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

  @override
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
                              Container(
                                //width: MediaQuery.of(context).size.width * 0.6,
                                child: TextField(
                                  decoration: InputDecoration(labelText: fila.id, labelStyle: TextStyle(color: Colors.green, fontSize: 22, fontStyle: FontStyle.italic,),),
                                  controller: TextEditingController(text: fila.question),
                                  onChanged: (text) {
                                    fila.question = text;
                                  },
                                ),
                              )
                            ),
                            DataCell(
                              IconButton(
                                icon: Icon(Icons.announcement_outlined),
                                tooltip: 'Conocer mas acerca de...',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ComentariosPage()),
                                  );
                                },
                              ),
                            ),
                          ]),
                )
                .toList(),
          ),
        ], 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(80.0),
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
                  onPressed: () {},
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