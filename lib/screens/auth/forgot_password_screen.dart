import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email address and we will send you a reset link.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 40),
            // Email Input
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Email',
                hintStyle: const TextStyle(color: Colors.black12, fontSize: 14),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Send Button
            GestureDetector(
              onTap: () {
                // Show success message or logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reset link sent to your email!'),
                    backgroundColor: AppColors.primary,
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Send Reset Link',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
