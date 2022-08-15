import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'guitar_notes_page.dart';
import 'guitar_notes_service.dart';
import 'question_creation_strategy.dart';
import 'question_solver.dart';
import 'tuning.dart';
import 'tuning_service.dart';

void main() {
  runApp(const GuitarNotesApp());
}

class GuitarNotesApp extends StatelessWidget {
  const GuitarNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TuningService>(
          create: (_) => TuningService(tuning: Tunings.standard),
        ),
        ProxyProvider<TuningService, QuestionCreationStrategy>(
          create: (context) => RandomQuestionCreationStrategy(
            strings: context.read<TuningService>().tuning.strings,
          ),
          update: (context, tuningService, creationStrategy) {
            return RandomQuestionCreationStrategy(
              strings: tuningService.tuning.strings,
            );
          },
        ),
        Provider<QuestionSolver>(
          create: (context) => QuestionSolver(),
        ),
        ChangeNotifierProxyProvider<QuestionCreationStrategy, GuitarNotesService>(
          create: (context) => GuitarNotesService(creation: context.read(), solver: context.read()),
          update: ((context, value, previous) => GuitarNotesService(creation: value, solver: context.read())),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Guitar note training',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          useMaterial3: true,
        ),
        home: const GuitarNotesPage(),
      ),
    );
  }
}
