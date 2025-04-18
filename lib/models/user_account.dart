class UserAccount {
  final String id;
  final String email;
  final String displayName;
  final List<String> purchasedPackIds;
  final bool isPremium;

  UserAccount({
    required this.id,
    required this.email,
    required this.displayName,
    this.purchasedPackIds = const [],
    this.isPremium = false,
  });

  // Create a default guest account
  factory UserAccount.guest() {
    return UserAccount(
      id: 'guest',
      email: '',
      displayName: 'Guest',
      purchasedPackIds: [],
      isPremium: false,
    );
  }
  
  // Create a demo account with full access for testing
  factory UserAccount.demo() {
    return UserAccount(
      id: 'demo',
      email: 'demo@mathflash.app',
      displayName: 'Demo User',
      purchasedPackIds: ['geometry_basics', 'stats_distributions', 'geometry_advanced'],
      isPremium: true,
    );
  }

  // Check if a specific pack is purchased
  bool isPackPurchased(String packId) {
    return purchasedPackIds.contains(packId);
  }

  // Check if the user is a guest
  bool get isGuest => id == 'guest';
}
