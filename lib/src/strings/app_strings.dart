class AppStrings {
  const AppStrings._();

  // Auth - Login
  static const String appName = 'ProjectFlow';
  static const String adminConsole = 'Admin Console';
  static const String welcomeBack = 'Welcome back';
  static const String loginSubtitle =
      'Enter your credentials to access the admin console.';
  static const String emailLabel = 'Email address';
  static const String emailHint = 'e.g. admin@company.com';
  static const String passwordLabel = 'Password';
  static const String forgotPassword = 'Forgot password?';
  static const String loginButton = 'Login to Console';
  static const String loginButtonSemantic = 'Login to Admin Console';
  static const String needWorkspace = 'Need a workspace? ';
  static const String createAccount = 'Create account';
  static const String createOrg = 'Create a new organization';
  static const String enterpriseReady = 'Enterprise Ready';
  static const String enterpriseDesc =
      'Secure multi-tenant infrastructure designed for rapid scaling.';

  // Auth - Signup
  static const String setupNewOrg = 'Setup New Organization';
  static const String setupOrgSubtitle =
      "You're one step away from launching your shared workspace. Complete these details to get started.";
  static const String userDetails = 'User Details';
  static const String fullNameLabel = 'FULL NAME';
  static const String fullNameHint = 'Jane Doe';
  static const String workEmailLabel = 'WORK EMAIL';
  static const String passwordHint = '........';
  static const String passwordHelper = 'At least 8 characters.';
  static const String orgDetails = 'Organization Details';
  static const String companyNameLabel = 'COMPANY NAME';
  static const String companyNameHint = 'Acme Inc.';
  static const String adminPrivileges = 'Administrator Privileges';
  static const String adminPrivilegesDesc =
      'As the creator of this organization, you will be assigned the Owner role. You can invite team members later.';
  static const String agreeTo = 'I agree to the ';
  static const String termsOfService = 'Terms of Service';
  static const String and = ' and ';
  static const String privacyPolicy = 'Privacy Policy';
  static const String createAccountBtn = 'Create Account';
  static const String createAccountOrgBtn = 'Create account & organization';
  static const String alreadyHaveAccount = 'Already have an account? Log in';
  static const String signupFailed = 'Signup Failed';

  // Dashboard - Sidebar
  static const String sidebarDashboard = 'Dashboard';
  static const String sidebarMembers = 'Members';
  static const String sidebarRoles = 'Roles & Permissions';
  static const String sidebarSettings = 'Settings'; // For Emp View
  static const String sidebarSupport = 'Support';

  // Dashboard - Members
  static const String membersTitle = 'Members';
  static const String membersSubtitle =
      "Manage your organization's members, control access levels, and invite new\ncontributors to your projects.";
  static const String exportCsv = 'Export CSV';
  static const String sendInvite = 'Send Invite';

  // Dashboard - Topbar
  static const String orgOverview = 'Organization Overview';
  static const String quickActions = 'Quick Actions';
  static const String topbarOrgName = 'Acme Corp'; // Mock
  static const String topbarAdminLabel = 'ADMIN';
  static const String topbarSearchHint = 'Search members...';
  static const String topbarUserName = 'Jane Doe'; // Mock
  static const String topbarUserRole = 'Super Admin'; // Mock
  static const String topbarSearchHintExpanded =
      'Search resources, users, or settings (Ctrl+K)';
  static const String selectOrganization = 'Select Organization';
  static const String selectProject = 'Select Project';
  static const String orgLabelShort = 'ORG:';
  static const String selectOrgPlaceholder = 'Select Org';
  static const String allProjects = 'All Projects';

  // Dashboard - KPI
  static const String kpiTotalMembers = 'TOTAL MEMBERS';
  static const String kpiSystemStatus = 'SYSTEM STATUS';
  static const String kpiPendingInvites = 'PENDING INVITES';

  // Dashboard - Admin Quick Actions
  static const String inviteMember = 'Invite Member';
  static const String inviteMemberDesc = 'Add new users to your organization';
  static const String manageRoles = 'Manage Roles';
  static const String manageRolesDesc = 'Configure access permissions';
  static const String orgSettings = 'Organization Settings';
  static const String orgSettingsDesc = 'Update company profile and branding';

  // Dashboard - Employee
  static const String greeting = 'Good Morning, Jane'; // Mock
  static const String greetingSubtitle = "Here's what's happening today.";
  static const String myProjects = 'My Projects';
  static const String recentUpdates = 'Recent Updates';

  // Global Search
  static const String globalSearchPlaceholder =
      'Search users, projects, settings…';
  static const String globalSearchNoResults = 'No results found';
  static const String globalSearchEmptyState =
      'Try searching for users, projects, or settings';

  // Common
  static const String loading = 'Loading...';
}
