
class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String username;
  final String bio;
  final String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage = '',
    this.username = '',
    this.bio = '',
    this.gender = '',
  });


  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';


  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? username,
    String? bio,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
    );
  }
}