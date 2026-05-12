class SignInModel {
  final String email;
  final String password;

  SignInModel({
    required this.email,
    required this.password,
  });
}

class SignUpModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
