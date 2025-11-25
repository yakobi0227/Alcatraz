# 🔓 Alcatraz - Escape Room Solver

An app that can solve Escape Rooms and other puzzles for you in seconds!

## 🎯 Overview

Alcatraz is a comprehensive Flutter application designed to help you solve any escape room puzzle with **full hints and complete solutions**. Whether you're stuck on a tricky cipher, can't crack a combination lock, or need help with a riddle, Alcatraz has you covered.

## ✨ Features

### 🔒 **Locks** (3 Types)
- **Combination Locks** - Numeric codes and combinations
  - Analyzes date patterns, mathematical sequences
  - Full hints for finding hidden numbers
- **Directional Locks** - Arrow pad sequences (UP, DOWN, LEFT, RIGHT)
  - Map and pattern analysis
  - Visual flow interpretation
- **Word Locks** - Letter combinations
  - Anagram solving, acrostic patterns
  - First-letter extraction techniques

### 🔐 **Ciphers** (5 Types)
- **Caesar Cipher** - Shift cipher with auto-detection
- **Morse Code** - Dot and dash decryption
- **Atbash Cipher** - Reversed alphabet
- **Pigpen Cipher** - Masonic/geometric symbols
- **Substitution Cipher** - Custom letter mappings

### 🧩 **Puzzles** (6 Types)
- **Pattern Recognition** - Number sequences, visual patterns
- **Math Puzzles** - Equations and calculations
- **Riddles** - Word puzzles and lateral thinking
- **Color Patterns** - Color sequences and codes
- **Sudoku** - Complete solving guide
- **Physical Puzzles** - Jigsaw, sliding puzzles, Rubik's cubes

## 🚀 Quick Start

### Prerequisites
- Flutter 3.0+ installed
- Dart SDK 3.0+

### Installation

```bash
# Clone the repository
git clone https://github.com/yakobi0227/Alcatraz.git
cd Alcatraz

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📖 Usage Examples

### Example 1: Solving a Combination Lock

```dart
import 'package:alcatraz/models/locks/lock.dart';

void main() {
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

  // Get full hints
  for (var hint in lock.getHints()) {
    print(hint);
  }

  // Get complete solution
  print(lock.solve());

  // Verify answer
  print(lock.validate('1984')); // true
}
```

**Output:**
```
HINT 1: Look for numbers in the room - dates, times, quantities
HINT 2: Try birth dates or significant dates from pictures/documents
HINT 3: Count specific objects mentioned in riddles
...

Combination: 1984
Explanation: Found numeric pattern in clues...
```

### Example 2: Decrypting a Caesar Cipher

```dart
import 'package:alcatraz/models/ciphers/cipher.dart';

void main() {
  final cipher = CaesarCipher(
    id: 'wall_message',
    name: 'Encrypted Wall Message',
    encryptedText: 'KHOOR ZRUOG',
    difficulty: Difficulty.easy,
    shift: 3, // or leave null for auto-detection
  );

  print(cipher.decrypt()); // "HELLO WORLD"
  print(cipher.solve());   // Full explanation with hints
}
```

### Example 3: Solving a Pattern Puzzle

```dart
import 'package:alcatraz/models/puzzles/puzzle.dart';

void main() {
  final puzzle = PatternPuzzle(
    id: 'number_sequence',
    name: 'Painting Numbers',
    sequence: [2, 4, 8, 16, 32],
    answer: 64,
    // ... other parameters
  );

  print(puzzle.solve());
  // Output: Analyzes pattern (geometric: ×2) and provides next value
}
```

## 🎓 Prop Types Reference

### Locks

| Type | Description | Common Clues |
|------|-------------|--------------|
| Combination | Numeric codes (3-4 digits) | Dates, times, counts, math equations |
| Directional | Arrow sequences | Maps, picture arrangements, text directions |
| Word | Letter combinations | Anagrams, first letters, riddle answers |

### Ciphers

| Type | Description | How to Identify |
|------|-------------|-----------------|
| Caesar | Letter shift (ROT-N) | Look for shift number clue |
| Morse | Dots and dashes | Blinking lights, audio beeps |
| Atbash | Reversed alphabet | "Reverse" or "opposite" hints |
| Pigpen | Geometric symbols | Tic-tac-toe-like shapes |
| Substitution | Letter mapping | Symbol charts, cipher wheels |

### Puzzles

| Type | Description | Strategy |
|------|-------------|----------|
| Pattern | Number sequences | Find differences/ratios between terms |
| Math | Equations | PEMDAS, solve for variable |
| Riddle | Word puzzles | Lateral thinking, wordplay |
| Color | Color codes | Frequency, resistor codes, custom mappings |
| Sudoku | 9×9 grid | Row/column/box elimination |
| Physical | Manipulation | Systematic approach, edge pieces first |

## 🎯 Hint Levels

Every prop includes **FULL HINTS** at multiple levels:

1. **HINT 1**: Basic approach - what to look for
2. **HINT 2**: Where to find clues in typical rooms
3. **HINT 3**: Common patterns and techniques
4. **HINT 4**: Advanced strategies
5. **HINT 5**: Last resort hints

Plus a **complete solution** with step-by-step explanations!

## 📱 App Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── prop.dart                      # Base prop class and enums
│   ├── locks/
│   │   └── lock.dart                  # All lock types
│   ├── ciphers/
│   │   └── cipher.dart                # All cipher types
│   └── puzzles/
│       └── puzzle.dart                # All puzzle types
├── screens/
│   ├── home_screen.dart               # Main prop selection
│   └── prop_solver_screen.dart        # Individual prop solver
└── examples/
    └── prop_examples.dart             # Usage examples
```

## 🧪 Testing

Run the test suite:

```bash
flutter test
```

Tests cover:
- Lock validation
- Cipher decryption
- Pattern analysis
- Widget functionality

## 🤝 Contributing

Contributions are welcome! To add a new prop type:

1. Extend the appropriate base class (`Lock`, `Cipher`, or `Puzzle`)
2. Implement `solve()` and `getHints()` methods
3. Add comprehensive inline documentation
4. Include examples in `prop_examples.dart`
5. Write tests in `test/`

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details

## 🎮 Real-World Usage Tips

1. **Take Photos**: Document everything before touching it
2. **Work Systematically**: Solve one prop at a time
3. **Combine Clues**: Multiple clues often point to same answer
4. **Check Everywhere**: Numbers/patterns hide in unexpected places
5. **UV Lights**: Many rooms have hidden UV reveals

## 🔗 Resources

- **Caesar Cipher**: [Wikipedia](https://en.wikipedia.org/wiki/Caesar_cipher)
- **Morse Code Chart**: Standard international morse code
- **Pigpen Cipher**: [Guide](https://en.wikipedia.org/wiki/Pigpen_cipher)
- **Escape Room Tips**: General strategy guides

## 👨‍💻 Author

**yakobi0227** (jgquaife@gmail.com)

---

**Ready to escape? Download Alcatraz and never get stuck again! 🎉**
