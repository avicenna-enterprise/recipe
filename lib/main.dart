import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'screens/recipe/recipe_details_screen.dart';
import 'package:project2/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/saved/saved_screen.dart';
 import 'screens/notifications/notifications_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/explore/explore_recipes_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/saved_viewmodel.dart';
import 'viewmodels/recipe_viewmodel.dart';
import 'viewmodels/search_viewmodel.dart';
import 'viewmodels/notification_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'viewmodels/reviews_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SavedViewModel()),
        ChangeNotifierProvider(create: (_) => RecipeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => ReviewsViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B8A6B),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
          bodySmall: TextStyle(fontFamily: 'Roboto'),
          titleLarge: TextStyle(fontFamily: 'Roboto'),
          titleMedium: TextStyle(fontFamily: 'Roboto'),
          titleSmall: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      // App hamesha Splash se start hogi
      home: const SplashScreen(),
    );
  }
}

// ── Main Wrapper — Home + Bottom Nav + FAB ────────────────────────────────
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeVm = context.read<HomeViewModel>();
      final savedVm = context.read<SavedViewModel>();
      final notifVm = context.read<NotificationViewModel>();
      homeVm.setSavedViewModel(savedVm);
      savedVm.setNotificationViewModel(notifVm);
    });
  }

  void _initDeepLinks() {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    bool isRecipeLink = false;
    String? recipeId;

    if (uri.scheme == 'recipeapp' && uri.host == 'recipe') {
      isRecipeLink = true;
      recipeId = uri.pathSegments.last;
    } else if (uri.scheme == 'https' && uri.host == 'app.recipe.co' && uri.path.startsWith('/recipe/')) {
      isRecipeLink = true;
      recipeId = uri.pathSegments.last;
    }

    if (isRecipeLink && recipeId != null) {
      final homeVm = context.read<HomeViewModel>();
      
      try {
        final recipe = homeVm.allRecipes.firstWhere(
          (r) => r.id == recipeId || r.name.toLowerCase().replaceAll(' ', '_') == recipeId,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(recipe: recipe),
          ),
        );
      } catch (e) {
        debugPrint('Recipe not found: $recipeId');
      }
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const SavedScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ExploreRecipesScreen()),
          );
        },
        backgroundColor: const Color(0xFF1B8A6B),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
