/// Data models for puzzle solving system
library;

enum PuzzleType {
  lock,
  cipher,
  riddle,
  pattern,
  math,
  mechanism,
}

enum HintLevel {
  hint,
  nudge,
  full,
}

/// Represents an identified object in the puzzle image
class IdentifiedObject {
  final String label;
  final String details;
  final String category;

  IdentifiedObject({
    required this.label,
    required this.details,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'details': details,
        'category': category,
      };

  factory IdentifiedObject.fromJson(Map<String, dynamic> json) {
    return IdentifiedObject(
      label: json['label'] as String,
      details: json['details'] as String,
      category: json['category'] as String,
    );
  }
}

/// Represents a step in solving a puzzle
class SolutionStep {
  final String description;
  final String? calculation;

  SolutionStep({
    required this.description,
    this.calculation,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        if (calculation != null) 'calculation': calculation,
      };

  factory SolutionStep.fromJson(Map<String, dynamic> json) {
    return SolutionStep(
      description: json['description'] as String,
      calculation: json['calculation'] as String?,
    );
  }
}

/// Represents a complete solution to a puzzle
class PuzzleSolution {
  final String label;
  final List<String> steps;
  final String finalAnswer;
  final int confidence;
  final List<String> hintLevelAvailable;

  PuzzleSolution({
    required this.label,
    required this.steps,
    required this.finalAnswer,
    required this.confidence,
    required this.hintLevelAvailable,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'steps': steps,
        'final_answer': finalAnswer,
        'confidence': confidence,
        'hint_level_available': hintLevelAvailable,
      };

  factory PuzzleSolution.fromJson(Map<String, dynamic> json) {
    return PuzzleSolution(
      label: json['label'] as String,
      steps: List<String>.from(json['steps'] as List),
      finalAnswer: json['final_answer'] as String,
      confidence: json['confidence'] as int,
      hintLevelAvailable:
          List<String>.from(json['hint_level_available'] as List),
    );
  }
}

/// Represents an alternative interpretation of a puzzle
class AlternativeInterpretation {
  final String description;
  final int confidence;

  AlternativeInterpretation({
    required this.description,
    required this.confidence,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'confidence': confidence,
      };

  factory AlternativeInterpretation.fromJson(Map<String, dynamic> json) {
    return AlternativeInterpretation(
      description: json['description'] as String,
      confidence: json['confidence'] as int,
    );
  }
}

/// Contains hints at different levels
class PuzzleHints {
  final String hint;
  final String nudge;
  final String fullExplanation;

  PuzzleHints({
    required this.hint,
    required this.nudge,
    required this.fullExplanation,
  });

  String getHint(HintLevel level) {
    switch (level) {
      case HintLevel.hint:
        return hint;
      case HintLevel.nudge:
        return nudge;
      case HintLevel.full:
        return fullExplanation;
    }
  }

  Map<String, dynamic> toJson() => {
        'hint': hint,
        'nudge': nudge,
        'full_explanation': fullExplanation,
      };

  factory PuzzleHints.fromJson(Map<String, dynamic> json) {
    return PuzzleHints(
      hint: json['hint'] as String,
      nudge: json['nudge'] as String,
      fullExplanation: json['full_explanation'] as String,
    );
  }
}

/// Complete puzzle analysis result
class PuzzleAnalysis {
  final String ocr;
  final List<PuzzleType> puzzleTypes;
  final List<IdentifiedObject> identifiedObjects;
  final List<PuzzleSolution> solutions;
  final List<AlternativeInterpretation> alternativeInterpretations;
  final PuzzleHints hints;
  final String? nextPuzzlePrediction;

  PuzzleAnalysis({
    required this.ocr,
    required this.puzzleTypes,
    required this.identifiedObjects,
    required this.solutions,
    required this.alternativeInterpretations,
    required this.hints,
    this.nextPuzzlePrediction,
  });

  Map<String, dynamic> toJson() => {
        'ocr': ocr,
        'puzzle_types':
            puzzleTypes.map((e) => e.name).toList(),
        'identified_objects': identifiedObjects.map((e) => e.toJson()).toList(),
        'solutions': solutions.map((e) => e.toJson()).toList(),
        'alternative_interpretations':
            alternativeInterpretations.map((e) => e.toJson()).toList(),
        'hints': hints.toJson(),
        if (nextPuzzlePrediction != null)
          'next_puzzle_prediction': nextPuzzlePrediction,
      };

  factory PuzzleAnalysis.fromJson(Map<String, dynamic> json) {
    return PuzzleAnalysis(
      ocr: json['ocr'] as String,
      puzzleTypes: (json['puzzle_types'] as List)
          .map((e) => PuzzleType.values.byName(e as String))
          .toList(),
      identifiedObjects: (json['identified_objects'] as List)
          .map((e) => IdentifiedObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      solutions: (json['solutions'] as List)
          .map((e) => PuzzleSolution.fromJson(e as Map<String, dynamic>))
          .toList(),
      alternativeInterpretations: (json['alternative_interpretations'] as List)
          .map((e) =>
              AlternativeInterpretation.fromJson(e as Map<String, dynamic>))
          .toList(),
      hints: PuzzleHints.fromJson(json['hints'] as Map<String, dynamic>),
      nextPuzzlePrediction: json['next_puzzle_prediction'] as String?,
    );
  }
}
