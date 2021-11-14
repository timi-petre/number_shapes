import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_shapes/consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String title = 'Number Shapes';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Constante consts = Constante(
  textTitle: "Please input a number to see if it's square or triangular.",
  result: '',
);

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();

  final textController = TextEditingController();

  bool isSquare(int n) {
    int root = (pow(n, 0.5)).round();
    return n == pow(root, 2);
  }

  bool isTriangular(int n) {
    int root = (pow(n, 1 / 3)).round();
    return n == pow(root, 3);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                consts.textTitle,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              TextField(
                focusNode: _focusNode,
                style: const TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(),
                controller: textController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          final String value = textController.text;
          final int? intValue = int.tryParse(value);

          setState(() {
            if (!isSquare(intValue!) && isTriangular(intValue)) {
              consts.result = "Triangular".toUpperCase();
            } else if (!isSquare(intValue) && !isTriangular(intValue)) {
              consts.result = "neither SQUARE or TRIANGULAR";
            } else if (isSquare(intValue) && !isTriangular(intValue)) {
              consts.result = "Square".toUpperCase();
            } else if (isSquare(intValue) && isTriangular(intValue)) {
              consts.result = "SQUARE and TRIANGULAR";
            }
            textController.clear();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('$intValue'),
                content: Text('Number $intValue is ${consts.result}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
