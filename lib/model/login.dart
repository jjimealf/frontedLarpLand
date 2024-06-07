class Login {
  final String status;
  final int rol;
  final String message;

  const Login({
    required this.status,
    required this.rol,
    required this.message,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': String status,
        'rol': int rol,
        'message': String message,
      } =>
        Login(
          status: status,
          rol: rol,
          message: message,
        ),
      _ => throw Exception('Login invalido'),
    };
  }
}
