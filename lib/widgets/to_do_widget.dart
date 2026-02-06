import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoWidget extends StatefulWidget {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool completion;
  final ValueChanged<bool> onToggle;

  const ToDoWidget({
    super.key,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.completion,
    required this.onToggle,
  });

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy 'at' HH:mm");
    final formattedDate = formatter.format(widget.createdAt.toLocal());

    return Card(
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: widget.completion
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: widget.completion
                ? Theme.of(context).disabledColor
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'created on $formattedDate',
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        leading: Checkbox(
          value: widget.completion,
          onChanged: (bool? value) {
            if (value != null) {
              widget.onToggle(value);
            }
          },
        ),
        onLongPress: () => widget.onToggle(!widget.completion),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black45,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => SafeArea(
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                builder: (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description:'),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        Text(
                                          DateFormat(
                                            "'Created on 'dd/MM/yyyy 'at' HH:mm",
                                          ).format(widget.createdAt),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            _SegmentButton(widget: widget),
                            // FilledButton.icon(
                            //   icon: Icon(
                            //     widget.completion ? Icons.close : Icons.check,
                            //   ),
                            //   label: Text(
                            //     widget.completion
                            //         ? 'Mark not done'
                            //         : 'Mark done',
                            //   ),
                            //   style: FilledButton.styleFrom(
                            //     backgroundColor: Theme.of(
                            //       context,
                            //     ).colorScheme.primary,
                            //     minimumSize: Size(double.infinity, 50),
                            //   ),
                            //   onPressed: () {},
                            // ),
                            // SizedBox(height: 12),
                            // FilledButton.icon(
                            //   icon: Icon(Icons.edit),
                            //   label: Text('Edit'),
                            //   style: FilledButton.styleFrom(
                            //     backgroundColor: Theme.of(
                            //       context,
                            //     ).colorScheme.tertiary,
                            //     minimumSize: Size(double.infinity, 50),
                            //   ),
                            //   onPressed: () {},
                            // ),
                            // SizedBox(height: 12),
                            // FilledButton.icon(
                            //   icon: Icon(Icons.delete),
                            //   label: Text('Delete'),
                            //   style: FilledButton.styleFrom(
                            //     backgroundColor: Theme.of(
                            //       context,
                            //     ).colorScheme.error,
                            //     minimumSize: Size(double.infinity, 50),
                            //   ),
                            //   onPressed: () {},
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final widget;
  const _SegmentButton({required this.widget});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            icon: Icon(Icons.delete),
            label: Text('Delete'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                ),
              ),
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: FilledButton.icon(
            icon: Icon(Icons.edit),
            label: Text('Edit'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only()),
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: FilledButton.icon(
            icon: Icon(widget.completion ? Icons.close : Icons.check),
            label: Text(widget.completion ? 'Mark not done' : 'Mark done'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(50),
                ),
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
