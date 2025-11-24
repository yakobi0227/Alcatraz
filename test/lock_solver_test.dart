import 'package:flutter_test/flutter_test.dart';
import 'package:alcatraz/models/puzzle_models.dart';
import 'package:alcatraz/solvers/lock_solver.dart';

void main() {
  late LockSolver solver;

  setUp(() {
    solver = LockSolver();
  });

  group('Roman Numeral Conversion', () {
    test('converts single Roman numerals correctly', () {
      expect(solver.convertRomanToInt('I'), 1);
      expect(solver.convertRomanToInt('V'), 5);
      expect(solver.convertRomanToInt('X'), 10);
      expect(solver.convertRomanToInt('L'), 50);
      expect(solver.convertRomanToInt('C'), 100);
      expect(solver.convertRomanToInt('D'), 500);
      expect(solver.convertRomanToInt('M'), 1000);
    });

    test('converts compound Roman numerals correctly', () {
      expect(solver.convertRomanToInt('II'), 2);
      expect(solver.convertRomanToInt('III'), 3);
      expect(solver.convertRomanToInt('IV'), 4);
      expect(solver.convertRomanToInt('VI'), 6);
      expect(solver.convertRomanToInt('IX'), 9);
      expect(solver.convertRomanToInt('XI'), 11);
    });

    test('converts complex Roman numerals correctly', () {
      expect(solver.convertRomanToInt('XIV'), 14);
      expect(solver.convertRomanToInt('XIX'), 19);
      expect(solver.convertRomanToInt('XLII'), 42);
      expect(solver.convertRomanToInt('XCIX'), 99);
      expect(solver.convertRomanToInt('MCMXC'), 1990);
    });

    test('handles empty string', () {
      expect(solver.convertRomanToInt(''), 0);
    });
  });

  group('Lock Puzzle Solving', () {
    test('solves example puzzle correctly', () {
      final analysis = solver.solveExample();

      expect(analysis.solutions.isNotEmpty, true);
      expect(analysis.solutions.first.finalAnswer, '3792');
      expect(analysis.solutions.first.confidence, 92);
      expect(analysis.puzzleTypes.contains(PuzzleType.lock), true);
    });

    test('returns analysis with identified objects', () {
      final analysis = solver.solveCombinationLock(
        ocr: 'C V I',
        romanNumerals: ['C', 'V', 'I'],
      );

      expect(analysis.identifiedObjects.isNotEmpty, true);
      expect(
        analysis.identifiedObjects.first.label,
        '4-digit combination lock',
      );
      expect(analysis.identifiedObjects.first.category, 'lock');
    });

    test('provides solution steps', () {
      final analysis = solver.solveCombinationLock(
        ocr: 'C V I',
        romanNumerals: ['C', 'V', 'I'],
      );

      expect(analysis.solutions.first.steps.isNotEmpty, true);
      expect(
        analysis.solutions.first.steps.any((s) => s.contains('Roman')),
        true,
      );
    });

    test('includes all hint levels', () {
      final analysis = solver.solveCombinationLock(
        ocr: 'C V I',
        romanNumerals: ['C', 'V', 'I'],
      );

      expect(analysis.hints.hint.isNotEmpty, true);
      expect(analysis.hints.nudge.isNotEmpty, true);
      expect(analysis.hints.fullExplanation.isNotEmpty, true);
    });

    test('provides alternative interpretations', () {
      final analysis = solver.solveCombinationLock(
        ocr: 'C V I',
        romanNumerals: ['C', 'V', 'I'],
      );

      expect(analysis.alternativeInterpretations.isNotEmpty, true);
      expect(
        analysis.alternativeInterpretations.first.confidence,
        lessThan(analysis.solutions.first.confidence),
      );
    });
  });

  group('OCR Analysis', () {
    test('extracts Roman numerals from OCR text', () {
      final analysis = solver.analyzeFromOCR('The code is C V I');

      expect(analysis.solutions.isNotEmpty, true);
    });

    test('handles text with no Roman numerals', () {
      final analysis = solver.analyzeFromOCR('No codes here 123 456');

      expect(analysis.solutions.isEmpty, true);
    });

    test('extracts multiple Roman numerals', () {
      final analysis = solver.analyzeFromOCR('X V I I I');

      expect(analysis.solutions.isNotEmpty, true);
    });
  });

  group('Model Serialization', () {
    test('PuzzleSolution can be serialized and deserialized', () {
      final solution = PuzzleSolution(
        label: 'Test',
        steps: ['Step 1', 'Step 2'],
        finalAnswer: '1234',
        confidence: 95,
        hintLevelAvailable: ['hint', 'nudge', 'full'],
      );

      final json = solution.toJson();
      final deserialized = PuzzleSolution.fromJson(json);

      expect(deserialized.label, solution.label);
      expect(deserialized.steps, solution.steps);
      expect(deserialized.finalAnswer, solution.finalAnswer);
      expect(deserialized.confidence, solution.confidence);
    });

    test('PuzzleAnalysis can be serialized and deserialized', () {
      final analysis = solver.solveExample();

      final json = analysis.toJson();
      final deserialized = PuzzleAnalysis.fromJson(json);

      expect(deserialized.ocr, analysis.ocr);
      expect(deserialized.puzzleTypes, analysis.puzzleTypes);
      expect(deserialized.solutions.length, analysis.solutions.length);
      expect(
        deserialized.solutions.first.finalAnswer,
        analysis.solutions.first.finalAnswer,
      );
    });
  });
}
