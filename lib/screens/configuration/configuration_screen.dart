import 'package:api_tempest/screens/configuration/configuration_container.dart';
import 'package:api_tempest/utils/helpers.dart';
import 'package:api_tempest/utils/theme/dark_theme_provider.dart';
import 'package:api_tempest/widgets/organisms/stepped_card.dart';
import 'package:flutter/material.dart';
import 'package:api_tempest/utils/extensions/list_extension.dart';
import 'package:provider/provider.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/api_tempest_logo_small.png',
              width: 32.0,
              height: 30.0,
            ),
            Text(Helpers.translate(context, 'application-name')!),
          ].withSpaceBetween(width: 16.0),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'English',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
          const SizedBox(width: 16.0),
          Center(
            child: IconButton(
              icon: Icon(themeChange.darkTheme ? Icons.light_mode : Icons.dark_mode),
              iconSize: 32.0,
              onPressed: () {
                themeChange.darkTheme = !themeChange.darkTheme;
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(width >= 905 ? 24.0 : 0.0),
        child: const Center(child: ConfigurationContainer()),
      ),
    );
  }
}
