import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/users_table.dart';
import 'tables/organizations_table.dart';
import 'tables/roles_table.dart';
import 'tables/memberships_table.dart';

import 'dao/user_dao.dart';
import 'dao/organization_dao.dart';
import 'dao/membership_dao.dart';

import 'migrations/migration_v1.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Users, Organizations, Roles, Memberships],
  daos: [UserDao, OrganizationDao, MembershipDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_organizations_name ON organizations (name)',
      );
      await seedRolesV1(this);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'workhub.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
