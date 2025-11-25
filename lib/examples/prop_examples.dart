/// Example usage of all escape room props
///
/// This file demonstrates how to create and solve various escape room props
/// with FULL HINTS provided for each type

import '../models/locks/lock.dart';
import '../models/ciphers/cipher.dart';
import '../models/puzzles/puzzle.dart';

void main() {
  print('🔓 ALCATRAZ - ESCAPE ROOM PROP EXAMPLES\n');
  print('=' * 60);

  // LOCK EXAMPLES
  print('\n📌 LOCK EXAMPLES\n');

  lockExample1();
  lockExample2();
  lockExample3();

  // CIPHER EXAMPLES
  print('\n📌 CIPHER EXAMPLES\n');

  cipherExample1();
  cipherExample2();
  cipherExample3();
  cipherExample4();

  // PUZZLE EXAMPLES
  print('\n📌 PUZZLE EXAMPLES\n');

  puzzleExample1();
  puzzleExample2();
  puzzleExample3();
}

/// Example 1: Combination Lock
/// SCENARIO: You find a 4-digit lock on a safe. There's a calendar on the
/// wall with a date circled: January 9, 1984
void lockExample1() {
  print('\n--- COMBINATION LOCK EXAMPLE ---');

  final lock = CombinationLock(
    id: 'safe_combo',
    name: 'Safe Combination Lock',
    description: '4-digit lock on the office safe',
    difficulty: Difficulty.easy,
    clues: [
      'Calendar shows: January 9, 1984',
      'Photo frame dated 1-9-84',
    ],
    numberOfDigits: 4,
    correctCombination: '1984',
  );

  print('🔒 ${lock.name}');
  print('Description: ${lock.description}');
  print('\nClues found in room:');
  for (var clue in lock.clues) {
    print('  • $clue');
  }

  print('\n💡 Getting hints...');
  for (var hint in lock.getHints()) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(lock.solve());

  print('\nVerification: ${lock.validate("1984") ? "CORRECT! 🎉" : "Wrong..."}');
  print('-' * 60);
}

/// Example 2: Directional Lock
/// SCENARIO: Arrow pad lock. Map on wall shows a treasure path:
/// Start → Go North → Turn East → Continue East → Head South
void lockExample2() {
  print('\n--- DIRECTIONAL LOCK EXAMPLE ---');

  final lock = DirectionalLock(
    id: 'treasure_chest',
    name: 'Treasure Chest Lock',
    description: 'Arrow pad lock with 4 directions',
    difficulty: Difficulty.medium,
    clues: [
      'Map shows path: up to mountain',
      'Then right to river',
      'Right again to cave',
      'Then down to treasure',
    ],
    correctSequence: [
      Direction.up,
      Direction.right,
      Direction.right,
      Direction.down,
    ],
  );

  print('🔒 ${lock.name}');
  print('Description: ${lock.description}');
  print('\nClues found in room:');
  for (var clue in lock.clues) {
    print('  • $clue');
  }

  print('\n💡 Getting hints...');
  for (var hint in lock.getHints()) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(lock.solve());

  print('\nVerification: ${lock.validate("UP RIGHT RIGHT DOWN") ? "CORRECT! 🎉" : "Wrong..."}');
  print('-' * 60);
}

/// Example 3: Word Lock
/// SCENARIO: 7-letter word lock. Clue: first letters of paintings on wall
/// Paintings: "Elegant dancer, Graceful swan, Lovely sunset,
/// Artistic portrait, Nice landscape, Charming cottage, Excellent view"
void lockExample3() {
  print('\n--- WORD LOCK EXAMPLE ---');

  final lock = WordLock(
    id: 'word_safe',
    name: 'Gallery Word Lock',
    description: '7-letter word lock on display case',
    difficulty: Difficulty.medium,
    clues: [
      'Elegant dancer',
      'Graceful swan',
      'Lovely sunset',
      'Artistic portrait',
      'Nice landscape',
      'Charming cottage',
      'Excellent view',
    ],
    wordLength: 7,
    correctWord: 'ELEGANT',
  );

  print('🔒 ${lock.name}');
  print('Description: ${lock.description}');
  print('\nPainting labels in gallery:');
  for (var clue in lock.clues) {
    print('  • $clue');
  }

  print('\n💡 Getting hints...');
  for (var hint in lock.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(lock.solve());

  print('\nVerification: ${lock.validate("ELEGANT") ? "CORRECT! 🎉" : "Wrong..."}');
  print('-' * 60);
}

/// Example 4: Caesar Cipher
/// SCENARIO: Message on wall says "KHOOR ZRUOG"
/// There's a note that says "Julius' favorite number: 3"
void cipherExample1() {
  print('\n--- CAESAR CIPHER EXAMPLE ---');

  final cipher = CaesarCipher(
    id: 'wall_message',
    name: 'Encrypted Wall Message',
    description: 'Strange text written on wall',
    encryptedText: 'KHOOR ZRUOG',
    difficulty: Difficulty.easy,
    shift: 3,
  );

  print('🔐 ${cipher.name}');
  print('Encrypted text: "${cipher.encryptedText}"');
  print('Room clue: "Julius\' favorite number: 3"');

  print('\n💡 Getting hints...');
  for (var hint in cipher.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(cipher.solve());
  print('-' * 60);
}

/// Example 5: Morse Code
/// SCENARIO: Light blinks in pattern, you write it down
void cipherExample2() {
  print('\n--- MORSE CODE EXAMPLE ---');

  final cipher = MorseCode(
    id: 'blinking_light',
    name: 'Blinking Light Signal',
    description: 'Light in corner blinks in pattern',
    encryptedText: '.... . .-.. .--.  -- .',
    difficulty: Difficulty.medium,
  );

  print('🔐 ${cipher.name}');
  print('Pattern observed: "${cipher.encryptedText}"');
  print('(. = short blink, - = long blink, space = pause)');

  print('\n💡 Getting hints...');
  for (var hint in cipher.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(cipher.solve());
  print('-' * 60);
}

/// Example 6: Atbash Cipher
/// SCENARIO: Mirror has text scratched on it: "VZHXV"
void cipherExample3() {
  print('\n--- ATBASH CIPHER EXAMPLE ---');

  final cipher = AtbashCipher(
    id: 'mirror_text',
    name: 'Mirror Message',
    description: 'Text scratched on mirror',
    encryptedText: 'VZHXV',
    difficulty: Difficulty.medium,
  );

  print('🔐 ${cipher.name}');
  print('Text on mirror: "${cipher.encryptedText}"');
  print('Room clue: Poster says "Everything is reversed"');

  print('\n💡 Getting hints...');
  for (var hint in cipher.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(cipher.solve());
  print('-' * 60);
}

/// Example 7: Pigpen Cipher
/// SCENARIO: Strange geometric symbols on a note
void cipherExample4() {
  print('\n--- PIGPEN CIPHER EXAMPLE ---');

  final cipher = PigpenCipher(
    id: 'symbol_note',
    name: 'Mysterious Symbols',
    description: 'Note with geometric symbols',
    encryptedText: '⌐ ⌐⌐ ∟',
    difficulty: Difficulty.hard,
  );

  print('🔐 ${cipher.name}');
  print('Symbols on note: "${cipher.encryptedText}"');
  print('Room clue: Masonic poster on wall');

  print('\n💡 Getting hints...');
  for (var hint in cipher.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(cipher.solve());
  print('-' * 60);
}

/// Example 8: Pattern Puzzle
/// SCENARIO: Numbers on paintings: 2, 4, 8, 16, 32, ?
/// Safe requires 2-digit code
void puzzleExample1() {
  print('\n--- PATTERN PUZZLE EXAMPLE ---');

  final puzzle = PatternPuzzle(
    id: 'number_sequence',
    name: 'Painting Numbers',
    description: 'Numbers visible on painting frames',
    difficulty: Difficulty.easy,
    clues: ['Last painting frame is empty - what number goes there?'],
    sequence: [2, 4, 8, 16, 32],
    answer: 64,
  );

  print('🧩 ${puzzle.name}');
  print('Numbers on frames: ${puzzle.sequence.join(", ")}, ?');

  print('\n💡 Getting hints...');
  for (var hint in puzzle.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(puzzle.solve());
  print('-' * 60);
}

/// Example 9: Math Puzzle
/// SCENARIO: Equation on chalkboard: "2X + 10 = 30"
/// Lock requires 2-digit answer
void puzzleExample2() {
  print('\n--- MATH PUZZLE EXAMPLE ---');

  final puzzle = MathPuzzle(
    id: 'chalkboard_equation',
    name: 'Chalkboard Equation',
    description: 'Equation written on chalkboard',
    difficulty: Difficulty.easy,
    clues: ['Solve for X', 'Answer opens the lock'],
    equation: '2X + 10 = 30',
    solution: 10,
  );

  print('🧩 ${puzzle.name}');
  print('Equation: ${puzzle.equation}');

  print('\n💡 Getting hints...');
  for (var hint in puzzle.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(puzzle.solve());
  print('-' * 60);
}

/// Example 10: Riddle
/// SCENARIO: Note on desk with riddle
void puzzleExample3() {
  print('\n--- RIDDLE EXAMPLE ---');

  final puzzle = Riddle(
    id: 'desk_riddle',
    name: 'Mysterious Riddle',
    description: 'Riddle written on note',
    difficulty: Difficulty.medium,
    clues: ['The answer opens the word lock'],
    question: 'What has keys but no locks, space but no room, and you can enter but can\'t go inside?',
    answer: 'A keyboard',
  );

  print('🧩 ${puzzle.name}');
  print('Riddle: ${puzzle.question}');

  print('\n💡 Getting hints...');
  for (var hint in puzzle.getHints().take(3)) {
    print('  $hint');
  }

  print('\n✅ SOLUTION:');
  print(puzzle.solve());
  print('-' * 60);
}
