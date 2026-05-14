import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../viewmodels/saved_viewmodel.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../models/recipe_model.dart';
import '../../models/video_model.dart';
import '../../utils/recipe_navigator.dart';
import '../../utils/app_navigator.dart';
import '../auth/sign_in_screen.dart';
import 'settings_screen.dart';
import 'widgets/profile_stat_item.dart';
import 'widgets/profile_tab_button.dart';
import 'widgets/profile_recipe_card.dart';
import 'widgets/profile_video_card.dart';
import '../recipe/add_recipe_screen.dart';

import 'add_video_screen.dart';
import 'video_player_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  bool _showFullBio = false;

  static const Color _primary = Color(0xFF1B8A6B);
  static const Color _textDark = Color(0xFF1A1A1A);
  static const Color _textGrey = Color(0xFF9E9E9E);

  // ── Pick profile image ────────────────────────────────────────────────
  void _pickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose Profile Photo',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: _primary),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await context
                      .read<ProfileViewModel>()
                      .pickImage(ImageSource.camera);
                  final profileVm = context.read<ProfileViewModel>();
                  if (profileVm.profileImagePath != null) {
                    context.read<HomeViewModel>().setUser(
                          context.read<HomeViewModel>().user.copyWith(
                                profileImage: profileVm.profileImagePath,
                              ),
                        );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: _primary),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await context
                      .read<ProfileViewModel>()
                      .pickImage(ImageSource.gallery);
                  final profileVm = context.read<ProfileViewModel>();
                  if (profileVm.profileImagePath != null) {
                    context.read<HomeViewModel>().setUser(
                          context.read<HomeViewModel>().user.copyWith(
                                profileImage: profileVm.profileImagePath,
                              ),
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Edit Profile ──────────────────────────────────────────────────────
  void _editProfile(BuildContext context, ProfileViewModel profileVm) {
    final nameCtrl = TextEditingController(text: profileVm.name);
    final bioCtrl = TextEditingController(text: profileVm.bio);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Edit Profile',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameCtrl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF1B8A6B)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioCtrl,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF1B8A6B)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    profileVm.updateProfile(
                      name: nameCtrl.text,
                      bio: bioCtrl.text,
                    );
                    context.read<HomeViewModel>().setUser(
                          context.read<HomeViewModel>().user.copyWith(
                                name: nameCtrl.text.trim(),
                                profileImage: profileVm.profileImagePath,
                              ),
                        );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B8A6B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Save',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  // ── Logout ────────────────────────────────────────────────────────────
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppNavigator.pushAndRemoveAll(
                  context, const SignInScreen());
            },
            child: const Text('Logout',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ── More options ──────────────────────────────────────────────────────
  void _showOptions(
      BuildContext context, ProfileViewModel profileVm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add_circle_outline,
                    color: Color(0xFF1B8A6B)),
                title: const Text('Add New Recipe'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddRecipeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_call_outlined,
                    color: Color(0xFF1B8A6B)),
                title: const Text('Add New Video'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddVideoScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined,
                    color: Color(0xFF1B8A6B)),
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.pop(context);
                  _editProfile(context, profileVm);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined,
                    color: Color(0xFF1B8A6B)),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  _openSettings(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading:
                    const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Settings ──────────────────────────────────────────────────────────
  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  // ── Confirm Delete ───────────────────────────────────────────────────
  void _confirmDelete(
      BuildContext context, HomeViewModel vm, RecipeModel recipe) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text('Are you sure you want to delete "${recipe.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              vm.deleteRecipe(recipe.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Recipe deleted'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: const Color(0xFF1B8A6B),
                    onPressed: () {
                      vm.undoDelete();
                    },
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final profileVm = context.watch<ProfileViewModel>();
    final savedVm = context.watch<SavedViewModel>();
    final recipes = vm.userRecipes;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── AppBar ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    const Text('Profile',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _textDark)),
                    IconButton(
                      icon: const Icon(Icons.more_horiz,
                          color: _textDark),
                      onPressed: () =>
                          _showOptions(context, profileVm),
                    ),
                  ],
                ),
              ),
            ),

            // ── Profile Header ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with camera icon
                    GestureDetector(
                      onTap: () => _pickImage(context),
                      child: Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: _primary, width: 2.5),
                              color: const Color(0xFFE8F5E9),
                            ),
                            child: ClipOval(
                              child: profileVm.profileImagePath != null
                                  ? Image.file(
                                      File(profileVm
                                          .profileImagePath!),
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.person,
                                      size: 50,
                                      color: Colors.grey.shade400),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: _primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Stats
                    Expanded(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileStatItem(
                              label: 'Recipe',
                              value: '${recipes.length}'),
                          ProfileStatItem(
                              label: 'Followers', value: '2.5M'),
                          ProfileStatItem(
                              label: 'Following', value: '259'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Name + Bio ──────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileVm.name.isNotEmpty
                          ? profileVm.name
                          : vm.user.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _textDark),
                    ),
                    const SizedBox(height: 2),
                    const Text('Chef',
                        style: TextStyle(
                            fontSize: 13, color: _textGrey)),
                    const SizedBox(height: 8),
                    Text(
                      _showFullBio
                          ? profileVm.bio
                          : profileVm.bio.split('\n').first,
                      style: const TextStyle(
                          fontSize: 13,
                          color: _textDark,
                          height: 1.5),
                    ),
                    GestureDetector(
                      onTap: () => setState(
                          () => _showFullBio = !_showFullBio),
                      child: Text(
                        _showFullBio ? 'Less...' : 'More...',
                        style: const TextStyle(
                            fontSize: 13,
                            color: _primary,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Tabs ───────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: [
                    ProfileTabButton(
                      label: 'Recipe',
                      isSelected: _selectedTab == 0,
                      onTap: () =>
                          setState(() => _selectedTab = 0),
                    ),
                    const SizedBox(width: 20),
                    ProfileTabButton(
                      label: 'Videos',
                      isSelected: _selectedTab == 1,
                      onTap: () =>
                          setState(() => _selectedTab = 1),
                    ),
                    const SizedBox(width: 20),
                    ProfileTabButton(
                      label: 'Tag',
                      isSelected: _selectedTab == 2,
                      onTap: () =>
                          setState(() => _selectedTab = 2),
                    ),
                  ],
                ),
              ),
            ),

            // ── Content ────────────────────────────────────────────
            if (_selectedTab == 0)
              recipes.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.restaurant_menu,
                                  size: 60, color: Color(0xFFEEEEEE)),
                              SizedBox(height: 16),
                              Text(
                                'No recipe yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _textGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: ProfileRecipeCard(
                              recipe: recipes[index],
                              isSaved: savedVm.isSaved(recipes[index].id),
                              onTap: () =>
                                  openRecipeDetail(context, recipes[index]),
                              onSave: () {
                                final r = recipes[index];
                                if (savedVm.isSaved(r.id)) {
                                  savedVm.removeRecipe(r.id);
                                } else {
                                  savedVm.addRecipe(r);
                                }
                              },
                              onDelete: () {
                                _confirmDelete(context, vm, recipes[index]);
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddRecipeScreen(
                                      recipe: recipes[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          childCount: recipes.length,
                        ),
                      ),
                    )
            else if (_selectedTab == 1)
              vm.userVideos.isEmpty
                  ? const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: Text('No videos yet',
                              style: TextStyle(
                                  color: _textGrey, fontSize: 15)),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProfileVideoCard(
                            video: vm.userVideos[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoPlayerScreen(
                                    video: vm.userVideos[index],
                                  ),
                                ),
                              );
                            },
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddVideoScreen(
                                    video: vm.userVideos[index],
                                  ),
                                ),
                              );
                            },
                            onDelete: () {
                              _confirmDeleteVideo(context, vm, vm.userVideos[index]);
                            },
                          ),
                          childCount: vm.userVideos.length,
                        ),
                      ),
                    )
            else
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Text('No tags yet',
                        style: TextStyle(
                            color: _textGrey, fontSize: 15)),
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteVideo(BuildContext context, HomeViewModel vm, VideoModel video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: Text('Are you sure you want to delete "${video.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              vm.deleteVideo(video.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Video deleted'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => vm.undoDeleteVideo(),
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
