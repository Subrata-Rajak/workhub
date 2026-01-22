class Organization {
  final String id;
  final String name;
  final String role; // 'Admin', 'Member', etc.

  const Organization({
    required this.id,
    required this.name,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Organization &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
