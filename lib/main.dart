import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/my_bloc_observer.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/super_fitness_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  Bloc.observer = MyBlocObserver();

  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale("en"),
      child: const SuperFitnessApp(),
    ),
  );
}
