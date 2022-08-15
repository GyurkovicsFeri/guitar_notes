import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'guitar_notes_service.dart';
import 'note.dart';
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
                      TextButton(
                        child: Text(
                          "Standard",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        onPressed: () {
                          context.read<TuningService>().strings = TuningService.getStandardTuning();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "1 step down",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        onPressed: () {
                          context.read<TuningService>().strings = TuningService.getStandardTuning().stepDown(1);
                        },
                      ),
                      TextButton(
                        child: Text(
                          "2 step down",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        onPressed: () {
                          context.read<TuningService>().strings = TuningService.getStandardTuning().stepDown(2);
                        },
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
    if (service.isCorrect(note)) {
      setState(() {
        isCorrect = true;
      });
    } else {
      setState(() {
        isCorrect = false;
      });
    }

    service.nextQuestion();
  }
}
