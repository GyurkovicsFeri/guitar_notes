import 'note.dart';
import 'question.dart';

class QuestionSolver {
  Note answer({required Question of}) {
    return Note.values[(Note.values.indexOf(of.string) + of.fret) % Note.values.length];
  }
}
