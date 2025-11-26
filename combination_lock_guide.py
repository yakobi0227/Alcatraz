#!/usr/bin/env python3
"""
Comprehensive guide for solving 4-digit combination locks in escape rooms.
This script provides full strategies and common solutions.
"""

from escape_solver import EscapeRoomSolver
import json


def display_lock_strategies():
    """Display comprehensive strategies for solving combination locks."""

    print("=" * 80)
    print("4-DIGIT COMBINATION LOCK - COMPLETE SOLVING GUIDE")
    print("=" * 80)
    print()

    print("LOCK TYPE: 4-digit rotating wheel lock (0-9 on each wheel)")
    print("TOTAL COMBINATIONS: 10,000 (0000 to 9999)")
    print()

    print("=" * 80)
    print("STRATEGY 1: CLUE HUNTING (Most Common Method)")
    print("=" * 80)
    print("""
Look around the escape room for numbers in these places:

📅 DATES:
   • Birth dates on documents, ID cards, tombstones
   • Historical dates on plaques, posters, or books
   • Dates in diary entries or letters
   • Years on calendars or newspapers
   Example: "Born 1987" → Try 1987

🕐 CLOCKS & TIMES:
   • Wall clocks showing specific times
   • Digital displays
   • Broken clocks stuck at a particular time
   Example: 3:45 → Try 0345 or 3450

📖 BOOKS & PAGES:
   • Page numbers (especially bookmarked or highlighted)
   • Chapter numbers
   • Numbers in titles or on covers
   Example: "Turn to page 2847"

🎨 ARTWORK & DECORATIONS:
   • Numbers in paintings or photographs
   • Street numbers, house numbers in pictures
   • License plates in photos
   • Sports jersey numbers

🔢 WRITTEN NUMBERS:
   • Numbers on sticky notes, papers, whiteboards
   • Phone numbers (use last 4 digits)
   • Addresses
   • Safe combinations written down

🧮 MATH PROBLEMS:
   • Equations that need solving
   • Number puzzles from previous clues
   Example: "12 × 34 + 56 = 464" → Try 0464

📝 WORDS TO NUMBERS:
   • Count letters in specific words
   • A=1, B=2, C=3, etc. conversions
   • Phone keypad: ABC=2, DEF=3, GHI=4, etc.
   Example: "CLUE" → C=2, L=5, U=8, E=3 → Try 2583
""")

    print("=" * 80)
    print("STRATEGY 2: PATTERN RECOGNITION")
    print("=" * 80)
    print("""
Count objects or find patterns:

🔍 COUNTING:
   • Number of specific objects (books, keys, pictures, chairs)
   • Items in different colors or groups
   • Windows, doors, or other architectural features
   Example: 3 books + 5 keys + 2 pictures + 1 map → Try 3521

📊 SEQUENCES:
   • Look for number sequences: 1234, 2468, etc.
   • Fibonacci: 1123 (1, 1, 2, 3)
   • Squares: 1491 (1², 2², 3², 3²)
   • Primes: 2357 (first 4 prime numbers)
""")

    print("=" * 80)
    print("STRATEGY 3: PREVIOUS PUZZLE SOLUTIONS")
    print("=" * 80)
    print("""
Review solutions from earlier puzzles:

• Did you solve a cipher that gave you numbers?
• Were there numeric answers to riddles?
• Combine multiple small numbers into one code
  Example: If puzzle 1 gave "23" and puzzle 2 gave "89" → Try 2389

• Extract digits from words or phrases
  Example: "The answer is FORTY-TWO" → Try 0042 or 4200
""")

    print("=" * 80)
    print("STRATEGY 4: THEME-BASED CODES")
    print("=" * 80)
    print("""
Consider the escape room theme:

🔒 PRISON THEME (Alcatraz):
   • 1934 (Alcatraz opened)
   • 1963 (Alcatraz closed)
   • Famous prisoner numbers
   • Cell numbers

🕵️ DETECTIVE/MYSTERY:
   • Famous case numbers
   • Badge numbers
   • Crime dates

🚀 SCI-FI/SPACE:
   • Years (1969 moon landing, etc.)
   • Coordinates
   • Star Trek/Wars references

🏰 HISTORICAL:
   • Important dates from that era
   • Monarch reign years
   • Battle dates
""")

    print("=" * 80)
    print("STRATEGY 5: COMMON DEFAULT CODES (Try if Stuck)")
    print("=" * 80)
    print("""
Many escape rooms use these common codes:

✓ Sequential patterns:
   • 0000, 1111, 2222, 3333, etc.
   • 1234, 4321
   • 0123, 9876

✓ Dates:
   • 2025 (current year)
   • 2024, 2026 (nearby years)
   • 1776 (historical significance)

✓ Simple patterns:
   • 0101, 1010
   • 1212, 2121
   • 5555 (middle number)
""")

    print("=" * 80)
    print("STRATEGY 6: ADVANCED LOCK TECHNIQUES")
    print("=" * 80)
    print("""
Physical techniques (if allowed by room rules):

👂 LISTENING:
   • Some locks make a subtle click when correct digit is set
   • Turn each wheel slowly and listen carefully
   • Work one wheel at a time

✋ FEELING:
   • Slight resistance or different tension on correct digits
   • Apply gentle pulling pressure while testing each number

🔦 UV LIGHT:
   • Check lock and surroundings with UV/blacklight if available
   • Numbers may be written in invisible ink

🧲 MAGNETS:
   • Some locks have magnetic components
   • May react to magnets at correct positions

⚠️  NOTE: Only use techniques that don't damage the lock!
""")

    print("=" * 80)
    print("STRATEGY 7: SYSTEMATIC BRUTE FORCE (Last Resort)")
    print("=" * 80)
    print("""
If you must try all combinations:

4-digit lock = 10,000 combinations (0000-9999)
Estimated time: 2-4 hours if methodical

METHOD:
1. Start at 0000
2. Test each combination in order: 0001, 0002, 0003...
3. Work systematically - don't skip numbers
4. Every 100 tries, take a short break to stay focused

⏱️  FASTER APPROACH - Group by wheel:
   • Fix first wheel at 0, try all combos: 0000-0999
   • Then set first wheel to 1, try: 1000-1999
   • Continue through 9000-9999

⚠️  This is VERY time-consuming. Exhaust all clue-hunting first!
""")

    print("=" * 80)
    print("STRATEGY 8: TEAMWORK & ORGANIZATION")
    print("=" * 80)
    print("""
Work efficiently with your team:

👥 DIVIDE TASKS:
   • 1 person focuses on lock
   • Others search for clues
   • Share all numbers found immediately

📋 TRACK ATTEMPTS:
   • Write down all codes you've tried
   • Avoid testing same number twice
   • List all numbers found in room

💬 COMMUNICATE:
   • Call out any numbers you find
   • Discuss patterns you notice
   • Ask for hints from game master if time is running out
""")

    print()
    print("=" * 80)
    print("QUICK CHECKLIST")
    print("=" * 80)
    print("""
□ Searched entire room for written numbers?
□ Checked all clocks, calendars, dates?
□ Examined all artwork and photos?
□ Reviewed previous puzzle solutions?
□ Tried theme-related numbers?
□ Counted objects in room?
□ Tested common default codes?
□ Tried letter-to-number conversions?
□ Asked teammates for their findings?
□ Requested hint from game master?
""")

    print()
    print("=" * 80)
    print("COMMON MISTAKE TO AVOID")
    print("=" * 80)
    print("""
❌ DON'T immediately start brute-forcing!
   → The code is ALWAYS hidden somewhere in the room as a clue

❌ DON'T ignore small details
   → Numbers can be hidden in plain sight

❌ DON'T work alone
   → Team communication is crucial

✅ DO search thoroughly before trying random codes
✅ DO document all numbers you find
✅ DO think about how clues connect to the room's story
""")

    print()
    print("=" * 80)
    print("Good luck with your escape!")
    print("=" * 80)


def analyze_with_solver():
    """Use the Alcatraz solver to analyze the lock."""

    print("\n\n")
    print("=" * 80)
    print("AUTOMATED ANALYSIS USING ALCATRAZ SOLVER")
    print("=" * 80)
    print()

    solver = EscapeRoomSolver()

    result = solver.solve(
        puzzle="4-digit combination lock with rotating wheels (0-9 on each wheel)",
        context="Physical prop found in escape room. General theme.",
        hint_level="full"
    )

    print("PUZZLE TYPES DETECTED:")
    for ptype in result['puzzle_types']:
        print(f"  • {ptype}")

    print("\nANALYSIS:")
    print(f"  {result['analysis']}")

    print("\nHINT (Full Explanation):")
    print(result['hints']['full_explanation'])

    print("\nNEXT STEPS PREDICTION:")
    print(f"  {result['next_puzzle_prediction']}")


if __name__ == "__main__":
    display_lock_strategies()
    analyze_with_solver()
