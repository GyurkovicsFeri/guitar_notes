import 'package:flutter_test/flutter_test.dart';
import 'package:guitar_notes/tuning.dart';
import 'package:guitar_notes/tuning_service.dart';

void main() {
  group("TuningService", () {
    test('should notify listeners on tuning changes', () {
      var isCalled = false;
      final service = TuningService(tuning: Tunings.standard);
      service.addListener(() {
        isCalled = true;
      });
      service.tuning = Tunings.standard.steppedDown(steps: 1);
      expect(isCalled, equals(true));
    });
  });
}
