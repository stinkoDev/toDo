import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String data;
  const CustomDivider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(data, textScaler: TextScaler.linear(1.5)),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
