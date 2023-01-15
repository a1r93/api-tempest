import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/widgets/file_picker_button.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';

class EnvironmentStep extends StatelessWidget {
  const EnvironmentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SteppedCard(
        step: "2",
        title: Helpers.translate(context, 'configuration-screen-card-2-title')!,
        subtitle: Helpers.translate(context, 'configuration-screen-card-2-subtitle')!,
        children: [
          FilePickerButton(label: Helpers.translate(context, 'configuration-screen-card-2-button-label')!),
        ]);
  }
}
