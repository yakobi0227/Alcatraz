/// Base class for all escape room props
///
/// HINT: Props represent physical objects found in escape rooms
/// Each prop has a type, description, and can be solved
abstract class Prop {
  final String id;
  final String name;
  final String description;
  final PropType type;

  const Prop({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  /// Solve the prop and return the solution
  String solve();

  /// Get hints for solving this prop
  List<String> getHints();
}

/// Types of escape room props
enum PropType {
  lock,           // Physical locks (combination, key, directional)
  cipher,         // Encrypted messages
  puzzle,         // Logic puzzles
  riddle,         // Word riddles
  pattern,        // Pattern recognition
  mathPuzzle,     // Mathematical problems
  physicalPuzzle, // Physical manipulation puzzles
}

/// Difficulty levels for props
enum Difficulty {
  easy,
  medium,
  hard,
  expert,
}
