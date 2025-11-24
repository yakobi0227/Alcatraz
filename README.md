# Alcatraz

An app that can solve Escape Rooms and other puzzles for you in seconds.

## Features

- **Lock Solver**: Solve combination locks using Roman numeral conversion
- **Progressive Hints**: Get hints at different levels (hint, nudge, full explanation)
- **Camera Integration**: Take photos or upload images of puzzles
- **Confidence Scoring**: Each solution comes with a confidence percentage
- **Alternative Interpretations**: See other possible solutions

## Supported Puzzle Types

- 🔒 **Lock**: Combination locks with numeric or symbolic codes
- 🔐 **Cipher**: Encrypted messages (coming soon)
- 🤔 **Riddle**: Logic puzzles (coming soon)
- 🎨 **Pattern**: Visual pattern recognition (coming soon)
- 🔢 **Math**: Mathematical puzzles (coming soon)
- ⚙️ **Mechanism**: Physical mechanism puzzles (coming soon)

## Architecture

```
lib/
├── models/
│   └── puzzle_models.dart      # Data models for puzzles and solutions
├── solvers/
│   ├── puzzle_solver.dart      # Base solver interface
│   └── lock_solver.dart        # Lock puzzle solver with Roman numeral logic
├── services/
│   └── hint_service.dart       # Hint management system
├── screens/
│   ├── home_screen.dart        # Main screen with camera input
│   └── solution_screen.dart    # Solution display screen
└── main.dart                   # App entry point

test/
├── lock_solver_test.dart       # Tests for lock solver
└── hint_service_test.dart      # Tests for hint service
```

## Lock Solver Example

The lock solver can interpret Roman numerals to solve combination locks:

**Input**: Roman numerals C, V, I
**Process**:
1. Recognize the Roman numerals: C, V, I
2. Convert C=100, V=5, I=1 → 1-0-0-5-1
3. Map to 4-digit lock by summing segments → 3-7-9-2

**Output**: `3792` (92% confidence)

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK

### Installation

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test
```

## Usage

1. Launch the app
2. Select the puzzle type (Lock, Cipher, etc.)
3. Take a photo or upload an image of the puzzle
4. View the solution with step-by-step explanation
5. Use progressive hints if needed

## Testing

The project includes comprehensive tests for:
- Roman numeral conversion
- Lock puzzle solving algorithms
- Hint system functionality
- Model serialization/deserialization

Run tests with:
```bash
flutter test
```

## Future Enhancements

- [ ] OCR integration with Google ML Kit
- [ ] Cipher solver implementation
- [ ] Pattern recognition with image processing
- [ ] Math puzzle solver
- [ ] Multi-language support
- [ ] Puzzle history and favorites
- [ ] Share solutions with friends

## License

MIT License - see LICENSE file for details
