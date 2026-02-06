import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app/app_theme.dart';
import 'package:to_do/providers/nav_provider.dart';
import 'package:to_do/services/to_do_service.dart';
import 'app/app.dart';

void main() async {
  await TodoService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavProvider(),
      child: MaterialApp.router(
        title: 'Todo App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.system,
        routerConfig: App.router,
      ),
    );
  }
}
