import 'package:flutter_test/flutter_test.dart';
import 'package:alcatraz/main.dart';
import 'package:alcatraz/models/locks/lock.dart';
import 'package:alcatraz/models/ciphers/cipher.dart';
import 'package:alcatraz/models/puzzles/puzzle.dart';

void main() {
  group('Lock Tests', () {
    test('CombinationLock correctly validates combination', () {
      final lock = CombinationLock(
        id: 'test1',
        name: 'Test Lock',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: ['1984'],
        numberOfDigits: 4,
        correctCombination: '1984',
      );

      expect(lock.validate('1984'), true);
      expect(lock.validate('1234'), false);
    });

    test('DirectionalLock correctly validates sequence', () {
      final lock = DirectionalLock(
        id: 'test2',
        name: 'Test Direction Lock',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: ['up', 'down'],
        correctSequence: [Direction.up, Direction.down],
      );

      expect(lock.validate('UP DOWN'), true);
      expect(lock.validate('DOWN UP'), false);
    });

    test('WordLock correctly validates word', () {
      final lock = WordLock(
        id: 'test3',
        name: 'Test Word Lock',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: ['test'],
        wordLength: 4,
        correctWord: 'TEST',
      );

      expect(lock.validate('TEST'), true);
      expect(lock.validate('test'), true); // case insensitive
      expect(lock.validate('FAIL'), false);
    });
  });

  group('Cipher Tests', () {
    test('CaesarCipher correctly decrypts with shift 3', () {
      final cipher = CaesarCipher(
        id: 'test4',
        name: 'Test Caesar',
        description: 'Test',
        encryptedText: 'KHOOR',
        difficulty: Difficulty.easy,
        shift: 3,
      );

      expect(cipher.decrypt(), 'HELLO');
    });

    test('CaesarCipher auto-detects shift', () {
      final cipher = CaesarCipher(
        id: 'test5',
        name: 'Test Caesar Auto',
        description: 'Test',
        encryptedText: 'KHOOR ZRUOG',
        difficulty: Difficulty.easy,
        // No shift provided - should auto-detect
      );

      final result = cipher.decrypt();
      expect(result, contains('HELLO'));
    });

    test('MorseCode correctly decrypts', () {
      final cipher = MorseCode(
        id: 'test6',
        name: 'Test Morse',
        description: 'Test',
        encryptedText: '.... ..',
        difficulty: Difficulty.easy,
      );

      expect(cipher.decrypt(), 'HI');
    });

    test('AtbashCipher correctly decrypts', () {
      final cipher = AtbashCipher(
        id: 'test7',
        name: 'Test Atbash',
        description: 'Test',
        encryptedText: 'GSRH RH Z GVHG',
        difficulty: Difficulty.easy,
      );

      expect(cipher.decrypt(), 'THIS IS A TEST');
    });
  });

  group('Puzzle Tests', () {
    test('PatternPuzzle analyzes arithmetic sequence', () {
      final puzzle = PatternPuzzle(
        id: 'test8',
        name: 'Test Pattern',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: [],
        sequence: [2, 4, 6, 8],
        answer: 10,
      );

      final solution = puzzle.solve();
      expect(solution, contains('Arithmetic'));
    });

    test('PatternPuzzle analyzes geometric sequence', () {
      final puzzle = PatternPuzzle(
        id: 'test9',
        name: 'Test Pattern 2',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: [],
        sequence: [2, 4, 8, 16],
        answer: 32,
      );

      final solution = puzzle.solve();
      expect(solution, contains('Geometric'));
    });

    test('MathPuzzle provides solution', () {
      final puzzle = MathPuzzle(
        id: 'test10',
        name: 'Test Math',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: [],
        equation: '2X + 10 = 30',
        solution: 10,
      );

      final solution = puzzle.solve();
      expect(solution, contains('10'));
    });

    test('Riddle provides hints and answer', () {
      final puzzle = Riddle(
        id: 'test11',
        name: 'Test Riddle',
        description: 'Test',
        difficulty: Difficulty.easy,
        clues: [],
        question: 'What am I?',
        answer: 'Mystery',
      );

      final hints = puzzle.getHints();
      expect(hints.length, greaterThan(0));

      final solution = puzzle.solve();
      expect(solution, contains('Mystery'));
    });
  });

  group('Widget Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const AlcatrazApp());

      expect(find.text('Alcatraz - Escape Room Solver'), findsOneWidget);
    });
  });
}
