import 'package:flutter/material.dart';
import '../models/prop.dart';
import '../models/locks/lock.dart';
import '../models/ciphers/cipher.dart';
import '../models/puzzles/puzzle.dart';
import 'prop_solver_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alcatraz - Escape Room Solver'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildPropTypeSection(
            context,
            'Locks',
            Icons.lock,
            Colors.orange,
            [
              ('Combination Lock', 'Numeric codes and combinations', CombinationLock(
                id: 'combo1',
                name: 'Combination Lock',
                description: '4-digit combination lock',
                difficulty: Difficulty.medium,
                clues: ['1984', 'Birth year on calendar'],
                numberOfDigits: 4,
                correctCombination: '1984',
              )),
              ('Directional Lock', 'Arrow pad sequences', DirectionalLock(
                id: 'dir1',
                name: 'Directional Lock',
                description: 'Arrow pad with 4 directions',
                difficulty: Difficulty.medium,
                clues: ['Map shows: North, East, East, South'],
                correctSequence: [Direction.up, Direction.right, Direction.right, Direction.down],
              )),
              ('Word Lock', 'Letter combinations', WordLock(
                id: 'word1',
                name: 'Word Lock',
                description: '5-letter word lock',
                difficulty: Difficulty.easy,
                clues: ['Elegant', 'Graceful', 'Lovely', 'Artistic', 'Nice', 'Charming', 'Excellent'],
                wordLength: 7,
                correctWord: 'ELEGANT',
              )),
            ],
          ),
          _buildPropTypeSection(
            context,
            'Ciphers',
            Icons.vpn_key,
            Colors.purple,
            [
              ('Caesar Cipher', 'Shift cipher decryption', CaesarCipher(
                id: 'caesar1',
                name: 'Caesar Cipher',
                description: 'Encrypted message on wall',
                encryptedText: 'KHOOR ZRUOG',
                difficulty: Difficulty.easy,
                shift: 3,
              )),
              ('Morse Code', 'Dots and dashes', MorseCode(
                id: 'morse1',
                name: 'Morse Code',
                description: 'Blinking light pattern',
                encryptedText: '.... . .-.. .--.  -- .',
                difficulty: Difficulty.medium,
              )),
              ('Atbash Cipher', 'Reversed alphabet', AtbashCipher(
                id: 'atbash1',
                name: 'Atbash Cipher',
                description: 'Strange text on mirror',
                encryptedText: 'VZHXV',
                difficulty: Difficulty.medium,
              )),
              ('Pigpen Cipher', 'Masonic symbols', PigpenCipher(
                id: 'pigpen1',
                name: 'Pigpen Cipher',
                description: 'Geometric symbols',
                encryptedText: '⌐⌐⌐',
                difficulty: Difficulty.hard,
              )),
            ],
          ),
          _buildPropTypeSection(
            context,
            'Puzzles',
            Icons.extension,
            Colors.blue,
            [
              ('Pattern Recognition', 'Number and visual patterns', PatternPuzzle(
                id: 'pattern1',
                name: 'Pattern Puzzle',
                description: 'Number sequence on wall',
                difficulty: Difficulty.medium,
                clues: ['Sequence continues...'],
                sequence: [2, 4, 8, 16, 32],
                answer: 64,
              )),
              ('Math Puzzle', 'Equations and calculations', MathPuzzle(
                id: 'math1',
                name: 'Math Puzzle',
                description: 'Equation to solve',
                difficulty: Difficulty.medium,
                clues: ['Solve for X'],
                equation: '2X + 10 = 30',
                solution: 10,
              )),
              ('Riddle', 'Word puzzles and lateral thinking', Riddle(
                id: 'riddle1',
                name: 'Riddle',
                description: 'Mysterious question',
                difficulty: Difficulty.hard,
                clues: ['Think carefully'],
                question: 'What has keys but no locks, space but no room, and you can enter but can\'t go inside?',
                answer: 'A keyboard',
              )),
              ('Color Pattern', 'Color sequences and meanings', ColorPatternPuzzle(
                id: 'color1',
                name: 'Color Pattern',
                description: 'Colored objects in order',
                difficulty: Difficulty.medium,
                clues: ['Colors on painting'],
                colorSequence: ['Red', 'Blue', 'Red', 'Blue', 'Red'],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.psychology, size: 48, color: Colors.deepOrange),
            const SizedBox(height: 8),
            Text(
              'Select a Prop Type',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Get instant solutions with full hints for any escape room prop',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropTypeSection(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<(String, String, Prop)> props,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${props.length} types available'),
        children: props.map((prop) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 20),
            ),
            title: Text(prop.$1),
            subtitle: Text(prop.$2),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PropSolverScreen(prop: prop.$3),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
