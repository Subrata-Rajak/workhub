import 'package:drift/drift.dart';
import '../app_database.dart';

Future<void> seedRolesV1(AppDatabase db) async {
  await db.batch((batch) {
    batch.insertAll(db.roles, [
      const RolesCompanion(name: Value('ADMIN')),
      const RolesCompanion(name: Value('MANAGER')),
      const RolesCompanion(name: Value('DEVELOPER')),
      const RolesCompanion(name: Value('VIEWER')),
    ]);
  });
}
