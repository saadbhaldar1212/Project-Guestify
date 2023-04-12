import 'package:firebase_database/firebase_database.dart';

import 'circular_widget_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfigWidget extends StatefulWidget {
  ConfigWidget({
    Key? key,
    this.config,
    this.valueSetter,
    this.itemsLength,
    this.itemsLengthSetter,
  }) : super(key: key);

  final CircularWidgetConfig? config;
  final void Function(CircularWidgetConfig newConfig)? valueSetter;

  int? itemsLength;
  final void Function(int newValue)? itemsLengthSetter;

  @override
  State<ConfigWidget> createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text(
              '${widget.itemsLength! - 1}',
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
                  onPressed: () =>
                      widget.itemsLengthSetter!(widget.itemsLength! + 1),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: widget.itemsLength == 0
                      ? null
                      : () =>
                          widget.itemsLengthSetter!(widget.itemsLength! - 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
