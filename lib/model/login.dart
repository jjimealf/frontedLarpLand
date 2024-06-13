class Login {
  final String status;
  final int rol;
  final String message;
  final int userId;

  const Login({
    required this.status,
    required this.rol,
    required this.message,
    required this.userId,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': String status,
        'rol': int rol,
        'message': String message,
        'userId': int userId,
      } =>
        Login(
          status: status,
          rol: rol,
          message: message,
          userId: userId,
        ),
      _ => throw Exception('Login invalido'),
    };
  }
}
