import 'package:api_tempest/screens/configuration/configuration_screen.dart';
import 'package:api_tempest/utils/localizations.dart';
import 'package:api_tempest/utils/routes/route_change_observer.dart';
import 'package:api_tempest/utils/routes/routes.dart';
import 'package:api_tempest/utils/theme/color_schemes.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Tempest',
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: Routes.seafarer.navigatorKey,
      onGenerateRoute: Routes.seafarer.generator(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        RouteChangeObserver(),
      ],
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const ConfigurationScreen(),
    );
  }
}
