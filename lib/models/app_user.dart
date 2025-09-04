class AppUser {
  final String uid;
  final String name;
  final String email;

  AppUser({required this.uid, required this.name, required this.email});

  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    final String name = data['name'];
    final String email = data['email'];
    return AppUser(uid: documentId, name: name, email: email);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
