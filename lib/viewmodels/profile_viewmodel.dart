import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileViewModel extends ChangeNotifier {
  String? _profileImagePath;
  String _name = '';
  String _email = '';
  String _bio = 'Private Chef\nPassionate about food and life 🍳🥘🍜🍱';

  String? get profileImagePath => _profileImagePath;
  String get name => _name;
  String get email => _email;
  String get bio => _bio;

  void setUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void updateProfile({String? name, String? bio}) {
    if (name != null && name.trim().isNotEmpty) _name = name.trim();
    if (bio != null) _bio = bio;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (picked != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: picked.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Photo',
            toolbarColor: const Color(0xFF1B8A6B),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
            ],
          ),
          IOSUiSettings(
            title: 'Crop Profile Photo',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        _profileImagePath = croppedFile.path;
        notifyListeners();
      }
    }
  }
}
