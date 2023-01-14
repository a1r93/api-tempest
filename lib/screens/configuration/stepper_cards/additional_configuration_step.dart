import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';

class AdditionalConfigurationStep extends StatelessWidget {
  const AdditionalConfigurationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SteppedCard(
        step: "3",
        title: Helpers.translate(context, 'configuration-screen-card-3-title')!,
        subtitle: Helpers.translate(context, 'configuration-screen-card-3-subtitle')!,
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Helpers.translate(context, 'configuration-screen-card-3-input-label-1')!,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Helpers.translate(context, 'configuration-screen-card-3-input-label-2')!,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  Helpers.translate(context, 'configuration-screen-card-3-input-label-3')!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              Switch(
                value: true,
                onChanged: (value) {
                  print('hello');
                },
              ),
            ],
          )
        ]);
  }
}
