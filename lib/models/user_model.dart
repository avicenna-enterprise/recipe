
class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage = '',
  });


  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';


  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}