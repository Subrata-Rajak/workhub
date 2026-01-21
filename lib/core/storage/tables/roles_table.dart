import 'package:drift/drift.dart';

class Roles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}
