import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/claim_provider.dart';
import '../widgets/soft_button.dart';
import 'history_screen.dart';
import 'login_screen.dart';
import 'result_screen.dart';
import 'trending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final claimCtrl = TextEditingController();
  final stt.SpeechToText speech = stt.SpeechToText();
  bool listening = false;
  String sourceType = 'text';

  Future<void> startListening() async {
    final ok = await speech.initialize();
    if (!ok) return;
    setState(() {
      listening = true;
      sourceType = 'voice';
    });
    speech.listen(
      onResult: (res) {
        setState(() => claimCtrl.text = res.recognizedWords);
      },
      listenFor: const Duration(seconds: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final claim = context.watch<ClaimProvider>();
    final auth = context.read<AuthProvider>();
    return Scaffold(
      body: GradientBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('ProofIt', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await auth.logout();
                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
                      },
                      icon: const Icon(Icons.logout_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Paste a claim or type one'),
                      const SizedBox(height: 10),
                      TextField(
                        controller: claimCtrl,
                        maxLines: 5,
                        decoration: const InputDecoration(hintText: 'Ex: This herbal drink cures diabetes in 7 days'),
                        onChanged: (value) => sourceType = value.startsWith('http') ? 'url' : sourceType,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SoftButton(
                              label: 'Verify claim',
                              loading: claim.loading,
                              onTap: () async {
                                await claim.verify(claimCtrl.text.trim(), sourceType);
                                if (!context.mounted) return;
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultScreen()));
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton.small(
                            heroTag: 'mic',
                            onPressed: startListening,
                            child: Icon(listening ? Icons.mic : Icons.mic_none_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SoftButton(
                        label: 'History',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SoftButton(
                        label: 'Trending',
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TrendingScreen())),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
