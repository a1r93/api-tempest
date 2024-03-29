import 'package:api_tempest/screens/configuration/configuration_form_handler.dart';
import 'package:api_tempest/screens/configuration/stepper_cards/additional_configuration_step.dart';
import 'package:api_tempest/screens/configuration/stepper_cards/collection_step.dart';
import 'package:api_tempest/screens/configuration/stepper_cards/environment_step.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:flutter/material.dart';

class ConfigurationContainer extends StatefulWidget {
  const ConfigurationContainer({super.key});

  @override
  State<ConfigurationContainer> createState() => _ConfigurationContainerState();
}

class _ConfigurationContainerState extends State<ConfigurationContainer> {
  final ConfigurationFormHandler _formHandler = ConfigurationFormHandler();

  @override
  void initState() {
    super.initState();
    _initFormValues();
    _formHandler.addListener(() {
      setState(() {});
    });
  }

  void _initFormValues() {
    _formHandler.nbIterations.value = 1;
    _formHandler.nbParallelRequests.value = 1;
    _formHandler.ignoreRedirects.value = true;
  }

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
      CollectionStep(formHandler: _formHandler),
      EnvironmentStep(formHandler: _formHandler),
      AdditionalConfigurationStep(formHandler: _formHandler),
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
      constraints: BoxConstraints(maxWidth: width < 1440 ? 880 : 905.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
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
          : SingleChildScrollView(
              child: Container(
                height: 540.0,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(children: [
                      Flexible(
                        flex: 1,
                        child: Column(children: [
                          CollectionStep(formHandler: _formHandler),
                          const SizedBox(height: 24.0),
                          EnvironmentStep(formHandler: _formHandler),
                        ]),
                      ),
                      const SizedBox(width: 24.0),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AdditionalConfigurationStep(formHandler: _formHandler),
                          ],
                        ),
                      )
                    ]),
                    FilledButton(
                      onPressed: () {},
                      child: Text(Helpers.translate(context, 'configuration-screen-button-label')!),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _formHandler.dispose();
    super.dispose();
  }
}
