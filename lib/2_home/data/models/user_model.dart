class User {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'avatarUrl': avatarUrl,
      'isVerified': isVerified,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? avatarUrl,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }

}
