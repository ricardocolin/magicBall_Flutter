import 'dart:async';
import 'dart:math';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: Text('Ask Me Anything'),
          ),
          body: Ball(),
        ),
      ),
    );

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;
  bool shake = false;

  void changeShake(String note) {
    print(note);
    if (shake) {
      shake = false;
    } else {
      shake = true;
    }
    setState(() {
      print(_start);
      ballNumber = Random().nextInt(4) + 1;
    });
  }

  Timer _timer;
  int _start = 2;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _start = 2;
          setState(() {
            timer.cancel();
          });
        } else {
          changeShake("else");
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    changeShake("dispose");
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Center(
        child: TextButton(
          onPressed: () {
            startTimer();
          },
          child: ShakeAnimatedWidget(
            enabled: shake,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 90),
            curve: Curves.linear,
            child: Image.asset('images/ball$ballNumber.png'),
          ),
        ),
      ),
    );
  }
}
