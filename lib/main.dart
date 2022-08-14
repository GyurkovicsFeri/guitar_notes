import 'package:flutter/material.dart';

import 'guitar_notes_page.dart';
import 'guitar_notes_service.dart';

void main() {
  runApp(const GuitarNotesApp());
}

class GuitarNotesApp extends StatelessWidget {
  const GuitarNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar note training',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: GuitarNotesPage(
        service: GuitarNotesService(
          creation: RandomQuestionCreationStrategy(),
          solver: QuestionSolver(),
        ),
      ),
    );
  }
}
