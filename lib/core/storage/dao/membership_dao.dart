import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/memberships_table.dart';

part 'membership_dao.g.dart';

@DriftAccessor(tables: [Memberships])
class MembershipDao extends DatabaseAccessor<AppDatabase>
    with _$MembershipDaoMixin {
  MembershipDao(super.db);

  Future<Membership?> getMembership(String userId, String organizationId) =>
      (select(memberships)..where(
            (t) =>
                t.userId.equals(userId) &
                t.organizationId.equals(organizationId),
          ))
          .getSingleOrNull();

  Future<List<Membership>> getMembershipsForUser(String userId) =>
      (select(memberships)..where((t) => t.userId.equals(userId))).get();

  Future<List<Membership>> getMembershipsForOrganization(
    String organizationId,
  ) => (select(
    memberships,
  )..where((t) => t.organizationId.equals(organizationId))).get();

  Future<int> createMembership(MembershipsCompanion membership) =>
      into(memberships).insert(membership);

  Future<bool> updateMembership(MembershipsCompanion membership) =>
      update(memberships).replace(membership);

  Future<int> deleteMembership(String id) =>
      (delete(memberships)..where((t) => t.id.equals(id))).go();
}
