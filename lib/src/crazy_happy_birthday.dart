import 'dart:async';
import 'dart:math';

import 'package:crazy_happy_birthday/src/constants.dart';
import 'package:flutter/material.dart';

class CrazyHappyBirthday extends StatefulWidget {
  const CrazyHappyBirthday({
    super.key,
  });

  @override
  _CrazyHappyBirthdayState createState() => _CrazyHappyBirthdayState();
}

class _CrazyHappyBirthdayState extends State<CrazyHappyBirthday> with SingleTickerProviderStateMixin {
  int currentTextIndex = 0;
  double fontSize = 8;
  Color fontColor = Colors.black;
  Color bgColor = Colors.white;
  bool textIsGrowing = true;

  late Timer _fontTimer, _colorTimer;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    startTextGrowingAnimation();
    startColorAnimation();
    _animationController.repeat();
    
    super.initState();
  }

  void startTextGrowingAnimation() {
      _fontTimer = Timer.periodic(
      const Duration(milliseconds: textAnimationDuration), 
      (_) {
        if (mounted) {
          setState(() {
            if (textIsGrowing) {
              fontSize = 42;
            } else {
              fontSize = 8;
            }
            textIsGrowing = !textIsGrowing;

            if (currentTextIndex < happyBirthdayText.length - 1) {
              currentTextIndex++;
            } else {
              currentTextIndex = 0;
            }
          });
        }
      },
    );
  }

  void startColorAnimation() {
      _colorTimer = Timer.periodic(
      const Duration(milliseconds: textAnimationDuration), 
      (_) {
        if (mounted) {
          setState(() {
            final index = Random().nextInt(crazyColors.length);
            setState(() {
              bgColor = crazyColors[index]["bg"]!;
              fontColor = crazyColors[index]["fg"]!;
            });
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _fontTimer.cancel();
    _colorTimer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: Container(
          height: 120,
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: fontSize,
                color: fontColor,
              ), 
              duration: const Duration(milliseconds: textAnimationDuration),
              curve: Curves.linear,
              child: Text(happyBirthdayText[currentTextIndex]), 
            ),
          ),
        ), 
      ),
    );
  }
}