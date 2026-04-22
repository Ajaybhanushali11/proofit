import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/soft_button.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      body: GradientBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Create your account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 16),
                    TextField(controller: nameCtrl, decoration: const InputDecoration(hintText: 'Name')),
                    const SizedBox(height: 10),
                    TextField(controller: emailCtrl, decoration: const InputDecoration(hintText: 'Email')),
                    const SizedBox(height: 10),
                    TextField(controller: passCtrl, obscureText: true, decoration: const InputDecoration(hintText: 'Password')),
                    const SizedBox(height: 16),
                    SoftButton(
                      label: 'Sign up',
                      loading: auth.loading,
                      onTap: () async {
                        try {
                          await auth.signup(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text);
                          if (!context.mounted) return;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
