class Login {
  final int status;
  final String message;
  final int rol;

  const Login({
    required this.status,
    required this.message,
    required this.rol,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': int status,
        'message': String message,
        'rol': int rol,
      } =>
        Login(
          status: status,
          message: message,
          rol: rol,
        ),
      _ => throw Exception('Login invalido'),
    };
  }
}
