// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_dao.dart';

// ignore_for_file: type=lint
mixin _$MembershipDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $OrganizationsTable get organizations => attachedDatabase.organizations;
  $RolesTable get roles => attachedDatabase.roles;
  $MembershipsTable get memberships => attachedDatabase.memberships;
  MembershipDaoManager get managers => MembershipDaoManager(this);
}

class MembershipDaoManager {
  final _$MembershipDaoMixin _db;
  MembershipDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$OrganizationsTableTableManager get organizations =>
      $$OrganizationsTableTableManager(_db.attachedDatabase, _db.organizations);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$MembershipsTableTableManager get memberships =>
      $$MembershipsTableTableManager(_db.attachedDatabase, _db.memberships);
}
