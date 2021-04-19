import 'package:flutter/material.dart';

class Rutas extends StatefulWidget {
  Rutas({Key key}) : super(key: key);

  @override
  _RutasState createState() => _RutasState();
}

class _RutasState extends State<Rutas> {
  Map<String, dynamic> _arguments;
  Map<String, dynamic> _response;
  RutasProvider _userProvider = RutasProvider();
  getEarningDay({fecha = ""}) async {
    final response = await _userProvider.getEarningsDetailsDay(
        fecha: _arguments["fecha"].toString());

    if (response["status"]) {
      _response = response;
    } else {
      print(response);
    }

    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Rutas"),
      ),
      body: SingleChildScrollView(
          child: Container(
        //  DataTable(
        //               columnSpacing: 45,
        //               horizontalMargin: 10,
        //               dataRowHeight: 50,
        //               columns: [
        //                 DataColumn(
        //                   label: Text(
        //                     'Fecha',
        //                     style: TextStyle(fontStyle: FontStyle.italic),
        //                   ),
        //                 ),
        //                 // DataColumn(
        //                 //   label: Text(
        //                 //     '',
        //                 //     style: TextStyle(fontStyle: FontStyle.italic),
        //                 //   ),
        //                 // ),
        //                 DataColumn(
        //                   label: Text(
        //                     'Efectivo',
        //                     style: TextStyle(fontStyle: FontStyle.italic),
        //                   ),
        //                 ),
        //                 DataColumn(
        //                   label: Text(
        //                     'TDC/TDD',
        //                     style: TextStyle(fontStyle: FontStyle.italic),
        //                   ),
        //                 ),
        //               ],
        //               rows: _items,
        //             )
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Nombre de ruta ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Minutos totales',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Acciones',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Morelia x charo')),
                DataCell(Text('90')),
                // DataCell(Text('90')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit_location_outlined),
                    tooltip: 'editar subrruta',
                    onPressed: () {
                      setState(() {
                        // _volume += 10;
                        print("subruta elegida");
                      });
                    },
                  ),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('guerrero')),
                DataCell(Text('130')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit_location_outlined),
                    tooltip: 'editar subrruta',
                    onPressed: () {
                      setState(() {
                        // _volume += 10;
                        print("subruta elegida");
                      });
                    },
                  ),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('jalisco x sal salamanca')),
                DataCell(Text('320')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit_location_outlined),
                    tooltip: 'editar subrruta',
                    onPressed: () {
                      setState(() {
                        // _volume += 10;
                        print("subruta elegida");
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
