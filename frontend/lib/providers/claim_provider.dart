import 'package:flutter/material.dart';
import '../models/claim_model.dart';
import '../services/api_service.dart';

class ClaimProvider extends ChangeNotifier {
  ClaimProvider(this._api);
  final ApiService _api;

  bool loading = false;
  ClaimModel? latestResult;
  List<ClaimModel> history = [];
  List<ClaimModel> trending = [];

  Future<void> verify(String text, String sourceType) async {
    loading = true;
    notifyListeners();
    try {
      final data = await _api.verifyClaim(text, sourceType);
      latestResult = ClaimModel.fromJson(data);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadHistory() async {
    loading = true;
    notifyListeners();
    try {
      final rows = await _api.getHistory();
      history = rows.map((e) => ClaimModel.fromJson(e)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loadTrending() async {
    loading = true;
    notifyListeners();
    try {
      final rows = await _api.getTrending();
      trending = rows.map((e) => ClaimModel.fromJson(e)).toList();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
