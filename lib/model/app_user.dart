class AppUser {
  final String id;
  final String email;
  final String username;
  final String? avatarUrl;
  final DateTime createdAt;
  final bool creatorMode;

  AppUser({
    required this.id,
    required this.email,
    required this.username,
    this.avatarUrl,
    required this.createdAt,
    this.creatorMode = false,
  });

  factory AppUser.fromFirestore(Map<String, dynamic> data, String docId) {
    return AppUser(
      id: docId,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      avatarUrl: data['avatarUrl'],
      createdAt: DateTime.parse(data['createdAt']),
      creatorMode: data['creatorMode'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email': email,
    'username': username,
    'avatarUrl': avatarUrl,
    'createdAt': createdAt.toIso8601String(),
    'creatorMode': creatorMode,
  };
}

