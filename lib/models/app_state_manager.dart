import 'dart:async';

import 'package:flutter/material.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;

  // Checks to see if the user is logged in
  bool _loggedIn = false;

  // Checks to see if the user has completed onboarding
  bool _onboardingComplete = false;

  // Records the current tab the user is on.
  int _selectedTab = FooderlichTab.explore;

  bool get isInitialized => _initialized;

  bool get isLoggedIn => _loggedIn;

  bool get isOnBoardingComplete => _onboardingComplete;

  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void login(String userName, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void completeOnBoarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() {
    // 12
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }
}
