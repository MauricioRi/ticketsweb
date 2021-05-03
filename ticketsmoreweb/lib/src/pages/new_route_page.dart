import 'package:flutter/material.dart';
// import 'package:dropdown_below/dropdown_below.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:ticketsmoreweb/src/repository/repository.dart';

class NewRoutePage extends StatefulWidget {
  @override
  _NewRoutePageState createState() => _NewRoutePageState();
}

class _NewRoutePageState extends State<NewRoutePage> {
  // List<Map<String, TextEditingController>> _subRoutes = [];
  Repository _repository = Repository();
  List<List<String>> _subroutes = [];
  List<Widget> subroutesWidget = [];
  List<DataRow> subroutesWidget2 = [];
  final _keyF1 = GlobalKey<FormState>();
  final _keyF2 = GlobalKey<FormState>();
  String idRoute;
  // List _testList = [
  //   {'no': 1, 'keyword': 'blue'},
  //   {'no': 2, 'keyword': 'black'},
  //   {'no': 3, 'keyword': 'red'}
  // ];
  TextEditingController _controller,
      _controller2,
      _nombre,
      _costom,
      _costo,
      _name,
      _desc;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  // List<DropdownMenuItem> _dropdownTestItems;
  // var _selectedTest, _selectedTest2;

  // List<Map<String, dynamic>> _items //= [];
  //     = [
  //   {
  //     'value': 'boxValue',
  //     'label': 'Box Label',
  //     // 'icon': Icon(Icons.stop),
  //   },
  //   {
  //     'value': 'circleValue',
  //     'label': 'Circle Label',
  //     // 'icon': Icon(Icons.fiber_manual_record),
  //     // 'textStyle': TextStyle(color: Colors.red),
  //   },
  //   {
  //     'value': 'starValue',
  //     'label': 'Star Label',
  //     'enable': false,
  //     // 'icon': Icon(Icons.grade),
  //   },
  // ];
  //
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _costom = TextEditingController();
    _nombre = TextEditingController();
    _costo = TextEditingController();
    _name = TextEditingController();
    _desc = TextEditingController();

    // initConfig();
    // _dropdownTestItems = buildDropdownTestItems(_testList);
  }

  initConfig() async {
    final response = await _repository.getAllGeofences();
    print(response.runtimeType);
    if (response.containsKey("selectG")) {
      // final r = response["selectG"] as List<Map<String, dynamic>>;
      _items = List<Map<String, dynamic>>.from(response["selectG"]);
    } else {
      showError(response["message"]);
    }
  }

  showError(msg) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error al cargar la información de la página'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$msg'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Recargar información'),
              onPressed: () async {
                Navigator.of(context).pop();
                initConfig();
              },
            ),
            TextButton(
              child: Text('Cerrar'),
              onPressed: () async {
                Navigator.of(context).pop();
                // initConfig();
              },
            ),
          ],
        );
      },
    );
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

  _getAllInfo(idRoute) async {
    final response = await _repository.getRoute(idRoute);
    int index = 0;

    if (!response.containsKey("status")) {
      _name.text = response["data"]["Name_route"];
      _desc.text = response["data"]["description"];
    } else {
      index++;
    }

    final response2 = await _repository.getAllSubroutes(idRoute);

    if (response2["status"]) {
      _subroutes = response2["data"];
    } else {
      index++;
    }

    if (index > 0) {
      showDialog(
          context: this.context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: Text("Error al obtener la información"),
                actions: [
                  TextButton(
                      onPressed: () {
                        _getAllInfo(idRoute);
                      },
                      child: Text("Recargar"))
                ],
                content: Text(
                    "Los errores presentados se muestran a continuación: \n\n${response["message"] != null ? response["message"] + "\n\n" : ""}${response2["message"] != null ? response2["message"] : ""}"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments;

    if (arguments != null) {
      _getAllInfo(arguments["id"]);
      idRoute = arguments["id"].toString();

      setState(() {});
    } else {
      initConfig();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar rutas"),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0),
              // width: MediaQuery.of(context).size.width,
              child: Form(
                key: _keyF1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          controller: _name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "El nombre no puede ser vació";
                            }

                            return null;
                          },
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
                          controller: _desc,
                          validator: (value) {
                            if (!value.contains(
                                RegExp(r'^[0-9]+([\.][0-9]{2}){0,1}$'))) {
                              return "El número debe ser entero o a 2 decimales";
                            }
                            return null;
                          },
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
                        onPressed: () {
                          if (!_keyF1.currentState.validate()) return;

                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('¿Desea guardar la información?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Guardar'),
                                    onPressed: () async {
                                      final response = await _repository
                                          .saveRoute(ruta: {
                                        "name": _name.text,
                                        "description": _desc.text
                                      }, subroute: _subroutes);

                                      Navigator.of(context).pop();

                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialog(
                                                title: Text("Aviso"),
                                                content: Text(
                                                    "${response["message"]}"),
                                                actions: [
                                                  response["status"]
                                                      ? TextButton(
                                                          child:
                                                              Text("Aceptar"),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                "home");
                                                          },
                                                        )
                                                      : TextButton(
                                                          child: Text("Cerrar"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                ],
                                              ));
                                      // initConfig();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      // initConfig();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
                key: _keyF2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
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
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Desea eliminar todas las subrutas?'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () async {
                Navigator.of(context).pop();
                subroutesWidget.clear();
                subroutesWidget2.clear();
                _subroutes.clear();
                setState(() {});
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () async {
                Navigator.of(context).pop();
                // initConfig();
              },
            ),
          ],
        );
      },
    );

    // setState(() {
    //   subroutesWidget.removeLast();
    //   subroutesWidget.removeLast();
    // });
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
                validator: (value) {
                  if (value.isEmpty) {
                    return "El nombre no puede ser vació";
                  }

                  return null;
                },
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
              width: MediaQuery.of(context).size.width * 0.15,
              child: _createDropdown(true),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              child: _createDropdown(false),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              child: TextFormField(
                validator: (value) {
                  if (!value.contains(RegExp(r'^[0-9]+([\.][0-9]{2}){0,1}$'))) {
                    return "El número debe ser entero o a 2 decimales";
                  }
                  return null;
                },
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
              width: MediaQuery.of(context).size.width * 0.15,
              child: TextFormField(
                validator: (value) {
                  if (!value.contains(RegExp(r'^[0-9]+([\.][0-9]{2}){0,1}$'))) {
                    return "El número debe ser entero o a 2 decimales";
                  }
                  return null;
                },
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
                        if (!_keyF2.currentState.validate() ||
                            _controller.text == "" ||
                            _controller2.text == "") return;

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
                        if (_subroutes.length > 0) _subroutes?.removeLast();
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
    print(_items);
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
          DataCell(Text(
              "[${i[1]}] - ${(_items.firstWhere((e) => e["value"] == i[1]))["label"]}")),
          DataCell(Text(
              "[${i[2]}] - ${(_items.firstWhere((e) => e["value"] == i[2]))["label"]}")),
          DataCell(Text(i[3])),
          DataCell(Text(i[4]))
        ]));
    }

    _nombre.text = "";
    // _controller.text = "";
    // _controller2.text = "";
    _costom.text = "";
    _costo.text = "";

    subroutesWidget2 = items;
    setState(() {});
  }

  _saveConfiguration() async {}
}
