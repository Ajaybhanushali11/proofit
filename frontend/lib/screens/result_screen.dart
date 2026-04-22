import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/claim_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ClaimProvider>().latestResult;
    if (result == null) {
      return const Scaffold(body: Center(child: Text('No result yet')));
    }

    return Scaffold(
      body: GradientBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GlassCard(
              child: ListView(
                children: [
                  const Text('Result', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        const Text('Credibility score'),
                        Text(
                          '${result.score}/100',
                          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Summary', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(result.summary),
                  const SizedBox(height: 14),
                  const Text('Explanation', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  ...result.explanation.map((line) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('- $line'),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
