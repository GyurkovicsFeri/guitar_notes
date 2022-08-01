import 'package:flutter/material.dart';

import 'guitar_notes_service.dart';

void main() {
  runApp(const GuitarNotesApp());
}

class GuitarNotesApp extends StatelessWidget {
  const GuitarNotesApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuitarNotesPage(service: GuitarNotesService()),
    );
  }
}

class GuitarNotesPage extends StatefulWidget {
  const GuitarNotesPage({Key? key, required this.service}) : super(key: key);

  final GuitarNotesService service;

  @override
  State<GuitarNotesPage> createState() => _GuitarNotesPageState();
}

class _GuitarNotesPageState extends State<GuitarNotesPage> {
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 350),
        tween: ColorTween(
          end: isCorrect != null
              ? isCorrect == true
                  ? Colors.green
                  : Colors.red
              : Colors.white,
        ),
        builder: (BuildContext context, Color? value, _) {
          return Scaffold(
            backgroundColor: value ?? Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.service.currentQuestion.hint,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (final note in Note.values)
                      TextButton(
                        child: Text(
                          note.localizedName,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        onPressed: () => _onNotePressed(note),
                      ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  _onNotePressed(Note note) {
    if (widget.service.isCorrect(note)) {
      setState(() {
        isCorrect = true;
      });
    } else {
      setState(() {
        isCorrect = false;
      });
    }

    widget.service.nextQuestion();
  }
}
