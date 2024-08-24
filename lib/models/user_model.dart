class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  String? photoUrl;
  String? password;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.photoUrl,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
      'password': password,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: (map['uid'] ?? '') as String,
      firstName: (map['firstName'] ?? '') as String,
      lastName: (map['lastName'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      photoUrl: map['photoUrl'] as String?,
      password: (map['password'] ?? '') as String?,
    );
  }
}
