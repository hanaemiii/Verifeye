class AppUser {
  final String uid;
  String firstName;
  String lastName;
  final String email;
  String? photoUrl;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: (map['uid'] ?? '') as String,
      firstName: (map['firstName'] ?? '') as String,
      lastName: (map['lastName'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      photoUrl: map['photoUrl'] as String?,
    );
  }
}
