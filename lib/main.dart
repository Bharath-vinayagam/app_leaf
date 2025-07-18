import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'providers/disease_history_provider.dart';
import 'screens/home_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LeafDiseaseApp());
}

class LeafDiseaseApp extends StatelessWidget {
  const LeafDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DiseaseHistoryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Leaf Disease Detector',
            debugShowCheckedModeBanner: false,
            
            // Localization
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
            ],
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            
            // Navigation
            home: const MainNavigationScreen(),
            
            // Route generation
            onGenerateRoute: (settings) {
              // Add route generation logic here
              return null;
            },
          );
        },
      ),
    );
  }
}