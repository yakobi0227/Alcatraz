import '../prop.dart';

/// Base class for all lock types
///
/// FULL HINT: Locks are the most common escape room props
/// They typically require finding clues scattered around the room
/// to determine the correct combination or pattern
abstract class Lock extends Prop {
  final Difficulty difficulty;
  final List<String> clues;

  const Lock({
    required super.id,
    required super.name,
    required super.description,
    required this.difficulty,
    required this.clues,
  }) : super(type: PropType.lock);

  /// Validate if a combination is correct
  bool validate(String combination);
}

/// Combination lock (numeric)
///
/// FULL HINT: Look for numbers hidden in:
/// - Dates, times, or calendar references
/// - Book page numbers, ISBN codes
/// - Mathematical equations or sequences
/// - UV light reveals
/// - Phone numbers or addresses
class CombinationLock extends Lock {
  final int numberOfDigits;
  final String correctCombination;

  const CombinationLock({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.numberOfDigits,
    required this.correctCombination,
  });

  @override
  String solve() {
    // Analyze clues to find the combination
    final solution = _analyzeClues();
    return 'Combination: $solution\n\n'
        'Explanation: ${_explainSolution()}';
  }

  String _analyzeClues() {
    // HINT: Common patterns for numeric locks:
    // 1. Birth dates (MMDD, YYYY, DDMM)
    // 2. Sum/product of visible numbers
    // 3. Count of specific objects
    // 4. Alphanumeric conversion (A=1, B=2, etc.)

    for (final clue in clues) {
      // Check for direct numbers
      if (RegExp(r'^\d+$').hasMatch(clue) && clue.length == numberOfDigits) {
        return clue;
      }

      // Extract numbers from text
      final numbers = RegExp(r'\d+').allMatches(clue);
      for (final match in numbers) {
        final num = match.group(0)!;
        if (num.length == numberOfDigits) {
          return num;
        }
      }
    }

    return correctCombination;
  }

  String _explainSolution() {
    return 'Found numeric pattern in clues. '
        'Check dates, counts, or mathematical operations on visible numbers.';
  }

  @override
  bool validate(String combination) {
    return combination == correctCombination;
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Look for numbers in the room - dates, times, quantities',
      'HINT 2: Try birth dates or significant dates from pictures/documents',
      'HINT 3: Count specific objects mentioned in riddles',
      'HINT 4: Check for UV light reveals or hidden numbers',
      'HINT 5: Look at book spines, clocks, or calendars',
    ];
  }
}

/// Directional lock (arrow pad)
///
/// FULL HINT: These locks use UP, DOWN, LEFT, RIGHT movements
/// Common sources:
/// - Maps or floor plans showing a path
/// - Picture arrangements forming arrows
/// - Text with directional words
/// - Patterns that suggest movement
class DirectionalLock extends Lock {
  final List<Direction> correctSequence;

  const DirectionalLock({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.correctSequence,
  });

  @override
  String solve() {
    final sequence = _analyzeDirectionalClues();
    return 'Direction Sequence: ${sequence.map((d) => d.name.toUpperCase()).join(' → ')}\n\n'
        'Explanation: ${_explainSolution()}';
  }

  List<Direction> _analyzeDirectionalClues() {
    // HINT: Look for patterns suggesting movement
    final directions = <Direction>[];

    for (final clue in clues) {
      final lower = clue.toLowerCase();
      if (lower.contains('up') || lower.contains('north') || lower.contains('↑')) {
        directions.add(Direction.up);
      } else if (lower.contains('down') || lower.contains('south') || lower.contains('↓')) {
        directions.add(Direction.down);
      } else if (lower.contains('left') || lower.contains('west') || lower.contains('←')) {
        directions.add(Direction.left);
      } else if (lower.contains('right') || lower.contains('east') || lower.contains('→')) {
        directions.add(Direction.right);
      }
    }

    return directions.isEmpty ? correctSequence : directions;
  }

  String _explainSolution() {
    return 'Follow the directional hints from maps, arrows, or sequential patterns.';
  }

  @override
  bool validate(String combination) {
    final input = combination.toUpperCase().split(' ');
    if (input.length != correctSequence.length) return false;

    for (int i = 0; i < input.length; i++) {
      if (input[i] != correctSequence[i].name.toUpperCase()) {
        return false;
      }
    }
    return true;
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Look for arrows or directional symbols',
      'HINT 2: Check maps or floor plans for a path to follow',
      'HINT 3: Picture arrangements might form directional patterns',
      'HINT 4: Text may contain directional words (up, down, left, right)',
      'HINT 5: Follow visual flow or reading patterns',
    ];
  }
}

/// Word/Letter lock
///
/// FULL HINT: These require spelling out words
/// Common solutions:
/// - Anagrams from scattered letters
/// - First letters of items/pictures
/// - Words from cipher solutions
/// - Hidden words in text
class WordLock extends Lock {
  final int wordLength;
  final String correctWord;

  const WordLock({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.wordLength,
    required this.correctWord,
  });

  @override
  String solve() {
    final word = _analyzeWordClues();
    return 'Word: ${word.toUpperCase()}\n\n'
        'Explanation: ${_explainSolution()}';
  }

  String _analyzeWordClues() {
    // HINT: Common word lock patterns:
    // 1. First letter of each clue spells the word
    // 2. Anagram of highlighted letters
    // 3. Answer to a riddle
    // 4. Word hidden in plain text (acrostic)

    // Try first-letter method
    if (clues.length == wordLength) {
      final firstLetters = clues.map((c) => c.trim()[0]).join().toUpperCase();
      if (firstLetters.length == wordLength) {
        return firstLetters;
      }
    }

    // Try finding exact word matches
    for (final clue in clues) {
      final words = clue.split(RegExp(r'\s+'));
      for (final word in words) {
        final clean = word.replaceAll(RegExp(r'[^a-zA-Z]'), '');
        if (clean.length == wordLength) {
          return clean.toUpperCase();
        }
      }
    }

    return correctWord.toUpperCase();
  }

  String _explainSolution() {
    return 'Check first letters of clues, look for anagrams, or solve the riddle to get the word.';
  }

  @override
  bool validate(String combination) {
    return combination.toUpperCase() == correctWord.toUpperCase();
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Try taking the first letter of each clue or item',
      'HINT 2: Look for highlighted, bold, or unusual letters',
      'HINT 3: The clues might form an anagram',
      'HINT 4: Solve any riddles - the answer might be the word',
      'HINT 5: Check for acrostic patterns in poems or text',
    ];
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}
