import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/claim_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ClaimProvider>().loadHistory());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClaimProvider>();
    return Scaffold(
      body: GradientBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GlassCard(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.history.length,
                      itemBuilder: (context, i) {
                        final c = provider.history[i];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 6),
                          title: Text(c.summary),
                          subtitle: Text('Score: ${c.score} • ${c.sourceType}'),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
