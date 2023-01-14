import 'package:api_tempest/screens/configuration/stepper_cards/additional_configuration_step.dart';
import 'package:api_tempest/screens/configuration/stepper_cards/collection_step.dart';
import 'package:api_tempest/screens/configuration/stepper_cards/environment_step.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:flutter/material.dart';

class ConfigurationContainer extends StatelessWidget {
  const ConfigurationContainer({super.key});

  double _getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return 16.0;
    }

    if (width < 905) {
      return 32.0;
    }

    return 24.0;
  }

  List<Widget> _getCards(BuildContext context) {
    return [
      const CollectionStep(),
      const EnvironmentStep(),
      const AdditionalConfigurationStep(),
      Center(
          child: FilledButton(
        onPressed: () {},
        child: Text(Helpers.translate(context, 'configuration-screen-button-label')!),
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final configurationCards = _getCards(context);

    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(width >= 905 ? 24.0 : 0.0)),
      ),
      child: width < 905
          ? ListView.separated(
              padding: EdgeInsets.all(_getPadding(context)),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: configurationCards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                return configurationCards[index];
              },
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Flexible(
                    child: Row(children: [
                      Flexible(
                        flex: 1,
                        child: Column(children: const [
                          CollectionStep(),
                          SizedBox(height: 24.0),
                          EnvironmentStep(),
                        ]),
                      ),
                      const SizedBox(width: 24.0),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AdditionalConfigurationStep(),
                          ],
                        ),
                      )
                    ]),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Text(Helpers.translate(context, 'configuration-screen-button-label')!),
                  )
                ],
              ),
            ),
    );
  }
}
