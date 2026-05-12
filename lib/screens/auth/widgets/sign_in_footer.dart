import 'package:flutter/material.dart';
import '../../../widgets/social_buttons.dart';
import '../../../utils/app_navigator.dart';
import '../sign_up_screen.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(context, 'Or Sign in With'),
        const SizedBox(height: 20),

        // Social buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleSignInButton(onTap: () {}),
            const SizedBox(width: 20),
            FacebookSignInButton(onTap: () {}),
          ],
        ),
        const SizedBox(height: 30),

        // Sign up link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            GestureDetector(
              onTap: () =>
                  AppNavigator.push(context, const SignUpScreen()),
              child: const Text(
                'Sign up',
                style: TextStyle(
                  color: Color(0xFFFF8C00),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context, String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }
}
