import 'dart:io';

import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CollectionStep extends StatelessWidget {
  const CollectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SteppedCard(
        step: "1",
        title: Helpers.translate(context, 'configuration-screen-card-1-title')!,
        subtitle: Helpers.translate(context, 'configuration-screen-card-1-subtitle')!,
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: Helpers.translate(context, 'configuration-screen-card-1-input-label')!,
            ),
          ),
          Text(Helpers.translate(context, 'or')!, style: Theme.of(context).textTheme.titleMedium),
          OutlinedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );

                if (result != null) {
                  File file = File(result.files.single.path!);
                  print(file);
                } else {
                  // User canceled the picker
                }
              },
              child: Text(Helpers.translate(context, 'configuration-screen-card-1-button-label')!)),
        ]);
  }
}
