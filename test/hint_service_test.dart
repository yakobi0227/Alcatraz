import 'package:flutter_test/flutter_test.dart';
import 'package:alcatraz/models/puzzle_models.dart';
import 'package:alcatraz/services/hint_service.dart';
import 'package:alcatraz/solvers/lock_solver.dart';

void main() {
  late HintService hintService;
  late PuzzleAnalysis testAnalysis;

  setUp(() {
    hintService = HintService();
    final solver = LockSolver();
    testAnalysis = solver.solveExample();
  });

  group('Hint Retrieval', () {
    test('gets hint at specified level', () {
      final hint = hintService.getHint(testAnalysis, HintLevel.hint);
      expect(hint.isNotEmpty, true);
      expect(hint, testAnalysis.hints.hint);
    });

    test('gets nudge at specified level', () {
      final nudge = hintService.getHint(testAnalysis, HintLevel.nudge);
      expect(nudge.isNotEmpty, true);
      expect(nudge, testAnalysis.hints.nudge);
    });

    test('gets full explanation at specified level', () {
      final full = hintService.getHint(testAnalysis, HintLevel.full);
      expect(full.isNotEmpty, true);
      expect(full, testAnalysis.hints.fullExplanation);
    });
  });

  group('Progressive Hints', () {
    test('first attempt returns basic hint', () {
      final hint = hintService.getProgressiveHint(testAnalysis, 1);
      expect(hint, testAnalysis.hints.hint);
    });

    test('second attempt returns nudge', () {
      final hint = hintService.getProgressiveHint(testAnalysis, 2);
      expect(hint, testAnalysis.hints.nudge);
    });

    test('third+ attempt returns full explanation', () {
      final hint1 = hintService.getProgressiveHint(testAnalysis, 3);
      final hint2 = hintService.getProgressiveHint(testAnalysis, 10);
      expect(hint1, testAnalysis.hints.fullExplanation);
      expect(hint2, testAnalysis.hints.fullExplanation);
    });
  });

  group('Available Hints', () {
    test('gets available hint levels from solution', () {
      final solution = testAnalysis.solutions.first;
      final levels = hintService.getAvailableHints(solution);

      expect(levels.contains(HintLevel.hint), true);
      expect(levels.contains(HintLevel.nudge), true);
      expect(levels.contains(HintLevel.full), true);
    });
  });

  group('Hint Formatting', () {
    test('formats hint with emoji', () {
      final formatted = hintService.formatHint('Test hint', HintLevel.hint);
      expect(formatted, contains('💡'));
      expect(formatted, contains('Test hint'));
    });

    test('formats nudge with emoji', () {
      final formatted = hintService.formatHint('Test nudge', HintLevel.nudge);
      expect(formatted, contains('👉'));
      expect(formatted, contains('Test nudge'));
    });

    test('formats full explanation with emoji', () {
      final formatted =
          hintService.formatHint('Test explanation', HintLevel.full);
      expect(formatted, contains('✅'));
      expect(formatted, contains('Test explanation'));
    });
  });

  group('Hint Navigation', () {
    test('hint level has more hints available', () {
      expect(hintService.hasMoreHints(HintLevel.hint), true);
    });

    test('nudge level has more hints available', () {
      expect(hintService.hasMoreHints(HintLevel.nudge), true);
    });

    test('full level has no more hints', () {
      expect(hintService.hasMoreHints(HintLevel.full), false);
    });

    test('gets next hint level from hint', () {
      final next = hintService.getNextHintLevel(HintLevel.hint);
      expect(next, HintLevel.nudge);
    });

    test('gets next hint level from nudge', () {
      final next = hintService.getNextHintLevel(HintLevel.nudge);
      expect(next, HintLevel.full);
    });

    test('returns null for next level after full', () {
      final next = hintService.getNextHintLevel(HintLevel.full);
      expect(next, null);
    });
  });
}
