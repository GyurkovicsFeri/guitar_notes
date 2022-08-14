import 'package:flutter/material.dart';

import 'guitar_notes_service.dart';

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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.service.currentQuestion.hint,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
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
