import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      primaryColor: Colors.deepPurpleAccent,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _output = "";
  double _result = 0.0;
  double _num1;
  double _num2;
  String _operacao;

  void clear() {
    setState(() {
      _output = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operacao = "";
    });
  }


  void _clickButton(textButton) {
    String output = _output + textButton;
    setState(() {
      _output = output;
    });
  }

  void _clickButtonOperator(operatorAr) {
    setState(() {
      if(operatorAr == '='){
        calcula();
      }else if(operatorAr == 'c'){
        clear();
      }else{
        _operacao = operatorAr;
        _num1 = double.parse(_output);
        _output = "";
      }
 
    });
  }

  void calcula() {
    _num2 = double.parse(_output);
    switch(_operacao){
      case 'X':
        _result = _num1 * _num2;
        break;
      case '/':
        _result = _num1 / _num2;
        break;
      case '+':
        _result = _num1 + _num2;
        break;
      case '-':
        _result = _num1 - _num2;
        break;                
    }
  
    setState(() {
      _output = _result.toStringAsFixed(2);
    });
  }

  Widget buildButtonText(String textButton) {
    return Expanded(
      child: FlatButton(
          padding: EdgeInsets.all(24.0),
          child: Text(
            textButton,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 25.0),
          ),
          onPressed: () {
            _clickButton(textButton);
          }),
    );
  }

  Widget buildButtonIcon(IconData icon, Color colorButton) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(24.0),
        child: IconButton(
          icon: Icon(
            icon,
            color: colorButton,
          ),
          onPressed: () {
            _clickButtonOperator("c");
          },
        ),
      ),
    );
  }

  Widget buildButtonOperand(textButton) {
    return Expanded(
      child: FlatButton(
          padding: EdgeInsets.all(24.0),
          child: Text(
            textButton,
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w400,
                fontSize: 25.0),
          ),
          onPressed: () {
            _clickButtonOperator(textButton);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh, color: Colors.white)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: Text(
                  "Calculadora",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
            ),
            ListTile(
              title: Text('Desenvolvedor'),
              leading: Icon(Icons.developer_mode),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(30.0, 110.0, 10.0, 110.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _output,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 30.0),
                  )),
                ],
              )),
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                buildButtonText("7"),
                buildButtonText("8"),
                buildButtonText("9"),
                buildButtonOperand("/"),
                buildButtonIcon(Icons.backspace, Colors.red)
              ],
            ),
            Row(
              children: <Widget>[
                buildButtonText("4"),
                buildButtonText("5"),
                buildButtonText("6"),
                buildButtonOperand("X"),
                buildButtonText(""),
              ],
            ),
            Row(
              children: <Widget>[
                buildButtonText("1"),
                buildButtonText("2"),
                buildButtonText("3"),
                buildButtonOperand("+"),
                buildButtonText(""),
              ],
            ),
            Row(
              children: <Widget>[
                buildButtonText("0"),
                buildButtonText("."),
                buildButtonText(""),
                buildButtonOperand("-"),
                buildButtonOperand("="),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
