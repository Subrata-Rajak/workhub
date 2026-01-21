import 'package:drift/drift.dart';

class Organizations extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get createdByUserId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
