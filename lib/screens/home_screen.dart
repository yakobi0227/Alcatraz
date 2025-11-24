import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/puzzle_models.dart';
import '../solvers/lock_solver.dart';
import '../services/hint_service.dart';
import 'solution_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final LockSolver _lockSolver = LockSolver();
  final HintService _hintService = HintService();

  bool _isProcessing = false;
  String? _selectedPuzzleType;

  final List<String> _puzzleTypes = [
    'Lock',
    'Cipher',
    'Riddle',
    'Pattern',
    'Math',
    'Mechanism',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alcatraz'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open,
                    size: 120,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Escape Room Puzzle Solver',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Solve puzzles in seconds',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 48),
                  DropdownButtonFormField<String>(
                    value: _selectedPuzzleType,
                    decoration: InputDecoration(
                      labelText: 'Puzzle Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      prefixIcon: const Icon(Icons.category),
                    ),
                    items: _puzzleTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPuzzleType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  _buildActionButton(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Take Photo',
                    onPressed: _isProcessing ? null : () => _captureImage(ImageSource.camera),
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    context,
                    icon: Icons.photo_library,
                    label: 'Choose from Gallery',
                    onPressed: _isProcessing ? null : () => _captureImage(ImageSource.gallery),
                  ),
                  const SizedBox(height: 32),
                  Divider(
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: _showExampleSolution,
                    icon: const Icon(Icons.lightbulb_outline),
                    label: const Text('Try Example Solution'),
                  ),
                  if (_isProcessing)
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  Future<void> _captureImage(ImageSource source) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null && mounted) {
        // TODO: Implement OCR processing with Google ML Kit
        // For now, show a placeholder message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Image processing will be implemented with OCR integration'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showExampleSolution() {
    final analysis = _lockSolver.solveExample();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SolutionScreen(
          analysis: analysis,
          hintService: _hintService,
        ),
      ),
    );
  }
}
