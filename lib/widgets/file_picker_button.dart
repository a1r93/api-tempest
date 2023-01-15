import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerButton extends StatelessWidget {
  final String label;

  const FilePickerButton({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['json'],
          );

          if (result != null) {
            File file = File(result.files.single.path!);

            try {
              await file.readAsString();
            } catch (e) {
              rethrow;
            }
          }
        },
        child: Text(label));
  }
}
