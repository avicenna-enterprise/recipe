import 'package:flutter/material.dart';
import '../../models/auth_model.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_navigator.dart';
import '../home/home_screen.dart';
import 'widgets/sign_in_form.dart';
import 'widgets/sign_in_button.dart';
import 'widgets/sign_in_footer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final AuthViewModel _viewModel = AuthViewModel();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final model = SignInModel(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final success = await _viewModel.signIn(model);
    if (!mounted) return;

    if (success) {
      AppNavigator.pushAndRemoveAll(context, const HomeScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_viewModel.errorMessage ?? 'Sign in failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!v.trim().contains('@') || !v.trim().contains('.')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: 28.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header
                const Text(
                  'Hello,',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                const SizedBox(height: 40),

                // Form
                SignInForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  obscurePassword: _obscurePassword,
                  onTogglePassword: () => setState(
                      () => _obscurePassword = !_obscurePassword),
                  validateEmail: _validateEmail,
                  validatePassword: _validatePassword,
                ),
                const SizedBox(height: 28),

                // Button
                ListenableBuilder(
                  listenable: _viewModel,
                  builder: (context, _) => SignInButton(
                    isLoading: _viewModel.isLoading,
                    onPressed: _signIn,
                  ),
                ),
                const SizedBox(height: 24),

                // Footer
                const SignInFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
