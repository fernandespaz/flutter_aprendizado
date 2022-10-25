// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: FormularioTransferencia()));
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            controlador: _controladorCampoNumConta,
            rotulo: 'Numero da conta',
            dica: '0000',
            icone: Icons.edit,
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: 'Valor',
            dica: '0.00',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: CriarTransferencia,
          ),
        ],
      ),
    );
  }

  void CriarTransferencia() {
    // ignore: avoid_print
    print('clicou no confirmar');
    final int? numConta = int.tryParse(_controladorCampoNumConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numConta != null && valor != null) {
      final transferenciaCriada = Transferencia(numConta, valor);
      // ignore: avoid_print
      print(transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  const Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      required this.icone});

//...

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: Column(children: [
        ItenTransferencia(Transferencia(1000, 100.00)),
        ItenTransferencia(Transferencia(2000, 200.00)),
        ItenTransferencia(Transferencia(3000, 300.00)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItenTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItenTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numConta;

  Transferencia(this.numConta, this.valor);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numConta: $numConta}';
  }
}
