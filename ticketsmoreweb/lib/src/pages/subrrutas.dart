import 'package:flutter/material.dart';

class Subrutas extends StatefulWidget {
  Subrutas({Key key}) : super(key: key);

  @override
  _SubrutasState createState() => _SubrutasState();
}

class _SubrutasState extends State<Subrutas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Subrrutas"),
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
                'Numero de subrruta ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            // DataColumn(
            //   label: Text(
            //     'Nombre de subrruta ',
            //     style: TextStyle(fontStyle: FontStyle.italic),
            //   ),
            // ),
            DataColumn(
              label: Text(
                'GeocercaOrigen',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'GeocercaDestino',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Precio',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Minimo',
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
                DataCell(Text('1')),
                DataCell(Text('zinapecuaro')),
                DataCell(Text('bocanero')),
                DataCell(Text('9')),
                DataCell(Text('7')),
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
                DataCell(Text('2')),
                DataCell(Text('zinapecuaro')),
                DataCell(Text('crucero')),
                DataCell(Text('9')),
                DataCell(Text('6')),
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
                )
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('3')),
                DataCell(Text('zinapecuaro')),
                DataCell(Text('zocalo')),
                DataCell(Text('18')),
                DataCell(Text('15')),
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
                )
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('4')),
                DataCell(Text('zinapecuaro')),
                DataCell(Text('querendaro')),
                DataCell(Text('18')),
                DataCell(Text('7')),
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
                )
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('5')),
                DataCell(Text('zinapecuaro')),
                DataCell(Text('indaparapeo')),
                DataCell(Text('9')),
                DataCell(Text('6')),
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
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
