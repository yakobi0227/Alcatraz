# 🔓 Alcatraz - Escape Room Puzzle Solver

An intelligent app that can solve escape room puzzles, riddles, ciphers, and logic challenges in seconds.

## Features

Alcatraz can analyze and solve:

- **Ciphers**: Caesar, Atbash, Base64, Morse Code, Substitution
- **Riddles**: Word puzzles, lateral thinking problems
- **Math Puzzles**: Equations, calculations, combinations
- **Patterns**: Arithmetic sequences, geometric sequences
- **Anagrams**: Letter rearrangement puzzles
- **Logic Puzzles**: Deductive reasoning challenges
- **Wordplay**: Puns, homophones, double meanings

## Installation

```bash
# Clone the repository
git clone https://github.com/yakobi0227/Alcatraz.git
cd Alcatraz

# No external dependencies needed! Uses Python standard library only
python3 --version  # Requires Python 3.6+
```

## Usage

### Command Line Interface

```bash
python3 escape_solver.py '<puzzle>' [context] [hint_level]
```

**Parameters:**
- `puzzle` (required): The puzzle text to solve
- `context` (optional): Context about the room or previous puzzles
- `hint_level` (optional): Level of help - "hint", "nudge", or "full" (default: "hint")

### Examples

**Caesar Cipher:**
```bash
python3 escape_solver.py 'KHOOR ZRUOG'
```

**Morse Code:**
```bash
python3 escape_solver.py '.... . .-.. .-.. --- / .-- --- .-. .-.. -..'
```

**Base64:**
```bash
python3 escape_solver.py 'VGhlIGtleSBpcyB1bmRlciB0aGUgbWF0'
```

**Number Pattern:**
```bash
python3 escape_solver.py 'What comes next: 2, 4, 6, 8, ?' '' 'full'
```

**Riddle:**
```bash
python3 escape_solver.py "I have keys but no locks. I have space but no room. You can enter but can't go outside. What am I?" "Mysterious voice" "nudge"
```

### Running Examples

Test the solver with pre-built examples:

```bash
python3 examples.py
```

## Python API

You can also use Alcatraz programmatically:

```python
from escape_solver import EscapeRoomSolver

solver = EscapeRoomSolver()

result = solver.solve(
    puzzle=".... . .-.. .-.. ---",
    context="Found in the radio room",
    hint_level="full"
)

print(result['solutions'][0]['final_answer'])  # HELLO
```

## Output Format

Alcatraz returns a JSON object with:

```json
{
  "puzzle_types": ["caesar_cipher", "..."],
  "analysis": "The puzzle appears to be...",
  "solutions": [
    {
      "label": "Caesar Cipher (shift 3)",
      "steps": ["1. Identify...", "2. Try shifts...", "3. Decode..."],
      "final_answer": "HELLO WORLD",
      "confidence": 0.95,
      "hint_level_available": ["hint", "nudge", "full_explanation"]
    }
  ],
  "alternative_interpretations": [
    {
      "description": "Could be a substitution cipher",
      "confidence": 0.3
    }
  ],
  "hints": {
    "hint": "The text appears to be encoded...",
    "nudge": "This is a Caesar cipher. Try shifting letters...",
    "full_explanation": "Solution: HELLO WORLD\n\nSteps:\n1. ..."
  },
  "next_puzzle_prediction": "Likely a more complex cipher or physical puzzle..."
}
```

## Supported Puzzle Types

| Type | Description | Example |
|------|-------------|---------|
| **Caesar Cipher** | Letter shifting encryption | `KHOOR ZRUOG` → `HELLO WORLD` |
| **Atbash Cipher** | Reverse alphabet (A↔Z, B↔Y) | `SVOOL` → `HELLO` |
| **Base64** | Binary-to-text encoding | `SGVsbG8=` → `Hello` |
| **Morse Code** | Dots and dashes | `.... ..` → `HI` |
| **Math Puzzle** | Calculations and equations | `15 + 27 = ?` → `42` |
| **Pattern** | Number sequences | `2, 4, 6, ?` → `8` |
| **Riddle** | Word-based logic | "What has keys but no locks?" |
| **Anagram** | Letter rearrangement | "SILENT" → "LISTEN" |

## Hint Levels

- **hint**: Gentle nudge in the right direction
- **nudge**: More specific guidance about the puzzle type
- **full**: Complete solution with step-by-step explanation

## How It Works

1. **Classification**: Analyzes puzzle text to identify type(s)
2. **Pattern Detection**: Looks for cipher patterns, word structures, number sequences
3. **Solution Generation**: Applies appropriate solving algorithms
4. **Confidence Scoring**: Ranks solutions by likelihood
5. **Hint Generation**: Creates progressive hints based on puzzle type
6. **Prediction**: Suggests what might come next in the escape room

## Development

```bash
# Make the solver executable
chmod +x escape_solver.py

# Run with custom puzzle
./escape_solver.py "Your puzzle here"
```

## Contributing

Contributions welcome! Areas to expand:
- More cipher types (Vigenère, Playfair, etc.)
- Better natural language riddle solving
- Image-based puzzle analysis
- Audio puzzle decoding
- ML-based pattern recognition

## License

See [LICENSE](LICENSE) file for details.

## Author

Built for escape room enthusiasts who want to understand puzzle-solving techniques or get unstuck when needed.

---

**Note**: Alcatraz is designed for educational purposes and to help understand puzzle mechanics. Use responsibly and consider solving puzzles yourself first for the best escape room experience!
