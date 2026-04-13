import 'package:conbun_task/screens/home_screen.dart';
import 'package:conbun_task/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/service_provider.dart';


void main() {
  runApp(const ConbunApp());
}

class ConbunApp extends StatelessWidget {
  const ConbunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: MaterialApp(
        title: 'Conbun Pet',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}
