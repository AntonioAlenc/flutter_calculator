import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: CalculadoraHomePage(),
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  @override
  _CalculadoraHomePageState createState() => _CalculadoraHomePageState();
}

class _CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String _expression = '';
  String _result = '0';

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == "=") {
        _calculateResult();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = '0';
    });
  }

  void _backspace() {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    });
  }

  void _calculateResult() {
    try {
      final result = _evaluateExpression(_expression);
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Erro';
      });
    }
  }

  double _evaluateExpression(String expression) {
    List<String> tokens = expression.split(RegExp(r"(\D)"));
    List<String> operators = expression.split(RegExp(r"\d+")).where((s) => s.isNotEmpty).toList();
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i++) {
      double value = double.parse(tokens[i]);
      String op = operators[i - 1];

      switch (op) {
        case '+':
          result += value;
          break;
        case '-':
          result -= value;
          break;
        case '*':
          result *= value;
          break;
        case '/':
          result /= value;
          break;
      }
    }

    return result;
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (text == '=') {
            _calculateResult();
          } else if (text == 'C') {
            _clear();
          } else if (text == '⌫') {
            _backspace();
          } else {
            _onPressed(text);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24),
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
        backgroundColor: Color(0xFF314d4a),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.centerRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              color: Color(0xFF17181f),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            color: Color(0xFF17181f),
          ),
          Divider(color: Colors.white),
          Row(
            children: <Widget>[
              _buildButton('7', Color(0xFF314d4a)),
              _buildButton('8', Color(0xFF314d4a)),
              _buildButton('9', Color(0xFF314d4a)),
              _buildButton('/', Color(0xFF0b8770)),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', Color(0xFF314d4a)),
              _buildButton('5', Color(0xFF314d4a)),
              _buildButton('6', Color(0xFF314d4a)),
              _buildButton('*', Color(0xFF0b8770)),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', Color(0xFF314d4a)),
              _buildButton('2', Color(0xFF314d4a)),
              _buildButton('3', Color(0xFF314d4a)),
              _buildButton('-', Color(0xFF0b8770)),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', Color(0xFF314d4a)),
              _buildButton('.', Color(0xFF314d4a)),
              _buildButton('⌫', Colors.red),
              _buildButton('+', Color(0xFF0b8770)),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('C', Colors.red),
              _buildButton('=', Colors.green),
            ],
          ),
        ],
      ),
      backgroundColor: Color(0xFF17181f),
    );
  }
}
