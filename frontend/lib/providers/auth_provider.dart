import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/auth_storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._api, this._storage);

  final ApiService _api;
  final AuthStorage _storage;

  bool loading = false;
  String? token;
  UserModel? user;

  bool get isLoggedIn => token != null && token!.isNotEmpty;

  Future<void> tryRestoreSession() async {
    token = await _storage.getToken();
    _api.setAuthToken(token);
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    loading = true;
    notifyListeners();
    try {
      final data = await _api.signup(name, email, password);
      token = data['token'];
      user = UserModel.fromJson(data['user']);
      _api.setAuthToken(token);
      await _storage.saveToken(token!);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    loading = true;
    notifyListeners();
    try {
      final data = await _api.login(email, password);
      token = data['token'];
      user = UserModel.fromJson(data['user']);
      _api.setAuthToken(token);
      await _storage.saveToken(token!);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    token = null;
    user = null;
    _api.setAuthToken(null);
    await _storage.clear();
    notifyListeners();
  }
}
