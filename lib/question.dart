import 'note.dart';

class Question {
  final String hint;
  final Note string;
  final int fret;

  Question({
    required this.string,
    required this.fret,
  }) : hint = '${string.localizedName}$fret';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && string == other.string && fret == other.fret;

  @override
  int get hashCode => string.hashCode ^ fret.hashCode;
}
