import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'guitar_notes_page.dart';
import 'guitar_notes_service.dart';

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
          create: (_) => TuningService(strings: TuningService.getStandardTuning()),
        ),
        ProxyProvider<TuningService, QuestionCreationStrategy>(
          create: (context) => RandomQuestionCreationStrategy(
            strings: context.read<TuningService>().strings,
          ),
          update: (context, tuningService, creationStrategy) {
            if (creationStrategy is RandomQuestionCreationStrategy) {
              creationStrategy.changeStrings(tuningService.strings);
            }
            return creationStrategy ??
                RandomQuestionCreationStrategy(
                  strings: tuningService.strings,
                );
          },
        ),
        Provider<QuestionSolver>(
          create: (context) => QuestionSolver(),
        ),
        ChangeNotifierProvider<GuitarNotesService>(
          create: (context) => GuitarNotesService(creation: context.read(), solver: context.read()),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Guitar note training',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const GuitarNotesPage(),
      ),
    );
  }
}
