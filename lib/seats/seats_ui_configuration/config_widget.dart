import 'circular_widget_config.dart';
import 'package:flutter/material.dart';

class ConfigWidget extends StatelessWidget {
  const ConfigWidget({
    Key? key,
    required this.config,
    required this.valueSetter,
    required this.itemsLength,
    required this.itemsLengthSetter,
  }) : super(key: key);

  final CircularWidgetConfig config;
  final void Function(CircularWidgetConfig newConfig) valueSetter;

  final int itemsLength;
  final void Function(int newValue) itemsLengthSetter;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text(
              '${itemsLength - 1}',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                  onPressed: () => itemsLengthSetter(itemsLength + 1),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: itemsLength == 0
                      ? null
                      : () => itemsLengthSetter(itemsLength - 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
