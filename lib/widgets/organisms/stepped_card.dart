import 'package:api_tempest/utils/extensions/list_extension.dart';
import 'package:api_tempest/widgets/monogram/monogram.dart';
import 'package:flutter/material.dart';

class SteppedCard extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const SteppedCard({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12, 4.0, 12.0),
            child: Row(
              children: [
                Monogram(
                  value: step,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ].withSpaceBetween(width: 16.0),
            ),
          ),
          ...children,
        ].withSpaceBetween(height: 16.0),
      ),
    );
  }
}
