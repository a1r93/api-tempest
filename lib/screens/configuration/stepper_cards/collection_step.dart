import 'package:api_tempest/screens/configuration/configuration_form_handler.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/widgets/file_picker_button.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';

class CollectionStep extends StatelessWidget {
  final ConfigurationFormHandler formHandler;

  const CollectionStep({required this.formHandler, super.key});

  @override
  Widget build(BuildContext context) {
    bool urlIsValid = formHandler.collectionUrl.error == null;

    return SteppedCard(
        step: "1",
        title: Helpers.translate(context, 'configuration-screen-card-1-title')!,
        subtitle: Helpers.translate(context, 'configuration-screen-card-1-subtitle')!,
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Helpers.translate(context, 'configuration-screen-card-1-input-label')!,
              helperText: !urlIsValid ? Helpers.translate(context, formHandler.collectionUrl.error!) : null,
            ),
            controller: formHandler.collectionUrl.controller,
            onChanged: (value) {
              formHandler.setValue('collectionUrl', value);
            },
          ),
          Text(Helpers.translate(context, 'or')!, style: Theme.of(context).textTheme.titleMedium),
          FilePickerButton(
            label: Helpers.translate(context, 'configuration-screen-card-1-button-label')!,
            selectedPath: formHandler.collectionFileContent.value?.path,
            onSelect: (value, path) {
              formHandler.setValue('collectionFileContent', value);
            },
            onError: (value) {
              formHandler.setError('collectionFileContent', 'An error occured when reading the file');
            },
          ),
        ]);
  }
}
