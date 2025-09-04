class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? profileImageUrl;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      uid: documentId,
      name: data['name'],
      email: data['email'],
      profileImageUrl: data['profileImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
