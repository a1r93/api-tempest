import 'package:flutter/material.dart';

class Monogram extends StatelessWidget {
  final String value;

  const Monogram({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40.0,
        height: 40.0,
        constraints: const BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, shape: BoxShape.circle),
        child: Center(
          child: Transform.translate(
            offset: const Offset(0.0, -1.0),
            child: Text(
              value,
              style:
                  Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ));
  }
}
