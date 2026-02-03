import 'package:flutter/material.dart';
import 'package:to_do/widgets/view_heading.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({super.key});
  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ListTile(title: ViewHeading(title: 'AGENDA test page'))],
    );
  }
}
