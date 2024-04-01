import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState(); 
}

class _MyWidgetState extends State<MyWidget> {
  String _info = "Informe os valores:";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  void _resetFields() {
    etanolController.text = "";
    gasolinaController.text = "";
    setState(() {
      _info = "Informe os valores:";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calcular() {
    setState(() {
      double etanol = double.parse(etanolController.text);
      double gasolina = double.parse(gasolinaController.text);
      double resultado = (etanol/gasolina);
      if (resultado > .70) {
        _info = "Percentual : ${resultado.toStringAsPrecision(3)} \n\n Vale a pena abastecer com Gasolina.";
      } else {
        _info = "Percentual : ${resultado.toStringAsPrecision(3)} \n\n Vale a pena abastecer com Etanol.";
      }
    });
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Gasolina ou Etanol?"), 
          centerTitle: true,
          backgroundColor: Color.fromARGB(136, 95, 90, 90),
          actions: <Widget>[
            IconButton(onPressed: _resetFields, icon: const Icon(Icons.car_crash))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.car_repair,
                  size: 120.0, color: Colors.black),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Etanol",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: etanolController,
                    validator: (value) {
                      if (value! .isEmpty) {
                        return 'Informe o valor do Etanol!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Gasolina",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: gasolinaController,
                    validator: (value) {
                      if (value! .isEmpty) {
                        return "Informe o valor da Gasolina!";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calcular();
                        }
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      )),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )
              ],
            )),
        ),
      )
    );
  }
}