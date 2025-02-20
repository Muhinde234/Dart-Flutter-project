
import 'dart:math';

import 'package:flutter/material.dart';

void main () => runApp(DiceRollerApp());

class DiceRollerApp extends StatelessWidget {
  const DiceRollerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainApp(
          title: 'Dice Roller',
      ),
    );
  }

}


class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.title});

  final String title;

  @override
  State<MainApp> createState () => _MainAppState();

}


class _MainAppState extends State<MainApp> {
  int _diceRoll = 1;

  void _rollDice() {
    setState(() {
      _diceRoll = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: <Widget>[
            Text('Your dice roll is...'),
            Text(
              '$_diceRoll',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _rollDice,
        tooltip: 'Roll the dice',
        child: Icon(Icons.casino),
      ),
    );
  }

}