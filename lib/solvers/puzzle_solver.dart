/// Base interface for puzzle solvers
library;

import '../models/puzzle_models.dart';

abstract class PuzzleSolver {
  /// Analyze and solve a puzzle from OCR text
  PuzzleAnalysis analyzeFromOCR(String ocrText);

  /// Get the puzzle types this solver can handle
  List<PuzzleType> getSupportedTypes();
}

/// Main puzzle solver coordinator
class AlcatrazSolver {
  final Map<PuzzleType, PuzzleSolver> _solvers = {};

  AlcatrazSolver() {
    // Register solvers here as they're implemented
    // _solvers[PuzzleType.lock] = LockSolver();
    // _solvers[PuzzleType.cipher] = CipherSolver();
    // etc.
  }

  /// Register a solver for a specific puzzle type
  void registerSolver(PuzzleType type, PuzzleSolver solver) {
    _solvers[type] = solver;
  }

  /// Analyze puzzle and route to appropriate solver
  PuzzleAnalysis? solvePuzzle(PuzzleType type, String ocrText) {
    final solver = _solvers[type];
    if (solver == null) {
      return null;
    }
    return solver.analyzeFromOCR(ocrText);
  }

  /// Attempt to solve with all available solvers and return best match
  List<PuzzleAnalysis> solveWithAllSolvers(String ocrText) {
    final results = <PuzzleAnalysis>[];

    for (final solver in _solvers.values) {
      try {
        final analysis = solver.analyzeFromOCR(ocrText);
        if (analysis.solutions.isNotEmpty) {
          results.add(analysis);
        }
      } catch (e) {
        // Skip solvers that fail
        continue;
      }
    }

    // Sort by confidence
    results.sort((a, b) {
      final aConfidence =
          a.solutions.isNotEmpty ? a.solutions.first.confidence : 0;
      final bConfidence =
          b.solutions.isNotEmpty ? b.solutions.first.confidence : 0;
      return bConfidence.compareTo(aConfidence);
    });

    return results;
  }
}
