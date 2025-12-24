import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final double result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 12),
            Text(
              'Result: $result',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
