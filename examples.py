#!/usr/bin/env python3
"""
Example puzzles to test the Alcatraz escape room solver.
"""

import json
from escape_solver import EscapeRoomSolver


def test_puzzles():
    """Test the solver with various puzzle types."""

    solver = EscapeRoomSolver()

    puzzles = [
        {
            "name": "Caesar Cipher",
            "puzzle": "KHOOR ZRUOG",
            "context": "Found on a stone tablet near the entrance",
            "hint_level": "full"
        },
        {
            "name": "Morse Code",
            "puzzle": ".... . .-.. .-.. --- / .-- --- .-. .-.. -..",
            "context": "Heard from a mysterious radio",
            "hint_level": "full"
        },
        {
            "name": "Base64",
            "puzzle": "VGhlIGtleSBpcyB1bmRlciB0aGUgbWF0",
            "context": "Found in a computer terminal",
            "hint_level": "full"
        },
        {
            "name": "Number Pattern",
            "puzzle": "What comes next in the sequence: 2, 4, 6, 8, ?",
            "context": "Written on a chalkboard",
            "hint_level": "nudge"
        },
        {
            "name": "Simple Riddle",
            "puzzle": "I have keys but no locks. I have space but no room. You can enter but can't go outside. What am I?",
            "context": "Mysterious voice asks this question",
            "hint_level": "hint"
        },
        {
            "name": "Math Puzzle",
            "puzzle": "If the code is 15 + 27 = ?, what is the combination?",
            "context": "Lock combination puzzle",
            "hint_level": "full"
        },
        {
            "name": "4-Digit Combination Lock",
            "puzzle": "4-digit combination lock with rotating wheels (0-9 on each wheel)",
            "context": "Physical prop - needs code to unlock. Theme: General escape room",
            "hint_level": "full"
        }
    ]

    for i, test in enumerate(puzzles, 1):
        print(f"\n{'='*70}")
        print(f"Test {i}: {test['name']}")
        print(f"{'='*70}")
        print(f"Puzzle: {test['puzzle']}")
        print(f"Context: {test['context']}")
        print(f"Requested hint level: {test['hint_level']}\n")

        result = solver.solve(
            puzzle=test['puzzle'],
            context=test['context'],
            hint_level=test['hint_level']
        )

        print(json.dumps(result, indent=2))
        print()


if __name__ == "__main__":
    test_puzzles()
