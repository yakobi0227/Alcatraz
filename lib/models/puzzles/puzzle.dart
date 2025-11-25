import '../prop.dart';

/// Base class for logic and physical puzzles
///
/// FULL HINT: Puzzles require logical thinking or pattern recognition
abstract class Puzzle extends Prop {
  final Difficulty difficulty;
  final List<String> clues;

  const Puzzle({
    required super.id,
    required super.name,
    required super.description,
    required this.difficulty,
    required this.clues,
  }) : super(type: PropType.puzzle);
}

/// Sudoku Puzzle
///
/// FULL HINT: Fill 9x9 grid so each row, column, and 3x3 box has digits 1-9
/// Strategy:
/// 1. Find cells with only one possible number
/// 2. Check rows/columns/boxes for missing numbers
/// 3. Use process of elimination
class SudokuPuzzle extends Puzzle {
  final List<List<int>> grid; // 0 represents empty cell

  const SudokuPuzzle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.grid,
  });

  @override
  String solve() {
    return 'SUDOKU SOLVING GUIDE:\n\n'
        '1. Start with rows/columns/boxes with most filled cells\n'
        '2. For each empty cell, list possible numbers (1-9)\n'
        '3. Cross out numbers already in that row\n'
        '4. Cross out numbers already in that column\n'
        '5. Cross out numbers already in that 3x3 box\n'
        '6. If only one possibility remains, fill it in\n'
        '7. Repeat until complete\n\n'
        'ADVANCED: Look for "naked pairs" - two cells in same row/col/box with same two possibilities';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Each row must contain digits 1-9 exactly once',
      'HINT 2: Each column must contain digits 1-9 exactly once',
      'HINT 3: Each 3x3 box must contain digits 1-9 exactly once',
      'HINT 4: Start with cells that have fewest possibilities',
      'HINT 5: The final answer might be a specific row, column, or diagonal',
    ];
  }
}

/// Pattern Recognition Puzzle
///
/// FULL HINT: Find the pattern in a sequence
/// Common patterns:
/// - Arithmetic: +2, +2, +2 (add 2 each time)
/// - Geometric: ×2, ×2, ×2 (multiply by 2)
/// - Fibonacci: each number is sum of previous two
/// - Prime numbers, perfect squares, etc.
class PatternPuzzle extends Puzzle {
  final List<dynamic> sequence;
  final dynamic answer;

  const PatternPuzzle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.sequence,
    required this.answer,
  });

  @override
  String solve() {
    final pattern = _analyzePattern();
    return 'Sequence: ${sequence.join(', ')}\n'
        'Pattern: $pattern\n'
        'Next Value: $answer\n\n'
        'Common Patterns to Check:\n'
        '• Arithmetic: constant addition/subtraction\n'
        '• Geometric: constant multiplication/division\n'
        '• Fibonacci: sum of previous two\n'
        '• Squares: 1, 4, 9, 16, 25...\n'
        '• Primes: 2, 3, 5, 7, 11, 13...\n'
        '• Alternating: two interleaved sequences';
  }

  String _analyzePattern() {
    if (sequence.length < 2) return 'Not enough data';

    // Check arithmetic sequence
    if (sequence.every((e) => e is num)) {
      final nums = sequence.cast<num>();
      final diffs = <num>[];
      for (int i = 1; i < nums.length; i++) {
        diffs.add(nums[i] - nums[i - 1]);
      }
      if (diffs.toSet().length == 1) {
        return 'Arithmetic sequence: ${diffs[0] >= 0 ? '+' : ''}${diffs[0]} each step';
      }

      // Check geometric sequence
      final ratios = <double>[];
      for (int i = 1; i < nums.length; i++) {
        if (nums[i - 1] != 0) {
          ratios.add(nums[i] / nums[i - 1]);
        }
      }
      if (ratios.toSet().length == 1) {
        return 'Geometric sequence: ×${ratios[0]} each step';
      }

      // Check Fibonacci
      bool isFib = true;
      for (int i = 2; i < nums.length; i++) {
        if (nums[i] != nums[i - 1] + nums[i - 2]) {
          isFib = false;
          break;
        }
      }
      if (isFib) {
        return 'Fibonacci sequence: each number = sum of previous two';
      }
    }

    return 'Complex pattern - analyze differences or ratios between consecutive terms';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Calculate differences between consecutive numbers',
      'HINT 2: If differences aren\'t constant, try ratios (divide each by previous)',
      'HINT 3: Check if it\'s Fibonacci (each = sum of previous two)',
      'HINT 4: Look for alternating patterns (odd/even positions)',
      'HINT 5: Consider mathematical sequences: squares, primes, factorials',
    ];
  }
}

/// Color/Symbol Pattern Puzzle
///
/// FULL HINT: Visual patterns with colors or symbols
/// Look for:
/// - Repeating sequences
/// - Color mixing (Red + Blue = Purple)
/// - Symbol substitution (each symbol = a number/letter)
class ColorPatternPuzzle extends Puzzle {
  final List<String> colorSequence;
  final Map<String, dynamic>? colorMeanings;

  const ColorPatternPuzzle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.colorSequence,
    this.colorMeanings,
  });

  @override
  String solve() {
    return 'Color Sequence: ${colorSequence.join(' → ')}\n\n'
        'SOLVING STRATEGY:\n'
        '1. Count frequency of each color\n'
        '2. Look for repeating patterns\n'
        '3. Check if colors spell something (R.E.D = first letters)\n'
        '4. Each color might represent a number or direction\n'
        '5. Look for a color key chart in the room\n\n'
        'COMMON COLOR CODES:\n'
        '• Resistor Code: Black=0, Brown=1, Red=2, Orange=3, Yellow=4...\n'
        '• Traffic Light: Red=Stop, Yellow=Caution, Green=Go\n'
        '• Custom: Check walls/books for color=number/letter mapping';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Count how many times each color appears',
      'HINT 2: Colors might represent numbers (look for resistor code chart)',
      'HINT 3: First letters of colors might spell a word',
      'HINT 4: Look for a color key or legend in the room',
      'HINT 5: Pattern might repeat - find the repeating unit',
    ];
  }
}

/// Math Puzzle
///
/// FULL HINT: Solve equations or mathematical problems
/// Types:
/// - Basic algebra (solve for X)
/// - Word problems
/// - Equation systems
/// - Mathematical sequences
class MathPuzzle extends Puzzle {
  final String equation;
  final dynamic solution;

  const MathPuzzle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.equation,
    required this.solution,
  }) : super(type: PropType.mathPuzzle);

  @override
  String solve() {
    return 'Equation: $equation\n'
        'Solution: $solution\n\n'
        'SOLVING STEPS:\n'
        '1. Identify what you\'re solving for (usually X)\n'
        '2. Simplify both sides of the equation\n'
        '3. Get all X terms on one side, numbers on the other\n'
        '4. Combine like terms\n'
        '5. Isolate X by dividing/multiplying\n\n'
        'WORD PROBLEM TIPS:\n'
        '• "more than" = addition\n'
        '• "less than" = subtraction\n'
        '• "times" or "product" = multiplication\n'
        '• "per" or "quotient" = division\n'
        '• "is" or "equals" = =';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Write down what you know and what you need to find',
      'HINT 2: Convert word problems into mathematical equations',
      'HINT 3: Use order of operations: PEMDAS (Parentheses, Exponents, Multiply/Divide, Add/Subtract)',
      'HINT 4: Check your answer by substituting back into the original equation',
      'HINT 5: Numbers in the room might be values for variables',
    ];
  }
}

/// Riddle
///
/// FULL HINT: Word puzzles that require lateral thinking
/// Tips:
/// - Don't take things literally
/// - Consider multiple meanings of words
/// - Think about sounds/homophones
/// - Consider letter patterns or word structure
class Riddle extends Puzzle {
  final String question;
  final String answer;

  const Riddle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.question,
    required this.answer,
  }) : super(type: PropType.riddle);

  @override
  String solve() {
    return 'Riddle: $question\n\n'
        'Answer: $answer\n\n'
        'RIDDLE-SOLVING STRATEGY:\n'
        '1. Read carefully - every word matters\n'
        '2. Look for puns, double meanings, homophones\n'
        '3. Consider what\'s NOT said as much as what IS\n'
        '4. Think metaphorically, not literally\n'
        '5. Classic riddles often have classic answers\n\n'
        'COMMON RIDDLE TYPES:\n'
        '• "What am I?" - describing object/concept\n'
        '• Homophones - sounds like another word\n'
        '• Letter puzzles - what letter/word fits pattern\n'
        '• Logic - requires deductive reasoning';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Read the riddle out loud - it might be a homophone',
      'HINT 2: Consider multiple meanings of each word',
      'HINT 3: The answer is usually simpler than you think',
      'HINT 4: Look for wordplay, puns, or double meanings',
      'HINT 5: If stuck, try thinking of opposites or related concepts',
    ];
  }
}

/// Jigsaw/Physical Puzzle
///
/// FULL HINT: Physically manipulate pieces to form solution
/// Types:
/// - Traditional jigsaw: assemble picture
/// - 3D puzzles: build structure
/// - Tangram: arrange shapes
/// - Sliding puzzles: move tiles to goal state
class PhysicalPuzzle extends Puzzle {
  final PhysicalPuzzleType puzzleType;
  final int pieceCount;

  const PhysicalPuzzle({
    required super.id,
    required super.name,
    required super.description,
    required super.difficulty,
    required super.clues,
    required this.puzzleType,
    required this.pieceCount,
  }) : super(type: PropType.physicalPuzzle);

  @override
  String solve() {
    switch (puzzleType) {
      case PhysicalPuzzleType.jigsaw:
        return _solveJigsaw();
      case PhysicalPuzzleType.sliding:
        return _solveSliding();
      case PhysicalPuzzleType.tangram:
        return _solveTangram();
      case PhysicalPuzzleType.rubiksCube:
        return _solveRubiks();
    }
  }

  String _solveJigsaw() {
    return 'JIGSAW PUZZLE STRATEGY:\n\n'
        '1. Separate edge pieces from middle pieces\n'
        '2. Build the frame first (connect all edges)\n'
        '3. Group pieces by color or pattern\n'
        '4. Work on distinctive areas (faces, text, unique colors)\n'
        '5. The completed image might reveal a code or clue!\n\n'
        'Piece count: $pieceCount';
  }

  String _solveSliding() {
    return 'SLIDING PUZZLE STRATEGY:\n\n'
        '1. Solve top row first, left to right\n'
        '2. Solve left column next, top to bottom\n'
        '3. Work on remaining pieces using algorithms\n'
        '4. Last two rows require specific move sequences\n\n'
        'TIP: Never move a "solved" piece unless absolutely necessary\n'
        'The final configuration might show numbers for a lock!';
  }

  String _solveTangram() {
    return 'TANGRAM STRATEGY:\n\n'
        '1. Identify the target shape (often provided on paper)\n'
        '2. Start with largest pieces first\n'
        '3. All 7 pieces must be used exactly once\n'
        '4. Pieces can be flipped but not overlapped\n'
        '5. Work from corners and edges inward\n\n'
        'The final shape might point to something or spell a letter!';
  }

  String _solveRubiks() {
    return 'RUBIK\'S CUBE STRATEGY:\n\n'
        '1. Solve white cross on one face\n'
        '2. Complete white corners (first layer)\n'
        '3. Solve middle layer edges\n'
        '4. Yellow cross on opposite face\n'
        '5. Orient yellow corners\n'
        '6. Position yellow corners\n'
        '7. Final layer edges\n\n'
        'ESCAPE ROOM TIP: You might not need to solve completely!\n'
        'Look for specific faces showing numbers/letters';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: The completed puzzle reveals the next clue',
      'HINT 2: Work systematically - don\'t randomly try pieces',
      'HINT 3: Look for edge and corner pieces first',
      'HINT 4: The solution might be partial - a specific pattern or section',
      'HINT 5: Take a photo of the starting state - you might need to reference it',
    ];
  }
}

enum PhysicalPuzzleType {
  jigsaw,
  sliding,
  tangram,
  rubiksCube,
}
