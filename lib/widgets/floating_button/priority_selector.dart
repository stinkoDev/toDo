import 'package:flutter/material.dart';
import 'package:to_do/app/app_theme.dart';

class PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColors = Theme.of(context).extension<PriorityColors>()!;

    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(
          label: Text('High'),
          value: 'high',
          icon: Icon(Icons.label_important_outline),
        ),
        ButtonSegment(
          label: Text('Med'),
          value: 'medium',
          icon: Icon(Icons.label_important_outline),
        ),
        ButtonSegment(
          label: Text('Std'),
          value: 'normal',
          icon: Icon(Icons.label_important_outline),
        ),
      ],
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            switch (selectedPriority) {
              case 'high':
                return priorityColors.high;
              case 'medium':
                return priorityColors.medium;
              case 'normal':
                return Theme.of(context).colorScheme.inversePrimary;
              default:
                return null;
            }
          }
          return Colors.transparent;
        }),
      ),
      selected: {selectedPriority},
      onSelectionChanged: (newSelection) {
        onPriorityChanged(newSelection.first);
      },
    );
  }
}
