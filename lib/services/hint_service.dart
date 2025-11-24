/// Service for managing puzzle hints
library;

import '../models/puzzle_models.dart';

class HintService {
  /// Get a hint at the specified level
  String getHint(PuzzleAnalysis analysis, HintLevel level) {
    return analysis.hints.getHint(level);
  }

  /// Get a progressive hint based on the number of attempts
  /// First attempt: basic hint
  /// Second attempt: nudge
  /// Third+ attempt: full explanation
  String getProgressiveHint(PuzzleAnalysis analysis, int attemptCount) {
    if (attemptCount <= 1) {
      return analysis.hints.hint;
    } else if (attemptCount == 2) {
      return analysis.hints.nudge;
    } else {
      return analysis.hints.fullExplanation;
    }
  }

  /// Get all available hint levels for a puzzle
  List<HintLevel> getAvailableHints(PuzzleSolution solution) {
    return solution.hintLevelAvailable
        .map((h) {
          switch (h.toLowerCase()) {
            case 'hint':
              return HintLevel.hint;
            case 'nudge':
              return HintLevel.nudge;
            case 'full':
              return HintLevel.full;
            default:
              return null;
          }
        })
        .whereType<HintLevel>()
        .toList();
  }

  /// Format hint for display
  String formatHint(String hint, HintLevel level) {
    switch (level) {
      case HintLevel.hint:
        return '💡 Hint: $hint';
      case HintLevel.nudge:
        return '👉 Nudge: $hint';
      case HintLevel.full:
        return '✅ Full Explanation: $hint';
    }
  }

  /// Check if more hints are available
  bool hasMoreHints(HintLevel currentLevel) {
    switch (currentLevel) {
      case HintLevel.hint:
        return true; // Can still get nudge and full
      case HintLevel.nudge:
        return true; // Can still get full
      case HintLevel.full:
        return false; // Already at max hint level
    }
  }

  /// Get the next hint level
  HintLevel? getNextHintLevel(HintLevel currentLevel) {
    switch (currentLevel) {
      case HintLevel.hint:
        return HintLevel.nudge;
      case HintLevel.nudge:
        return HintLevel.full;
      case HintLevel.full:
        return null; // No more hints
    }
  }
}
