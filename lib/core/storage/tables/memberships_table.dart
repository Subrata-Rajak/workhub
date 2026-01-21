import 'package:drift/drift.dart';
import 'users_table.dart';
import 'organizations_table.dart';
import 'roles_table.dart';

class Memberships extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get organizationId => text().references(Organizations, #id)();
  IntColumn get roleId => integer().references(Roles, #id)();
  TextColumn get status => text()(); // INVITED | ACTIVE | SUSPENDED
  DateTimeColumn get joinedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (user_id, organization_id)'];
}
