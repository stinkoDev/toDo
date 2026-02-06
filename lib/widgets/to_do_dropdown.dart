import 'package:flutter/material.dart';
import 'package:to_do/widgets/custom_divider.dart';

class ToDoDropdown extends StatelessWidget {
  final String selected_1;
  final List<String> options_1;
  final ValueChanged<String?>? onChanged_1;
  final String selected_2;
  final List<String> options_2;
  final ValueChanged<String?>? onChanged_2;

  const ToDoDropdown({
    super.key,
    required this.selected_1,
    required this.options_1,
    required this.onChanged_1,
    required this.selected_2,
    required this.options_2,
    required this.onChanged_2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _ToDoMenu(
              selected_1: selected_1,
              options_1: options_1,
              onChanged_1: onChanged_1,
              selected_2: selected_2,
              options_2: options_2,
              onChanged_2: onChanged_2,
            ),
          );
        },
        child: Text('Sort'),
      ),
    );
  }
}

class _ToDoMenu extends StatelessWidget {
  const _ToDoMenu({
    required this.selected_1,
    required this.options_1,
    required this.onChanged_1,
    required this.selected_2,
    required this.options_2,
    required this.onChanged_2,
  });

  final String selected_1;
  final List<String> options_1;
  final ValueChanged<String?>? onChanged_1;
  final String selected_2;
  final List<String> options_2;
  final ValueChanged<String?>? onChanged_2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 5,
          children: [
            CustomDivider(data: 'Sort by:'),
            _Dropdown(
              icon: Icon(Icons.list),
              selected: selected_1,
              options: options_1,
              onChanged: onChanged_1!,
              width: double.infinity,
            ),
            CustomDivider(data: 'Filter by Priority:'),
            _Dropdown(
              icon: Icon(Icons.sort),
              selected: selected_2,
              options: options_2,
              onChanged: onChanged_2!,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String selected;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final double? width;
  final Widget icon;

  const _Dropdown({
    required this.selected,
    required this.options,
    required this.onChanged,
    this.width,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: width ?? double.infinity,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onPrimary,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.surface,
        ), // Base surface color
        surfaceTintColor: WidgetStateProperty.all(
          Colors.transparent,
        ), // No tint overlay
        shape: WidgetStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      leadingIcon: icon,
      initialSelection: selected,
      dropdownMenuEntries: options.map((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      onSelected: onChanged,
    );
  }
}
