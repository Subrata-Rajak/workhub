class Project {
  final String id;
  final String name;
  final String status; // 'Active', 'Archived'

  const Project({required this.id, required this.name, required this.status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
