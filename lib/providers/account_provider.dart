import 'package:flutter/material.dart';
import 'package:mathflash/models/user_account.dart';

class AccountProvider extends ChangeNotifier {
  // Using demo account by default for easier testing
  UserAccount _currentUser = UserAccount.demo();
  
  UserAccount get currentUser => _currentUser;
  
  bool get isLoggedIn => !_currentUser.isGuest;

  // Sign in a user (simplified for now)
  Future<bool> signIn(String email, String password) async {
    // In a real app, this would validate credentials against a backend
    // For now, we'll simulate a successful login with a mock account
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      _currentUser = UserAccount(
        id: 'user123',
        email: email,
        displayName: email.split('@').first,
        purchasedPackIds: ['geometry_basics', 'stats_distributions'],
        isPremium: true,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    _currentUser = UserAccount.guest();
    notifyListeners();
  }

  // Purchase a pack
  Future<bool> purchasePack(String packId) async {
    // In a real app, this would integrate with a payment processor
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final updatedPurchasedPacks = List<String>.from(_currentUser.purchasedPackIds);
      if (!updatedPurchasedPacks.contains(packId)) {
        updatedPurchasedPacks.add(packId);
      }
      
      _currentUser = UserAccount(
        id: _currentUser.id,
        email: _currentUser.email,
        displayName: _currentUser.displayName,
        purchasedPackIds: updatedPurchasedPacks,
        isPremium: _currentUser.isPremium,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Upgrade to premium
  Future<bool> upgradeToPremium() async {
    // In a real app, this would integrate with a payment processor
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      _currentUser = UserAccount(
        id: _currentUser.id,
        email: _currentUser.email,
        displayName: _currentUser.displayName,
        purchasedPackIds: _currentUser.purchasedPackIds,
        isPremium: true,
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
