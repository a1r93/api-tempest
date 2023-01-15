import 'package:flutter/material.dart';
import 'package:api_tempest/utils/extensions/list_extension.dart';

class Dropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final void Function(T? val) onChanged;

  const Dropdown({required this.label, required this.items, required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).colorScheme.onSurface),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<T>(
            items: items,
            isExpanded: true,
            underline: Container(),
            value: value,
            onChanged: onChanged,
          ),
        ),
      ].withSpaceBetween(height: 8.0),
    );
  }
}
