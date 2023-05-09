import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double angle = 0;
  @override
  Widget build(BuildContext context) {
    const cardNumbers = 25;

    List<Widget> cards = [
      for (int index = 0; index < cardNumbers; index++) _card(rotation: index * 360 / cardNumbers, label: index),
    ].reversed.toList();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details) async {
                final dx = details.velocity.pixelsPerSecond.dx.toDouble();
                if (dx.abs() > 50) {
                  setState(() {
                    angle = angle + dx / 50;
                  });
                }
              },
              child: Container(
                color: Colors.amber,
                width: 300,
                height: 50,
                child: const Center(child: Text('Drag here')),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 600,
              height: 600,
              child: AnimatedRotation(
                duration: const Duration(seconds: 5),
                turns: angle / 360,
                child: Center(
                  child: Stack(
                    children: cards,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Transform _card({required double rotation, required int label}) {
    const w = 100.0;
    const h = 200.0;
    const r = 0.9 * h;
    final angle = rotation * 3.1415 / 180;
    return Transform.translate(
      offset: Offset(r * sin(angle), -r * cos(angle)),
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                label.toString(),
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
