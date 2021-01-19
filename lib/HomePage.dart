import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  List<String> tokens;
  int luckyNumber;

  @override
  void initState() {
    super.initState();
    this.tokens = List<String>.generate(25, (index) => "empty");
    this.generateNumber();
  }

  generateNumber() {
    int randomNumber = Random().nextInt(tokens.length);
    setState(() {
      this.luckyNumber = randomNumber;
    });
  }

  checkYourDestiny(int index) {
    if (luckyNumber == index) {
      setState(() {
        tokens[index] = "lucky";
      });
    } else {
      setState(() {
        tokens[index] = "unlucky";
      });
    }
  }

  AssetImage getImage(int index) {
    String checkState = tokens[index];
    if (checkState == "lucky")
      return lucky;
    else if (checkState == "unlucky")
      return unlucky;
    else
      return circle;
  }

  resetGame() {
    setState(() {
      tokens = List<String>.filled(tokens.length, "empty");
    });
    generateNumber();
  }

  showAll() {
    setState(() {
      tokens = List<String>.filled(tokens.length, "unlucky");
      tokens[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch & Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: tokens.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    this.checkYourDestiny(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: this.resetGame(),
              child: Text(
                'Reset',
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(20.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: this.showAll(),
              child: Text(
                'Show All',
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
