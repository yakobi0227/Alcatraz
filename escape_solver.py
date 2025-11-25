#!/usr/bin/env python3
"""
Alcatraz - Escape Room Puzzle Solver
Analyzes and solves various types of escape room puzzles, riddles, and ciphers.
"""

import json
import re
import base64
from typing import List, Dict, Any, Optional
from collections import Counter


class EscapeRoomSolver:
    """Main solver class for escape room puzzles."""

    def __init__(self):
        self.puzzle_detectors = {
            'caesar_cipher': self._detect_caesar,
            'substitution_cipher': self._detect_substitution,
            'atbash_cipher': self._detect_atbash,
            'base64': self._detect_base64,
            'morse_code': self._detect_morse,
            'word_riddle': self._detect_word_riddle,
            'math_puzzle': self._detect_math,
            'logic_puzzle': self._detect_logic,
            'anagram': self._detect_anagram,
            'pattern': self._detect_pattern,
            'wordplay': self._detect_wordplay,
        }

    def solve(self, puzzle: str, context: str = "", hint_level: str = "hint") -> Dict[str, Any]:
        """
        Main solving method.

        Args:
            puzzle: The puzzle text
            context: Optional context about the room or previous solutions
            hint_level: Requested hint level (hint, nudge, or full)

        Returns:
            JSON-serializable dictionary with the solution
        """
        # Classify puzzle types
        puzzle_types = self._classify_puzzle(puzzle)

        # Generate analysis
        analysis = self._analyze_puzzle(puzzle, puzzle_types, context)

        # Attempt solutions
        solutions = self._generate_solutions(puzzle, puzzle_types)

        # Generate alternative interpretations
        alternatives = self._generate_alternatives(puzzle, puzzle_types, solutions)

        # Generate hints
        hints = self._generate_hints(puzzle, solutions, puzzle_types)

        # Predict next puzzle
        next_prediction = self._predict_next(puzzle_types, context)

        return {
            "puzzle_types": puzzle_types,
            "analysis": analysis,
            "solutions": solutions,
            "alternative_interpretations": alternatives,
            "hints": hints,
            "next_puzzle_prediction": next_prediction
        }

    def _classify_puzzle(self, puzzle: str) -> List[str]:
        """Classify the type(s) of puzzle."""
        types = []

        for puzzle_type, detector in self.puzzle_detectors.items():
            if detector(puzzle):
                types.append(puzzle_type)

        # If no specific type detected, classify as general riddle
        if not types:
            types.append('riddle')

        return types

    # Puzzle Type Detectors

    def _detect_caesar(self, text: str) -> bool:
        """Detect if text might be a Caesar cipher."""
        # Look for text with unusual letter frequency
        letters_only = re.sub(r'[^A-Za-z]', '', text)
        if len(letters_only) < 10:
            return False

        # Check for low vowel ratio (encrypted text often has this)
        vowels = sum(1 for c in letters_only.lower() if c in 'aeiou')
        vowel_ratio = vowels / len(letters_only)
        return vowel_ratio < 0.25 or vowel_ratio > 0.6

    def _detect_substitution(self, text: str) -> bool:
        """Detect if text might be a substitution cipher."""
        # Similar to Caesar but more general
        letters_only = re.sub(r'[^A-Za-z]', '', text)
        if len(letters_only) < 15:
            return False

        # Check for preserved word structure (spaces intact)
        has_structure = ' ' in text
        return has_structure and len(set(letters_only.lower())) > 10

    def _detect_atbash(self, text: str) -> bool:
        """Detect if text might be Atbash cipher (A=Z, B=Y, etc.)."""
        # Atbash is just a special case of substitution
        letters_only = re.sub(r'[^A-Za-z]', '', text)
        return len(letters_only) >= 10

    def _detect_base64(self, text: str) -> bool:
        """Detect if text might be base64 encoded."""
        # Base64 pattern: alphanumeric + / and + , often with = padding
        pattern = r'^[A-Za-z0-9+/]+=*$'
        stripped = text.strip()
        return bool(re.match(pattern, stripped)) and len(stripped) % 4 == 0

    def _detect_morse(self, text: str) -> bool:
        """Detect if text might be Morse code."""
        # Morse uses dots, dashes, and spaces
        morse_chars = set('.- /')
        text_chars = set(text.strip())
        return text_chars.issubset(morse_chars) and ('.' in text or '-' in text)

    def _detect_word_riddle(self, text: str) -> bool:
        """Detect if text is a word-based riddle."""
        riddle_keywords = ['what am i', 'who am i', 'i am', 'i have', 'find me',
                          'what is', 'riddle', 'guess']
        text_lower = text.lower()
        return any(keyword in text_lower for keyword in riddle_keywords)

    def _detect_math(self, text: str) -> bool:
        """Detect if puzzle involves mathematics."""
        # Look for numbers and math operators
        has_numbers = bool(re.search(r'\d+', text))
        math_symbols = ['+', '-', '=', '*', '/', 'sum', 'total', 'calculate', 'add', 'multiply']
        has_math = any(symbol in text.lower() for symbol in math_symbols)
        return has_numbers and has_math

    def _detect_logic(self, text: str) -> bool:
        """Detect if puzzle is a logic puzzle."""
        logic_keywords = ['if', 'then', 'always', 'never', 'all', 'none', 'only',
                         'each', 'every', 'must', 'cannot', 'either', 'or', 'and']
        text_lower = text.lower()
        keyword_count = sum(1 for keyword in logic_keywords if keyword in text_lower)
        return keyword_count >= 3

    def _detect_anagram(self, text: str) -> bool:
        """Detect if puzzle involves anagrams."""
        anagram_keywords = ['rearrange', 'scrambled', 'mixed up', 'anagram', 'letters']
        text_lower = text.lower()
        return any(keyword in text_lower for keyword in anagram_keywords)

    def _detect_pattern(self, text: str) -> bool:
        """Detect if puzzle involves pattern recognition."""
        # Look for sequences or repeated structures
        numbers = re.findall(r'\d+', text)
        if len(numbers) >= 3:
            # Check if numbers form a sequence
            try:
                nums = [int(n) for n in numbers[:5]]
                diffs = [nums[i+1] - nums[i] for i in range(len(nums)-1)]
                if len(set(diffs)) == 1:  # Arithmetic sequence
                    return True
            except:
                pass

        pattern_keywords = ['sequence', 'pattern', 'next', 'continues', 'series']
        return any(keyword in text.lower() for keyword in pattern_keywords)

    def _detect_wordplay(self, text: str) -> bool:
        """Detect if puzzle involves wordplay."""
        wordplay_keywords = ['pun', 'play on words', 'sounds like', 'homophone',
                            'double meaning', 'rhyme']
        return any(keyword in text.lower() for keyword in wordplay_keywords)

    # Solution Generators

    def _generate_solutions(self, puzzle: str, puzzle_types: List[str]) -> List[Dict[str, Any]]:
        """Generate possible solutions based on puzzle types."""
        solutions = []

        if 'caesar_cipher' in puzzle_types:
            solutions.extend(self._solve_caesar(puzzle))

        if 'atbash_cipher' in puzzle_types:
            solutions.extend(self._solve_atbash(puzzle))

        if 'base64' in puzzle_types:
            solutions.extend(self._solve_base64(puzzle))

        if 'morse_code' in puzzle_types:
            solutions.extend(self._solve_morse(puzzle))

        if 'anagram' in puzzle_types:
            solutions.extend(self._solve_anagram(puzzle))

        if 'pattern' in puzzle_types:
            solutions.extend(self._solve_pattern(puzzle))

        if 'math_puzzle' in puzzle_types:
            solutions.extend(self._solve_math(puzzle))

        # If no specific solver found solution, provide general analysis
        if not solutions:
            solutions.append({
                "label": "General Analysis",
                "steps": [
                    "Analyze the puzzle structure and key elements",
                    "Look for hidden meanings or wordplay",
                    "Consider the context and theme of the escape room"
                ],
                "final_answer": "Multiple interpretations possible - see hints for guidance",
                "confidence": 0.3,
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })

        return solutions

    def _solve_caesar(self, text: str) -> List[Dict[str, Any]]:
        """Solve Caesar cipher by trying all shifts."""
        solutions = []
        text_clean = re.sub(r'[^A-Za-z]', '', text)

        if len(text_clean) < 5:
            return solutions

        best_shift = None
        best_score = 0
        best_decoded = ""

        # Common English words to check against
        common_words = {'the', 'and', 'for', 'are', 'but', 'not', 'you', 'all',
                       'can', 'her', 'was', 'one', 'our', 'out', 'has', 'have'}

        for shift in range(26):
            decoded = self._caesar_shift(text, shift)
            decoded_lower = decoded.lower()

            # Score based on common words found
            score = sum(1 for word in common_words if word in decoded_lower)

            if score > best_score:
                best_score = score
                best_shift = shift
                best_decoded = decoded

        if best_shift is not None and best_score > 0:
            solutions.append({
                "label": f"Caesar Cipher (shift {best_shift})",
                "steps": [
                    "Identify text as potential Caesar cipher",
                    f"Try all possible shifts (0-25)",
                    f"Shift {best_shift} produces readable English text"
                ],
                "final_answer": best_decoded,
                "confidence": min(0.95, best_score * 0.2),
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })

        return solutions

    def _caesar_shift(self, text: str, shift: int) -> str:
        """Apply Caesar cipher shift to text."""
        result = []
        for char in text:
            if char.isalpha():
                ascii_offset = 65 if char.isupper() else 97
                shifted = ((ord(char) - ascii_offset + shift) % 26) + ascii_offset
                result.append(chr(shifted))
            else:
                result.append(char)
        return ''.join(result)

    def _solve_atbash(self, text: str) -> List[Dict[str, Any]]:
        """Solve Atbash cipher (A=Z, B=Y, etc.)."""
        solutions = []
        decoded = self._atbash_decode(text)

        # Check if decoded text looks more like English
        if self._looks_like_english(decoded):
            solutions.append({
                "label": "Atbash Cipher",
                "steps": [
                    "Recognize Atbash cipher pattern (A↔Z, B↔Y, etc.)",
                    "Apply reverse alphabet substitution",
                    "Decode to readable text"
                ],
                "final_answer": decoded,
                "confidence": 0.8,
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })

        return solutions

    def _atbash_decode(self, text: str) -> str:
        """Decode Atbash cipher."""
        result = []
        for char in text:
            if char.isalpha():
                if char.isupper():
                    result.append(chr(90 - (ord(char) - 65)))
                else:
                    result.append(chr(122 - (ord(char) - 97)))
            else:
                result.append(char)
        return ''.join(result)

    def _solve_base64(self, text: str) -> List[Dict[str, Any]]:
        """Decode base64 text."""
        solutions = []
        try:
            decoded = base64.b64decode(text.strip()).decode('utf-8')
            solutions.append({
                "label": "Base64 Decoding",
                "steps": [
                    "Identify base64 encoding pattern",
                    "Decode using base64 algorithm",
                    "Extract hidden message"
                ],
                "final_answer": decoded,
                "confidence": 0.95,
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })
        except:
            pass

        return solutions

    def _solve_morse(self, text: str) -> List[Dict[str, Any]]:
        """Decode Morse code."""
        morse_dict = {
            '.-': 'A', '-...': 'B', '-.-.': 'C', '-..': 'D', '.': 'E',
            '..-.': 'F', '--.': 'G', '....': 'H', '..': 'I', '.---': 'J',
            '-.-': 'K', '.-..': 'L', '--': 'M', '-.': 'N', '---': 'O',
            '.--.': 'P', '--.-': 'Q', '.-.': 'R', '...': 'S', '-': 'T',
            '..-': 'U', '...-': 'V', '.--': 'W', '-..-': 'X', '-.--': 'Y',
            '--..': 'Z',
            '-----': '0', '.----': '1', '..---': '2', '...--': '3',
            '....-': '4', '.....': '5', '-....': '6', '--...': '7',
            '---..': '8', '----.': '9'
        }

        solutions = []
        try:
            # Split by spaces or slashes
            words = text.split('/')
            decoded_words = []

            for word in words:
                letters = word.strip().split()
                decoded_word = ''.join(morse_dict.get(letter, '?') for letter in letters)
                decoded_words.append(decoded_word)

            decoded = ' '.join(decoded_words)

            if '?' not in decoded:
                solutions.append({
                    "label": "Morse Code",
                    "steps": [
                        "Identify Morse code pattern (dots and dashes)",
                        "Separate letters by spaces, words by slashes",
                        "Translate using Morse code table"
                    ],
                    "final_answer": decoded,
                    "confidence": 0.9,
                    "hint_level_available": ["hint", "nudge", "full_explanation"]
                })
        except:
            pass

        return solutions

    def _solve_anagram(self, text: str) -> List[Dict[str, Any]]:
        """Attempt to solve anagrams."""
        solutions = []

        # Extract words that might be anagrams
        words = re.findall(r'\b[A-Za-z]+\b', text)

        # Look for common anagram indicators and solve
        if words:
            # For now, just note that it's an anagram puzzle
            solutions.append({
                "label": "Anagram Puzzle",
                "steps": [
                    "Identify scrambled letters or words",
                    "Rearrange letters to form valid words",
                    "Consider context for likely solutions"
                ],
                "final_answer": "Rearrange the letters: " + ' '.join(words),
                "confidence": 0.6,
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })

        return solutions

    def _solve_pattern(self, text: str) -> List[Dict[str, Any]]:
        """Solve number or sequence patterns."""
        solutions = []
        numbers = re.findall(r'\d+', text)

        if len(numbers) >= 3:
            nums = [int(n) for n in numbers]

            # Check for arithmetic sequence
            diffs = [nums[i+1] - nums[i] for i in range(len(nums)-1)]
            if len(set(diffs)) == 1:
                next_num = nums[-1] + diffs[0]
                solutions.append({
                    "label": "Arithmetic Sequence",
                    "steps": [
                        f"Identify sequence: {', '.join(numbers)}",
                        f"Calculate difference: {diffs[0]}",
                        f"Next number: {next_num}"
                    ],
                    "final_answer": str(next_num),
                    "confidence": 0.9,
                    "hint_level_available": ["hint", "nudge", "full_explanation"]
                })

            # Check for geometric sequence
            if all(nums[i] != 0 for i in range(len(nums)-1)):
                ratios = [nums[i+1] / nums[i] for i in range(len(nums)-1)]
                if len(set(ratios)) == 1:
                    next_num = int(nums[-1] * ratios[0])
                    solutions.append({
                        "label": "Geometric Sequence",
                        "steps": [
                            f"Identify sequence: {', '.join(numbers)}",
                            f"Calculate ratio: {ratios[0]}",
                            f"Next number: {next_num}"
                        ],
                        "final_answer": str(next_num),
                        "confidence": 0.85,
                        "hint_level_available": ["hint", "nudge", "full_explanation"]
                    })

        return solutions

    def _solve_math(self, text: str) -> List[Dict[str, Any]]:
        """Solve mathematical puzzles."""
        solutions = []

        # Look for simple equations
        equation_match = re.search(r'(\d+)\s*([+\-*/])\s*(\d+)\s*=\s*\?', text)
        if equation_match:
            num1, op, num2 = equation_match.groups()
            num1, num2 = int(num1), int(num2)

            result = 0
            if op == '+':
                result = num1 + num2
            elif op == '-':
                result = num1 - num2
            elif op == '*':
                result = num1 * num2
            elif op == '/':
                result = num1 // num2

            solutions.append({
                "label": "Mathematical Equation",
                "steps": [
                    f"Identify equation: {num1} {op} {num2} = ?",
                    f"Calculate: {result}"
                ],
                "final_answer": str(result),
                "confidence": 0.95,
                "hint_level_available": ["hint", "nudge", "full_explanation"]
            })

        return solutions

    def _looks_like_english(self, text: str) -> bool:
        """Check if text looks like English based on vowel ratio."""
        letters = re.sub(r'[^A-Za-z]', '', text)
        if len(letters) < 5:
            return False

        vowels = sum(1 for c in letters.lower() if c in 'aeiou')
        ratio = vowels / len(letters)
        return 0.3 <= ratio <= 0.5

    # Analysis and Hints

    def _analyze_puzzle(self, puzzle: str, types: List[str], context: str) -> str:
        """Generate analysis of the puzzle."""
        analysis_parts = []

        analysis_parts.append(f"The puzzle appears to be: {', '.join(types)}.")

        if 'cipher' in ' '.join(types):
            analysis_parts.append("Encrypted text detected - requires decoding.")

        if 'riddle' in types or 'word_riddle' in types:
            analysis_parts.append("This is a word-based puzzle requiring lateral thinking.")

        if context:
            analysis_parts.append(f"Given context: {context}")

        analysis_parts.append(f"Puzzle length: {len(puzzle)} characters.")

        return ' '.join(analysis_parts)

    def _generate_hints(self, puzzle: str, solutions: List[Dict], types: List[str]) -> Dict[str, str]:
        """Generate hints at different levels."""

        if not solutions or solutions[0]['confidence'] < 0.5:
            return {
                "hint": "Look carefully at the structure and format of the text.",
                "nudge": "Consider what type of encoding or wordplay might be used. Look for patterns.",
                "full_explanation": f"This appears to be a {', '.join(types)} puzzle. Without more context, multiple interpretations are possible. Examine each word and letter carefully."
            }

        best_solution = solutions[0]

        # Hint: vague direction
        hint = "Pay attention to the way the text is formatted."
        if 'cipher' in ' '.join(types):
            hint = "The text appears to be encoded. Think about common encryption methods."
        elif 'pattern' in types:
            hint = "Look for a mathematical or sequential pattern."
        elif 'riddle' in types:
            hint = "Think about the literal and figurative meanings of the words."

        # Nudge: more specific
        nudge = f"This is a {best_solution['label']}. " + best_solution['steps'][0]

        # Full explanation
        full = f"Solution: {best_solution['final_answer']}\n\n"
        full += "Steps:\n" + '\n'.join(f"{i+1}. {step}" for i, step in enumerate(best_solution['steps']))

        return {
            "hint": hint,
            "nudge": nudge,
            "full_explanation": full
        }

    def _generate_alternatives(self, puzzle: str, types: List[str],
                              solutions: List[Dict]) -> List[Dict[str, Any]]:
        """Generate alternative interpretations."""
        alternatives = []

        # If we have multiple solutions, some are alternatives
        if len(solutions) > 1:
            for sol in solutions[1:]:
                alternatives.append({
                    "description": f"{sol['label']}: {sol['final_answer']}",
                    "confidence": sol['confidence']
                })

        # Add some common alternatives based on puzzle type
        if 'riddle' in types:
            alternatives.append({
                "description": "Could be a play on words or pun",
                "confidence": 0.4
            })

        if len(alternatives) == 0:
            alternatives.append({
                "description": "No strong alternative interpretations found",
                "confidence": 0.1
            })

        return alternatives

    def _predict_next(self, types: List[str], context: str) -> str:
        """Predict what type of puzzle might come next."""

        predictions = {
            'caesar_cipher': "Likely a more complex cipher (Vigenère, substitution) or a physical puzzle using the decoded answer as a key.",
            'base64': "May lead to a URL, password, or another encoded message that needs further decoding.",
            'morse_code': "Could be followed by a numeric code, coordinates, or a physical location puzzle.",
            'riddle': "Probably leads to a physical object in the room or a combination lock code.",
            'math_puzzle': "Answer may be used as a combination or lead to a sequence-based puzzle.",
            'pattern': "Next puzzle likely involves using the sequence answer as a key or code.",
            'anagram': "Decoded word probably references an object or location for the next clue."
        }

        for ptype in types:
            if ptype in predictions:
                return predictions[ptype]

        return "Next puzzle could involve physical objects in the room, a lock combination, or a meta-puzzle connecting previous solutions."


def main():
    """CLI interface for the escape room solver."""
    import sys

    if len(sys.argv) < 2:
        print("Usage: python escape_solver.py '<puzzle>' [context] [hint_level]")
        print("Example: python escape_solver.py 'KHOOR ZRUOG' '' 'full'")
        sys.exit(1)

    puzzle = sys.argv[1]
    context = sys.argv[2] if len(sys.argv) > 2 else ""
    hint_level = sys.argv[3] if len(sys.argv) > 3 else "hint"

    solver = EscapeRoomSolver()
    result = solver.solve(puzzle, context, hint_level)

    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
