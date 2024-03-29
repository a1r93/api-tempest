import 'package:api_tempest/screens/configuration/configuration_form_handler.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/widgets/dropdown.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';

class AdditionalConfigurationStep extends StatelessWidget {
  final ConfigurationFormHandler formHandler;

  const AdditionalConfigurationStep({required this.formHandler, super.key});

  @override
  Widget build(BuildContext context) {
    return SteppedCard(
        step: "3",
        title: Helpers.translate(context, 'configuration-screen-card-3-title')!,
        subtitle: Helpers.translate(context, 'configuration-screen-card-3-subtitle')!,
        children: [
          Dropdown(
              label: Helpers.translate(context, 'configuration-screen-card-3-input-label-1')!,
              items: const [
                DropdownMenuItem(value: 1, child: Text('1')),
                DropdownMenuItem(value: 5, child: Text('5')),
                DropdownMenuItem(value: 10, child: Text('10')),
                DropdownMenuItem(value: 25, child: Text('25')),
                DropdownMenuItem(value: 100, child: Text('100')),
              ],
              value: formHandler.nbParallelRequests.value,
              onChanged: (value) {
                formHandler.setValue('nbParallelRequests', value);
              }),
          Dropdown(
              label: Helpers.translate(context, 'configuration-screen-card-3-input-label-2')!,
              items: const [
                DropdownMenuItem(value: 1, child: Text('1')),
                DropdownMenuItem(value: 5, child: Text('5')),
                DropdownMenuItem(value: 10, child: Text('10')),
                DropdownMenuItem(value: 25, child: Text('25')),
                DropdownMenuItem(value: 100, child: Text('100')),
              ],
              value: formHandler.nbIterations.value,
              onChanged: (value) {
                formHandler.setValue('nbIterations', value);
              }),
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
                value: formHandler.ignoreRedirects.value ?? false,
                onChanged: (value) {
                  formHandler.setValue('ignoreRedirects', value);
                },
              ),
            ],
          )
        ]);
  }
}
