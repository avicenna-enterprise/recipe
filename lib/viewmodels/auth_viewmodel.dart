import 'package:flutter/material.dart';
import '../models/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  // ─── State ───────────────────────────────────────────
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSignedIn = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSignedIn => _isSignedIn;

  // ─── Sign In ─────────────────────────────────────────
  Future<bool> signIn(SignInModel model) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      // TODO: Replace with real API call
      await Future.delayed(const Duration(seconds: 1));

      // Dummy validation — accept any valid email/password
      if (model.email.isNotEmpty && model.password.length >= 6) {
        _isSignedIn = true;
        _setLoading(false);
        return true;
      } else {
        _errorMessage = 'Invalid email or password';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _errorMessage = 'Something went wrong. Try again.';
      _setLoading(false);
      return false;
    }
  }

  // ─── Sign Up ─────────────────────────────────────────
  Future<bool> signUp(SignUpModel model) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      // TODO: Replace with real API call
      await Future.delayed(const Duration(seconds: 1));

      if (model.password != model.confirmPassword) {
        _errorMessage = 'Passwords do not match';
        _setLoading(false);
        return false;
      }

      _isSignedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Something went wrong. Try again.';
      _setLoading(false);
      return false;
    }
  }

  // ─── Sign Out ────────────────────────────────────────
  void signOut() {
    _isSignedIn = false;
    _errorMessage = null;
    notifyListeners();
  }

  // ─── Clear Error ─────────────────────────────────────
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ─── Private ─────────────────────────────────────────
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
