import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/organizations_table.dart';
import '../tables/memberships_table.dart';

part 'organization_dao.g.dart';

@DriftAccessor(tables: [Organizations, Memberships])
class OrganizationDao extends DatabaseAccessor<AppDatabase>
    with _$OrganizationDaoMixin {
  OrganizationDao(super.db);

  Future<Organization?> getOrganizationById(String id) =>
      (select(organizations)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Organization>> getOrganizationsForUser(String userId) {
    // Join organizations with memberships to find orgs a user belongs to
    final query = select(organizations).join([
      innerJoin(
        memberships,
        memberships.organizationId.equalsExp(organizations.id),
      ),
    ])..where(memberships.userId.equals(userId));

    return query.map((row) => row.readTable(organizations)).get();
  }

  Future<int> createOrganization(OrganizationsCompanion organization) =>
      into(organizations).insert(organization);

  Future<bool> updateOrganization(OrganizationsCompanion organization) =>
      update(organizations).replace(organization);
}
