import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'guitar_notes_service.dart';
import 'note.dart';
import 'tuning.dart';
import 'tuning_service.dart';

class GuitarNotesPage extends StatefulWidget {
  const GuitarNotesPage({Key? key}) : super(key: key);

  @override
  State<GuitarNotesPage> createState() => _GuitarNotesPageState();
}

class _GuitarNotesPageState extends State<GuitarNotesPage> {
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    final question = context.watch<GuitarNotesService>().currentQuestion;
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
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    children: <Widget>[
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(16),
                        onPressed: (int index) {
                          setState(() {
                            if (index == 0) {
                              context.read<TuningService>().tuning = Tunings.standard;
                            }
                            if (index == 1) {
                              context.read<TuningService>().tuning = Tunings.halfStepDown;
                            }
                            if (index == 2) {
                              context.read<TuningService>().tuning = Tunings.wholeStepDown;
                            }
                          });
                        },
                        isSelected: [
                          context.read<TuningService>().tuning == Tunings.standard,
                          context.read<TuningService>().tuning == Tunings.halfStepDown,
                          context.read<TuningService>().tuning == Tunings.wholeStepDown,
                        ],
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Standard",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Half step down",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Whole step down",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    question.hint,
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
    final service = context.read<GuitarNotesService>();
    setState(() {
      isCorrect = service.isCorrect(note);
    });
    service.nextQuestion();
  }
}
