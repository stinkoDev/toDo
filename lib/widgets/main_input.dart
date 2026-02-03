import 'package:flutter/material.dart';

class MainInput extends StatefulWidget {
  const MainInput({super.key});
  @override
  State<MainInput> createState() => _MainInputState();
}

class _MainInputState extends State<MainInput> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [Text('main Input')]);
  }
}
