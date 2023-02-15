import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  BadgeIcon({
    super.key,
    required this.child,
    required this.value,
  });

  final Widget child;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary,
            ),
            constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
