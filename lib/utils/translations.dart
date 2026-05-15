class AppTranslations {
  static const Map<String, Map<String, String>> _data = {
    'English': {
      'settings': 'Settings',
      'notifications': 'Notifications',
      'push_notif': 'Push Notifications',
      'email_notif': 'Email Notifications',
      'privacy': 'Privacy',
      'private_acc': 'Private Account',
      'profile_vis': 'Profile Visibility',
      'language': 'Language',
      'app_lang': 'App Language',
      'help_support': 'Help & Support',
      'faq': 'FAQ',
      'contact_us': 'Contact Us',
      'about': 'About App',
      'enabled': 'Enabled',
      'disabled': 'Disabled',
      'public': 'Public',
      'private': 'Private',
      'ingredients': 'Ingredients',
      'procedures': 'Procedures',
      'home': 'Home',
      'saved': 'Saved',
      'alerts': 'Alerts',
      'profile': 'Profile',
      'hello': 'Hello',
    },
  };

  static String translate(String key, String language) {
    return _data['English']![key] ?? key;
  }
}
