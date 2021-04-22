import 'package:flutter/material.dart';
// import 'package:dropdown_below/dropdown_below.dart';
import 'package:select_form_field/select_form_field.dart';

class NewRoutePage extends StatefulWidget {
  @override
  _NewRoutePageState createState() => _NewRoutePageState();
}

class _NewRoutePageState extends State<NewRoutePage> {
  List<Map<String, TextEditingController>> _subRoutes = [];
  List<List<String>> _subroutes = [];
  List<Widget> subroutesWidget = [];
  List<DataRow> subroutesWidget2 = [];
  List _testList = [
    {'no': 1, 'keyword': 'blue'},
    {'no': 2, 'keyword': 'black'},
    {'no': 3, 'keyword': 'red'}
  ];
  TextEditingController _controller, _controller2, _nombre, _costom, _costo;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  // List<DropdownMenuItem> _dropdownTestItems;
  // var _selectedTest, _selectedTest2;

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      // 'icon': Icon(Icons.fiber_manual_record),
      // 'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      // 'icon': Icon(Icons.grade),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _costom = TextEditingController();
    _nombre = TextEditingController();
    _costo = TextEditingController();
    // _dropdownTestItems = buildDropdownTestItems(_testList);
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest, {bool isFirst = true}) {
    print(selectedTest);
    // setState(() {
    //   if (isFirst)
    //     _selectedTest = selectedTest;
    //   else
    //     _selectedTest2 = selectedTest;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar rutas"),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Nombre de la ruta",
                              hintText: "Morelia - Zinapecuaro",
                              suffixIcon:
                                  Icon(Icons.insert_drive_file_rounded)),
                        )),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Distancia de la ruta",
                              hintText: "20 Km",
                              suffixIcon: Icon(Icons.alt_route)),
                        )),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(horizontal: 15.0)),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Guardar"),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.save)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            subroutesWidget.length == 0
                ? Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: MaterialButton(
                        onPressed: _createSubroute,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(" Agregar subruta"),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.add)
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            subroutesWidget.length > 0
                ? Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: MaterialButton(
                        onPressed: _deleteSubroute,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Eliminar Subruta"),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.delete)
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.all(20.0),
              child: Form(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: subroutesWidget,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              width: MediaQuery.of(context).size.width,
              child: subroutesWidget2.length > 0
                  ? DataTable(
                      columns: [
                        DataColumn(label: Text("Nombre de la subruta")),
                        DataColumn(label: Text("Geocerca de inicio")),
                        DataColumn(label: Text("Geocerca de fin")),
                        DataColumn(
                            label: Text("Costo dentro de geocerca final")),
                        DataColumn(label: Text("Costo fuera de geocerca"))
                      ],
                      rows: subroutesWidget2,
                    )
                  : Container(),
            ))
          ],
        ));
  }

  void _deleteSubroute() {
    setState(() {
      subroutesWidget.removeLast();
      subroutesWidget.removeLast();
    });
  }

  _createSubroute() {
    subroutesWidget
      ..add(Container(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: TextFormField(
                controller: _nombre,
                decoration: InputDecoration(
                    labelText: "Nombre de la subruta",
                    hintText: "Zinapecuaro",
                    suffixIcon: Icon(Icons.alt_route)),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: _createDropdown(true),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: _createDropdown(false),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextFormField(
                controller: _costom,
                decoration: InputDecoration(
                    labelText: "Costo minimo",
                    hintText: "\$10",
                    suffixIcon: Icon(Icons.alt_route)),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextFormField(
                controller: _costo,
                decoration: InputDecoration(
                    labelText: "Costo de subruta",
                    hintText: "\$10",
                    suffixIcon: Icon(Icons.alt_route)),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                width: MediaQuery.of(context).size.width * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(horizontal: 15.0)),
                      // ButtonStyle(
                      //   padding: MaterialStateProperty.all<EdgeInsets>(
                      //       EdgeInsets.all(10.0)),
                      //   backgroundColor: MaterialStateProperty.all<Color>(
                      //       Theme.of(context).primaryColor),
                      //   textStyle: MaterialStateProperty.all<TextStyle>(
                      //       TextStyle(color: Colors.white)),
                      // ),
                      onPressed: () {
                        setState(() {
                          _subroutes.add([
                            _nombre.text,
                            _controller.text,
                            _controller2.text,
                            _costom.text,
                            _costo.text
                          ]);
                        });

                        _createSubroutes();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text("Agregar subruta"), Icon(Icons.add)],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(horizontal: 15.0)),
                      onPressed: () {
                        _subroutes.removeLast();
                        _createSubroutes();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Eliminar ultimo"),
                          Icon(Icons.delete_forever)
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ))
      ..add(Divider());

    setState(() {});
  }

  _createDropdown(isFirst) {
    return SelectFormField(
      //type: SelectFormFieldType.dialog,
      controller: isFirst ? _controller : _controller2,
      //initialValue: _initialValue,
      icon: Icon(Icons.format_shapes),
      labelText: isFirst ? 'Geocerca origen' : 'Geocerca destino',
      changeIcon: true,
      dialogTitle: 'Pick a item',
      dialogCancelBtn: 'CANCEL',
      enableSearch: true,
      dialogSearchHint: 'Search item',
      items: _items,
      onChanged: (val) => setState(() => _valueChanged = val),
      validator: (val) {
        setState(() => _valueToValidate = val ?? '');
        return null;
      },
      onSaved: (val) => setState(() => _valueSaved = val ?? ''),
    );
  }

  _createSubroutes() {
    List<DataRow> items = [];

    for (final i in _subroutes) {
      items
        ..add(DataRow(cells: [
          DataCell(Text(i[0])),
          DataCell(Text(i[1])),
          DataCell(Text(i[2])),
          DataCell(Text(i[3])),
          DataCell(Text(i[4]))
        ]));
    }

    subroutesWidget2 = items;
    setState(() {});
  }

  _saveConfiguration() async {}
}
