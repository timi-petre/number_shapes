import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String title = 'Number Shapes';
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

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();
  final String textTitle =
      "Please input a number to see if it's square or triangular.";
  final textController = TextEditingController();

  bool isSquare(int x) {
    if (x >= 0) {
      double sr = sqrt(x);
      return (sr * sr == x);
    }
    return false;
  }

  bool isTriangular(int z) {
    return (isSquare(8 * z + 1));
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                textTitle,
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
          int rezultat = intValue!;
          setState(() {
            if (intValue != null) {
              textController.clear();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('$intValue'),
                  content: Text('Number $intValue is ${isSquare(rezultat)}'),
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
            }
          });
        },
      ),
    );
  }
}
