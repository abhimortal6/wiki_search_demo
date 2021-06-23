import 'dart:math';

import 'package:flutter/material.dart';

bool toggle = true;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void dispose() {
    super.dispose();
  }

  Alignment alignment1 = Alignment(0.0, 0.0);
  Alignment alignment2 = Alignment(0.0, 0.0);
  Alignment alignment3 = Alignment(0.0, 0.0);
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 50.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 350), reverseDuration: Duration(milliseconds: 275));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut, reverseCurve: Curves.easeOut);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Container(
        height: 250.0,
        width: 250.0,
        color: Colors.white,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 875),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              alignment: alignment1,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size1,
                width: size1,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 875),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              alignment: alignment2,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size2,
                width: size2,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            AnimatedAlign(
              duration: toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 875),
              curve: toggle ? Curves.easeIn : Curves.easeOut,
              alignment: alignment3,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 275),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                height: size3,
                width: size3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Icon(
                  Icons.pending,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 375),
                  height: toggle ? 70.0 : 60.0,
                  width: toggle ? 70.0 : 60.0,
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(color: Colors.yellow[600], borderRadius: BorderRadius.circular(60.0)),
                  child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (toggle) {
                              toggle = !toggle;
                              _controller.forward();
                              Future.delayed(Duration(milliseconds: 10), () {
                                alignment1 = Alignment(-0.7, -0.4);
                                size1 = 50.0;
                              });
                              Future.delayed(Duration(milliseconds: 100), () {
                                alignment2 = Alignment(0.0, -0.4);
                                size1 = 50.0;
                              });
                              Future.delayed(Duration(milliseconds: 200), () {
                                alignment3 = Alignment(0.7, -0.4);
                                size1 = 50.0;
                              });
                            } else {
                              toggle = !toggle;
                              _controller.reverse();
                              alignment1 = Alignment(0.0, 0.0);
                              alignment2 = Alignment(0.0, 0.0);
                              alignment3 = Alignment(0.0, 0.0);
                            }
                          });
                        },
                        icon: Icon(Icons.add),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
