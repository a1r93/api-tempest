import 'dart:io';

import 'package:api_tempest/screens/configuration/configuration_form_handler.dart';
import 'package:api_tempest/utils/extensions/list_extension.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerButton extends StatelessWidget {
  final String label;
  final String? selectedPath;
  final String? error;
  final void Function(String?, String?) onSelect;
  final void Function(String?)? onError;

  const FilePickerButton(
      {required this.label, required this.selectedPath, required this.onSelect, this.error, this.onError, super.key});

  String? _jsonValidator(JsonFile? value) {
    if (value?.path == null || value!.path!.isEmpty) {
      return 'Please enter a valid file';
    }

    if (value.content == null || value.content!.isEmpty) {
      return null;
    }
    return Helpers.isValidJson(value.content!) ? null : 'Please enter a valid JSON';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['json'],
            );

            if (result != null) {
              File file = File(result.files.single.path!);

              String content;
              try {
                content = await file.readAsString();
              } catch (e) {
                if (onError != null) {
                  onError!('An error occured when reading the file');
                }
                return;
              }
              String? jsonError = _jsonValidator(JsonFile(content: content, path: result.files.single.path));
              if (jsonError != null) {
                if (onError != null) {
                  onError!(jsonError);
                }
                return;
              }

              onSelect(content, result.files.single.path);
            }
          },
          child: Text(label),
        ),
        if (error != null)
          Text(error!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error)),
        if (selectedPath != null) Text(selectedPath!, style: Theme.of(context).textTheme.bodySmall),
      ].withSpaceBetween(height: 8.0),
    );
  }
}
