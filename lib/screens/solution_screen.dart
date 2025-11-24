import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/puzzle_models.dart';
import '../services/hint_service.dart';

class SolutionScreen extends StatefulWidget {
  final PuzzleAnalysis analysis;
  final HintService hintService;

  const SolutionScreen({
    super.key,
    required this.analysis,
    required this.hintService,
  });

  @override
  State<SolutionScreen> createState() => _SolutionScreenState();
}

class _SolutionScreenState extends State<SolutionScreen> {
  HintLevel _currentHintLevel = HintLevel.hint;
  bool _showSolution = false;

  @override
  Widget build(BuildContext context) {
    final hasSolution = widget.analysis.solutions.isNotEmpty;
    final primarySolution =
        hasSolution ? widget.analysis.solutions.first : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Solution'),
        actions: [
          if (hasSolution)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _copyToClipboard(primarySolution!.finalAnswer),
              tooltip: 'Copy answer',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.analysis.identifiedObjects.isNotEmpty)
              _buildIdentifiedObjectsSection(),
            const SizedBox(height: 24),
            if (hasSolution) ...[
              _buildAnswerCard(primarySolution!),
              const SizedBox(height: 24),
              _buildHintsSection(),
              const SizedBox(height: 24),
              if (_showSolution) _buildSolutionSteps(primarySolution),
              if (!_showSolution)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showSolution = true;
                      });
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text('Show Solution Steps'),
                  ),
                ),
              const SizedBox(height: 24),
              if (widget.analysis.alternativeInterpretations.isNotEmpty)
                _buildAlternativeInterpretations(),
            ] else
              _buildNoSolutionMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentifiedObjectsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Detected Objects',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...widget.analysis.identifiedObjects.map(
              (obj) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            obj.label,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            obj.details,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerCard(PuzzleSolution solution) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.lock_open,
              size: 48,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(height: 16),
            Text(
              'Answer',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              solution.finalAnswer,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified,
                  size: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.8),
                ),
                const SizedBox(width: 4),
                Text(
                  '${solution.confidence}% confidence',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintsSection() {
    final currentHint = widget.hintService.getHint(
      widget.analysis,
      _currentHintLevel,
    );
    final hasMoreHints = widget.hintService.hasMoreHints(_currentHintLevel);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hints',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.hintService.formatHint(currentHint, _currentHintLevel),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            if (hasMoreHints) ...[
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      final nextLevel =
                          widget.hintService.getNextHintLevel(_currentHintLevel);
                      if (nextLevel != null) {
                        _currentHintLevel = nextLevel;
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('More Help'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionSteps(PuzzleSolution solution) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Solution Steps',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...solution.steps.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeInterpretations() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Alternative Interpretations',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...widget.analysis.alternativeInterpretations.map(
              (alt) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(alt.description),
                          Text(
                            '${alt.confidence}% confidence',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSolutionMessage() {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(
                Icons.help_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'No Solution Found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Could not determine a solution for this puzzle.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Answer copied to clipboard')),
    );
  }
}
