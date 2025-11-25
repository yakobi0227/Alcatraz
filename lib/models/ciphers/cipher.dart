import '../prop.dart';

/// Base class for all cipher types
///
/// FULL HINT: Ciphers encode messages using various techniques
/// Look for:
/// - Strange symbols or letters
/// - Numbers that don't fit context
/// - Patterns in text alignment
/// - References to historical ciphers
abstract class Cipher extends Prop {
  final String encryptedText;
  final Difficulty difficulty;

  const Cipher({
    required super.id,
    required super.name,
    required super.description,
    required this.encryptedText,
    required this.difficulty,
  }) : super(type: PropType.cipher);

  /// Decrypt the cipher
  String decrypt();
}

/// Caesar Cipher (shift cipher)
///
/// FULL HINT: Each letter is shifted by a fixed number
/// A with shift 3 becomes D, B becomes E, etc.
/// Common shifts: 3, 13 (ROT13), or look for a number clue in the room
class CaesarCipher extends Cipher {
  final int? shift;

  const CaesarCipher({
    required super.id,
    required super.name,
    required super.description,
    required super.encryptedText,
    required super.difficulty,
    this.shift,
  });

  @override
  String solve() {
    final decrypted = decrypt();
    final usedShift = shift ?? _findShift();
    return 'Decrypted Message: $decrypted\n\n'
        'Cipher Type: Caesar Cipher (Shift: $usedShift)\n'
        'Explanation: Each letter shifted backward by $usedShift positions';
  }

  @override
  String decrypt() {
    final usedShift = shift ?? _findShift();
    return _shiftText(encryptedText, -usedShift);
  }

  int _findShift() {
    // HINT: Try all possible shifts (1-25) and look for readable English
    for (int s = 1; s < 26; s++) {
      final result = _shiftText(encryptedText, -s);
      if (_looksLikeEnglish(result)) {
        return s;
      }
    }
    return 3; // Default shift
  }

  String _shiftText(String text, int shift) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        final isUpper = char == char.toUpperCase();
        final base = isUpper ? 65 : 97; // ASCII: 'A' = 65, 'a' = 97
        final shifted = ((char.codeUnitAt(0) - base + shift) % 26 + 26) % 26;
        buffer.write(String.fromCharCode(base + shifted));
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  bool _looksLikeEnglish(String text) {
    final commonWords = ['THE', 'AND', 'FOR', 'ARE', 'BUT', 'NOT', 'YOU', 'ALL', 'CAN', 'HER'];
    final upper = text.toUpperCase();
    return commonWords.any((word) => upper.contains(word));
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: This is a Caesar Cipher - each letter is shifted',
      'HINT 2: Look for a number in the room - it might be the shift value',
      'HINT 3: Try ROT13 (shift of 13) - a common variant',
      'HINT 4: If no shift is given, try all 25 possibilities',
      'HINT 5: Common shifts are 3, 13, or single digits found in the room',
    ];
  }
}

/// Substitution Cipher
///
/// FULL HINT: Each letter is replaced with another letter or symbol
/// Look for:
/// - A key showing letter mappings
/// - Symbol alphabets on walls
/// - Frequency analysis (E is most common English letter)
class SubstitutionCipher extends Cipher {
  final Map<String, String>? key;

  const SubstitutionCipher({
    required super.id,
    required super.name,
    required super.description,
    required super.encryptedText,
    required super.difficulty,
    this.key,
  });

  @override
  String solve() {
    final decrypted = decrypt();
    return 'Decrypted Message: $decrypted\n\n'
        'Cipher Type: Substitution Cipher\n'
        'Explanation: Each symbol/letter maps to a specific letter';
  }

  @override
  String decrypt() {
    if (key == null) {
      return 'ERROR: Need substitution key to decrypt. Look for a cipher wheel or symbol chart in the room!';
    }

    final buffer = StringBuffer();
    for (int i = 0; i < encryptedText.length; i++) {
      final char = encryptedText[i];
      buffer.write(key![char.toUpperCase()] ?? char);
    }
    return buffer.toString();
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Look for a cipher wheel or alphabet chart showing mappings',
      'HINT 2: Each symbol/letter consistently represents the same letter',
      'HINT 3: Count symbol frequency - most common is likely "E"',
      'HINT 4: Short words like "THE", "AND" can help crack the code',
      'HINT 5: Check walls, books, or drawers for the decryption key',
    ];
  }
}

/// Morse Code
///
/// FULL HINT: Dots (.) and dashes (-) represent letters
/// • = dot (short), — = dash (long)
/// Spaces separate letters, longer gaps separate words
class MorseCode extends Cipher {
  const MorseCode({
    required super.id,
    required super.name,
    required super.description,
    required super.encryptedText,
    required super.difficulty,
  });

  static const Map<String, String> morseToLetter = {
    '.-': 'A', '-...': 'B', '-.-.': 'C', '-..': 'D', '.': 'E',
    '..-.': 'F', '--.': 'G', '....': 'H', '..': 'I', '.---': 'J',
    '-.-': 'K', '.-..': 'L', '--': 'M', '-.': 'N', '---': 'O',
    '.--.': 'P', '--.-': 'Q', '.-.': 'R', '...': 'S', '-': 'T',
    '..-': 'U', '...-': 'V', '.--': 'W', '-..-': 'X', '-.--': 'Y',
    '--..': 'Z',
    '-----': '0', '.----': '1', '..---': '2', '...--': '3', '....-': '4',
    '.....': '5', '-....': '6', '--...': '7', '---..': '8', '----.': '9',
  };

  @override
  String solve() {
    final decrypted = decrypt();
    return 'Decrypted Message: $decrypted\n\n'
        'Cipher Type: Morse Code\n'
        'Explanation: Dots and dashes converted to letters';
  }

  @override
  String decrypt() {
    final words = encryptedText.split('  '); // Double space = word separator
    final buffer = StringBuffer();

    for (final word in words) {
      final letters = word.split(' ');
      for (final letter in letters) {
        buffer.write(morseToLetter[letter.trim()] ?? '?');
      }
      buffer.write(' ');
    }

    return buffer.toString().trim();
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: This is Morse Code - dots (.) and dashes (-)',
      'HINT 2: Short gaps separate letters, long gaps separate words',
      'HINT 3: Listen for audio clues: short beeps = dots, long beeps = dashes',
      'HINT 4: Look for blinking lights following a pattern',
      'HINT 5: SOS is "... --- ..." - a famous example',
    ];
  }
}

/// Pigpen Cipher (Masonic Cipher)
///
/// FULL HINT: Uses grid symbols to represent letters
/// Letters are placed in tic-tac-toe grids and X grids
/// The shape around each letter becomes its symbol
class PigpenCipher extends Cipher {
  const PigpenCipher({
    required super.id,
    required super.name,
    required super.description,
    required super.encryptedText,
    required super.difficulty,
  });

  @override
  String solve() {
    return 'Cipher Type: Pigpen (Masonic) Cipher\n\n'
        'FULL SOLUTION GUIDE:\n'
        '1. Draw two tic-tac-toe grids (#) and two X grids\n'
        '2. Fill first # grid with ABC/DEF/GHI (left to right, top to bottom)\n'
        '3. Fill second # grid with JKL/MNO/PQR\n'
        '4. Fill first X with S,T,U,V (top-right-bottom-left)\n'
        '5. Fill second X with W,X,Y,Z\n'
        '6. Each symbol shows the shape of the grid cell\n'
        '7. Dots indicate the second grid of each type\n\n'
        'Look for a Pigpen key chart in the room - usually on a poster or hidden note!';
  }

  @override
  String decrypt() {
    return 'Manual decryption required - find the Pigpen chart in the room';
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: Look for strange geometric symbols (angles, boxes)',
      'HINT 2: Find a Pigpen/Masonic cipher chart in the room',
      'HINT 3: Symbols are based on tic-tac-toe and X grid positions',
      'HINT 4: Dots distinguish between first and second grid sets',
      'HINT 5: This is a visual cipher - you need the key diagram',
    ];
  }
}

/// Atbash Cipher
///
/// FULL HINT: The alphabet is reversed
/// A↔Z, B↔Y, C↔X, D↔W, etc.
class AtbashCipher extends Cipher {
  const AtbashCipher({
    required super.id,
    required super.name,
    required super.description,
    required super.encryptedText,
    required super.difficulty,
  });

  @override
  String solve() {
    final decrypted = decrypt();
    return 'Decrypted Message: $decrypted\n\n'
        'Cipher Type: Atbash Cipher\n'
        'Explanation: Alphabet reversed (A↔Z, B↔Y, C↔X...)';
  }

  @override
  String decrypt() {
    final buffer = StringBuffer();
    for (int i = 0; i < encryptedText.length; i++) {
      final char = encryptedText[i];
      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        final isUpper = char == char.toUpperCase();
        final base = isUpper ? 65 : 97;
        final reversed = base + (25 - (char.codeUnitAt(0) - base));
        buffer.write(String.fromCharCode(reversed));
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  @override
  List<String> getHints() {
    return [
      'HINT 1: The alphabet is reversed - A becomes Z, B becomes Y',
      'HINT 2: This is symmetric - encrypting and decrypting use same method',
      'HINT 3: Look for phrases mentioning "reverse" or "opposite"',
      'HINT 4: Middle letters (M/N) stay close to themselves',
      'HINT 5: Try reversing the alphabet: ZYXWVUTSRQPONMLKJIHGFEDCBA',
    ];
  }
}
