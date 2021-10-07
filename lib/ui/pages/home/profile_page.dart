import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//-------------------------------------------

class User {
  String firstName;
  String lastName;

  User({this.firstName = "", this.lastName = ""});

  static List<User> getUsers() {
    return users;
  }

  static addUsers(firstName, lastName) {
    var user = new User();
    user.firstName = firstName;
    user.lastName = lastName;
    users.add(user);
  }
}

List<User> users = [];

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final String title = "Data Table Flutter Demo";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<User> users = [];
  List<User> selectedUsers = [];
  bool sort = false;

  List<RowLoc> filas = [];
  List<RowLoc> filasSeleccionadas = [];

  HistoryController histController = Get.find<HistoryController>();

  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = User.getUsers();

    filas = histController.rows;
    filasSeleccionadas = [];

    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
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
          MaterialButton(
            child: Text('add button'),
            onPressed: () {
              var user = new User();
              user.firstName = "default question";
              user.lastName = "default answer";
              users.add(user);
              RowLoc registro = new RowLoc(id:"", question:"", questioner:"", answer:"", answerer:"");
              //filas.add(registro);
              histController.addHistoryRegister(registro);
              setState(() {});
              List<RowLoc> filasController = histController.rows;
              print("$filasController");
            },
          ),
          MaterialButton(
            child: Text('print all button'),
            onPressed: () {
              users.forEach((u) => print("${u.firstName} ${u.lastName}"));
            },
          ),
          DataTable(
            sortAscending: sort,
            sortColumnIndex: 0,
            columns: [
              DataColumn(
                  label: Text("Pregunta"),
                  numeric: false,
                  tooltip: "This is Question",
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                    onSortColum(columnIndex, ascending);
                  }),
              DataColumn(
                  label: Text("Respuesta"),
                  numeric: false,
                  tooltip: "This is Answer",
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sort = !sort;
                    });
                    onSortColum(columnIndex, ascending);
                  }),
            ],
            rows: filas
                .map(
                  (fila) => DataRow(
                          selected: filasSeleccionadas.contains(fila),
                          onSelectChanged: (b) {
                            //var bp = b ?? true;
                            String? fila_id = fila.id;
                            print("Onselect $fila_id: $b");
                            onSelectedRow(b, fila);
                          },
                          cells: [
                            DataCell(
                              TextField(
                                decoration: InputDecoration(labelText: fila.id),
                                controller: TextEditingController(text: fila.id),
                                onChanged: (text) {
                                  print("First text field: $text");
                                  fila.id = text;
                                },
                              ),
                            ),
                            DataCell(
                              TextField(
                                onChanged: (text) {
                                  print("Last text field: $text");
                                  fila.question = text;
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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