import 'package:api_tempest/screens/configuration/configuration_screen.dart';
import 'package:api_tempest/utils/localizations.dart';
import 'package:api_tempest/utils/routes/route_change_observer.dart';
import 'package:api_tempest/utils/routes/routes.dart';
import 'package:api_tempest/utils/theme/color_schemes.g.dart';
import 'package:api_tempest/utils/theme/dark_theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    _getCurrentAppTheme();
  }

  void _getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
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
            themeMode: value.darkTheme ? ThemeMode.dark : ThemeMode.light,
            home: const ConfigurationScreen(),
          );
        },
      ),
    );
  }
}
