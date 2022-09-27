import 'package:crazy_happy_birthday/src/crazy_happy_birthday.dart';
import 'package:flutter/material.dart';

class App extends MaterialApp {
  const App({super.key}) : super(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const CrazyHappyBirthday(),
  );
}