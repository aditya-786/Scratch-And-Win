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
    tokens = List<String>.generate(25, (index) => "empty");
  }

  generateNumber() {
    int randomNumber = Random().nextInt(tokens.length);
    setState(() {
      luckyNumber = randomNumber;
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

  getImage(int index) {
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
  }

  showAll() {
    setState(() {
      tokens = List<String>.filled(25, "unlucky");
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

        children:<Widget>[
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
                  onPressed: (){
                    checkYourDestiny(i),
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
