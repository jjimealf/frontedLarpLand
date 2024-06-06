class User {

  final int id;
  final String name;
  final String email;
  final String password;
  final int rol;
   
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'password': String password,
        'rol': int rol,
      } =>
        User(
          id: id,
          name: name,
          email: email,
          password: password,
          rol: rol,
        ),
      _ => throw Exception('Registro invalido'),
    };
  }
}