import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/settings_viewmodel.dart';
import 'widgets/settings_section_header.dart';
import 'widgets/faq_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Color _primary = Color(0xFF1B8A6B);
  static const Color _textDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SettingsViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
              color: _textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: ListView(
        children: [
          // ── Notifications ──────────────────────────────────────────
          SettingsSectionHeader(title: 'Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined,
                color: _primary),
            title: const Text('Push Notifications'),
            subtitle: Text(
              vm.pushNotificationsEnabled ? 'Enabled' : 'Disabled',
              style: TextStyle(
                  color: vm.pushNotificationsEnabled
                      ? _primary
                      : Colors.grey,
                  fontSize: 12),
            ),
            value: vm.pushNotificationsEnabled,
            activeColor: _primary,
            onChanged: (_) => vm.togglePushNotifications(),
          ),
          SwitchListTile(
            secondary:
                const Icon(Icons.email_outlined, color: _primary),
            title: const Text('Email Notifications'),
            subtitle: Text(
              vm.emailNotificationsEnabled ? 'Enabled' : 'Disabled',
              style: TextStyle(
                  color: vm.emailNotificationsEnabled
                      ? _primary
                      : Colors.grey,
                  fontSize: 12),
            ),
            value: vm.emailNotificationsEnabled,
            activeColor: _primary,
            onChanged: (_) => vm.toggleEmailNotifications(),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Privacy ────────────────────────────────────────────────
          SettingsSectionHeader(title: 'Privacy'),
          SwitchListTile(
            secondary:
                const Icon(Icons.lock_outline, color: _primary),
            title: const Text('Private Account'),
            subtitle: Text(
              vm.privateAccount
                  ? 'Only followers can see your recipes'
                  : 'Anyone can see your recipes',
              style:
                  const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            value: vm.privateAccount,
            activeColor: _primary,
            onChanged: (_) => vm.togglePrivacy(),
          ),
          ListTile(
            leading: const Icon(Icons.visibility_outlined,
                color: _primary),
            title: const Text('Profile Visibility'),
            subtitle: Text(
              vm.privateAccount ? 'Private' : 'Public',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: const Icon(Icons.chevron_right,
                color: Colors.grey),
            onTap: () => _showPrivacyOptions(context, vm),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Language ───────────────────────────────────────────────
          SettingsSectionHeader(title: 'Language'),
          ListTile(
            leading:
                const Icon(Icons.language, color: _primary),
            title: const Text('App Language'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(vm.language,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14)),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () => _showLanguagePicker(context, vm),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Help & Support ─────────────────────────────────────────
          SettingsSectionHeader(title: 'Help & Support'),
          ListTile(
            leading: const Icon(Icons.help_outline, color: _primary),
            title: const Text('FAQ'),
            trailing: const Icon(Icons.chevron_right,
                color: Colors.grey),
            onTap: () => _showFAQ(context),
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined,
                color: _primary),
            title: const Text('Contact Us'),
            subtitle: const Text('support@recipeapp.com',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: const Icon(Icons.chevron_right,
                color: Colors.grey),
            onTap: () => _showContactDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: _primary),
            title: const Text('About App'),
            subtitle: const Text('Version 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: const Icon(Icons.chevron_right,
                color: Colors.grey),
            onTap: () => _showAbout(context),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ── Privacy options ───────────────────────────────────────────────────
  void _showPrivacyOptions(
      BuildContext context, SettingsViewModel vm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Profile Visibility',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            RadioListTile<bool>(
              title: const Text('Public'),
              subtitle: const Text('Anyone can see your profile'),
              value: false,
              groupValue: vm.privateAccount,
              activeColor: const Color(0xFF1B8A6B),
              onChanged: (_) {
                if (vm.privateAccount) vm.togglePrivacy();
                Navigator.pop(context);
              },
            ),
            RadioListTile<bool>(
              title: const Text('Private'),
              subtitle:
                  const Text('Only followers can see your profile'),
              value: true,
              groupValue: vm.privateAccount,
              activeColor: const Color(0xFF1B8A6B),
              onChanged: (_) {
                if (!vm.privateAccount) vm.togglePrivacy();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Language picker ───────────────────────────────────────────────────
  void _showLanguagePicker(
      BuildContext context, SettingsViewModel vm) {
    const languages = [
      'English',
      'Urdu',
      'Arabic',
      'French',
      'Spanish',
      'Chinese',
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Select Language',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...languages.map(
              (lang) => ListTile(
                title: Text(lang),
                trailing: vm.language == lang
                    ? const Icon(Icons.check,
                        color: Color(0xFF1B8A6B))
                    : null,
                onTap: () {
                  vm.setLanguage(lang);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── FAQ ───────────────────────────────────────────────────────────────
  void _showFAQ(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(20),
          children: const [
            Text('FAQ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            FAQItem(
              q: 'How do I save a recipe?',
              a: 'Tap the bookmark icon on any recipe card or in the recipe detail screen.',
            ),
            FAQItem(
              q: 'How do I explore new recipes?',
              a: 'Tap the + button at the bottom center to explore all recipes.',
            ),
            FAQItem(
              q: 'Can I edit my profile?',
              a: 'Yes, tap the ... button on your profile and select Edit Profile.',
            ),
            FAQItem(
              q: 'How do notifications work?',
              a: 'You get notified when you save a recipe or when someone watches your video.',
            ),
          ],
        ),
      ),
    );
  }

  // ── Contact dialog ────────────────────────────────────────────────────
  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Contact Us'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: support@recipeapp.com'),
            SizedBox(height: 8),
            Text('Hours: Mon-Fri, 9am - 6pm'),
            SizedBox(height: 8),
            Text(
                'We typically respond within 24 hours.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close',
                style: TextStyle(color: Color(0xFF1B8A6B))),
          ),
        ],
      ),
    );
  }

  // ── About ─────────────────────────────────────────────────────────────
  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Recipe App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 Recipe App. All rights reserved.',
      children: const [
        SizedBox(height: 8),
        Text('A simple way to find and save tasty recipes.'),
      ],
    );
  }
}


