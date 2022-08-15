import 'package:flutter/foundation.dart';
import 'package:guitar_notes/tuning.dart';

class TuningService extends ChangeNotifier {
  Tuning _tuning;

  TuningService({required Tuning tuning}) : _tuning = tuning;

  Tuning get tuning => _tuning;
  set tuning(Tuning value) {
    _tuning = value;
    notifyListeners();
  }
}
