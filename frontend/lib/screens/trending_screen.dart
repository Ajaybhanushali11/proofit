import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/claim_provider.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ClaimProvider>().loadTrending());
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
                      itemCount: provider.trending.length,
                      itemBuilder: (context, i) {
                        final c = provider.trending[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.34),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.summary, style: const TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text('Views: ${c.views} • Score: ${c.score}'),
                            ],
                          ),
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
