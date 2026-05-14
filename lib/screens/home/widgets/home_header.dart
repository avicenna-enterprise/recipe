import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_colors.dart';
import '../../profile/profile_screen.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;

  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${user.name}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'What are you cooking today?',
              style: TextStyle(fontSize: 14, color: AppColors.textGrey),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          child: CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF1B8A6B), // Teal border from image
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.accent,
              backgroundImage: user.profileImage.isNotEmpty
                  ? (user.profileImage.startsWith('assets/')
                      ? AssetImage(user.profileImage) as ImageProvider
                      : FileImage(File(user.profileImage)))
                  : null,
              child: user.profileImage.isEmpty
                  ? Text(
                      user.initial,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}