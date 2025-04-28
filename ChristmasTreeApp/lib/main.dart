import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:christmas_tree/app.dart';
import 'package:christmas_tree/app_state.dart';
import 'package:christmas_tree/services/api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider(create: (_) => ApiService()),
      ],
      child: const ChristmasDecorApp(),
    ),
  );
}