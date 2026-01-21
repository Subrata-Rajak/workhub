// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_dao.dart';

// ignore_for_file: type=lint
mixin _$OrganizationDaoMixin on DatabaseAccessor<AppDatabase> {
  $OrganizationsTable get organizations => attachedDatabase.organizations;
  $UsersTable get users => attachedDatabase.users;
  $RolesTable get roles => attachedDatabase.roles;
  $MembershipsTable get memberships => attachedDatabase.memberships;
  OrganizationDaoManager get managers => OrganizationDaoManager(this);
}

class OrganizationDaoManager {
  final _$OrganizationDaoMixin _db;
  OrganizationDaoManager(this._db);
  $$OrganizationsTableTableManager get organizations =>
      $$OrganizationsTableTableManager(_db.attachedDatabase, _db.organizations);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$MembershipsTableTableManager get memberships =>
      $$MembershipsTableTableManager(_db.attachedDatabase, _db.memberships);
}
