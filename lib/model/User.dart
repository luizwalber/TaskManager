class User {
  final String id;
  final String name;
  final String photoUrl;

  User({this.id, this.name, this.photoUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserEntity{id: $id, displayName: $name, photoUrl: $photoUrl}';
  }
}
