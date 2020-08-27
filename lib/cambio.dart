import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cambio extends StatefulWidget {
  @override
  _CambioState createState() => _CambioState();
}

class _CambioState extends State<Cambio> {
  double _reais;
  double _cotacao;
  String _resultado;
  final TextEditingController _reaisController = TextEditingController();
  final TextEditingController _cotacaoController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();


  void _calcular() {
    if (_reaisController.text.isEmpty || _cotacaoController.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(content: Text("Os campos são obrigatórios")));
      return;
    }

    try {
      setState(() {
        _reais = double.parse(_reaisController.text);
        _cotacao = double.parse(_cotacaoController.text);

        if (_cotacao == 0) {
          key.currentState.showSnackBar(SnackBar(content: Text("Cotação não pode ser 0")));
          return;
        }

        _resultado = (_reais / _cotacao).toStringAsFixed(2);
      });
    } catch (error) {
      key.currentState.showSnackBar(SnackBar(content: Text("Insira valores númericos separados por ponto")));
    }
  }

  void _limpar() {
    _reaisController.clear();
    _cotacaoController.clear();

    setState(() {
      _reais = null;
      _cotacao = null;
      _resultado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          title: Text("Reais para dólares"),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '\$',
                      style: TextStyle(fontSize: 64),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _reaisController,
                      decoration: InputDecoration(
                          labelText: "Valor em reais",
                          alignLabelWithHint: true),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _cotacaoController,
                      decoration: InputDecoration(
                          labelText: "Cotação do dólar",
                          alignLabelWithHint: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(child: Text("Limpar"), onPressed: _limpar),
                          FlatButton(
                              child: Text("Calcular",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: _calcular,
                              color: Colors.teal),
                        ],
                      ),
                    ),
                    if (_resultado != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 24),
                          child: Text(
                              "Com $_reais reais é possível comprar $_resultado dólares a $_cotacao cada",
                              style: TextStyle(fontSize: 24)))
                  ],
                ))));
    ;
  }
}
