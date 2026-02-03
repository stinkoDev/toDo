import 'package:flutter/material.dart';
import 'package:to_do/widgets/safe_scaffold.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('create screen')],
        ),
      ),
    );
  }
}
