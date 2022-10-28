// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ListaTransferencia(),
        '/forms': (context) => FormularioTransferencia(),
      },
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  FormularioTransferencia({super.key});

  final TextEditingController _controladorCampoNumConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              onPressed: () {
                CriaTransferencia(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void CriaTransferencia(BuildContext context) {
    final int? numConta = int.tryParse(_controladorCampoNumConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numConta != null && valor != null) {
      final transferenciaCriada = Transferencia(numConta, valor);
      Navigator.pop(context, transferenciaCriada);
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

class ListaTransferencia extends StatefulWidget {
  const ListaTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  final List<Transferencia> _transferencias = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          print('Lista de transferencia');
          print(transferencia);
          return ItenTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.pushNamed(context, '/forms');
          future.then((TransferenciaRecebida) {
            Future.delayed(Duration(milliseconds: 40), () {
              print('Chegou no Then do Future');
              print('$TransferenciaRecebida');
              if (TransferenciaRecebida != null) {
                setState(() {
                  _transferencias.add(TransferenciaRecebida!);
                });
              }
            });
          });
        },
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
