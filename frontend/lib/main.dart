import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/claim_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/api_service.dart';
import 'services/auth_storage.dart';

void main() {
  final api = ApiService();
  final storage = AuthStorage();
  runApp(ProofItApp(api: api, storage: storage));
}

class ProofItApp extends StatelessWidget {
  const ProofItApp({super.key, required this.api, required this.storage});
  final ApiService api;
  final AuthStorage storage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(api, storage)..tryRestoreSession(),
        ),
        ChangeNotifierProvider(create: (_) => ClaimProvider(api)),
      ],
      child: MaterialApp(
        title: 'ProofIt',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: Consumer<AuthProvider>(
          builder: (_, auth, __) =>
              auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
        ),
      ),
    );
  }
}
