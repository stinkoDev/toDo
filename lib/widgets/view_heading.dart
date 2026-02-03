import 'package:flutter/material.dart';

class ViewHeading extends StatelessWidget {
  final String title;

  const ViewHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8.0, 10),
              width: double.infinity,
              child: Card(
                surfaceTintColor: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
