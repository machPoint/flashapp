import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/account_provider.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/theme/theme_constants.dart';
import 'package:mathflash/theme/screens/theme_selection_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = accountProvider.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(
                            user.isGuest 
                                ? 'G' 
                                : user.displayName.isNotEmpty 
                                    ? user.displayName[0].toUpperCase() 
                                    : '?',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.displayName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (!user.isGuest) Text(
                                user.email,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              user.isPremium
                                  ? Chip(
                                      label: const Text('Premium'),
                                      backgroundColor: Colors.amber.shade100,
                                      avatar: const Icon(Icons.star, color: Colors.amber),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (user.isGuest)
                      ElevatedButton(
                        onPressed: () => _showLoginDialog(context),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                        ),
                        child: const Text('Sign In'),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          accountProvider.signOut();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                        ),
                        child: const Text('Sign Out'),
                      ),
                  ],
                ),
              ),
            ),

            // App Settings Section
            Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.color_lens),
                      title: const Text('Theme Selection'),
                      subtitle: const Text('Choose a theme for the app'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThemeSelectionScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_awesome),
                      title: const Text('Cosmic Theme'),
                      subtitle: const Text('Apply space-themed UI'),
                      trailing: themeProvider.themeType == ThemeConstants.cosmicTheme
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () {
                        themeProvider.setThemeType(ThemeConstants.cosmicTheme);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cosmic theme applied!'),
                            backgroundColor: Color(0xFF9C42F5),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Dark Mode'),
                      leading: const Icon(Icons.dark_mode),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (_) => themeProvider.toggleLightDark(),
                      ),
                      onTap: () => themeProvider.toggleLightDark(),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Notifications'),
                      leading: const Icon(Icons.notifications),
                      trailing: const Switch(
                        value: false,
                        onChanged: null, // Disabled for now
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notifications will be available in a future update'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Purchases Section
            Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchases',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    if (user.isGuest)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Sign in to view your purchases'),
                        ),
                      )
                    else if (user.purchasedPackIds.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No purchases yet'),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: user.purchasedPackIds.length,
                        itemBuilder: (context, index) {
                          final packId = user.purchasedPackIds[index];
                          return ListTile(
                            title: Text(_formatPackName(packId)),
                            leading: Icon(
                              packId.contains('geometry') 
                                  ? Icons.category 
                                  : Icons.bar_chart,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            trailing: const Icon(Icons.download),
                            onTap: () {
                              // Navigate to the pack
                            },
                          );
                        },
                      ),
                    if (!user.isPremium) ...[
                      const Divider(),
                      ListTile(
                        title: const Text('Upgrade to Premium'),
                        subtitle: const Text('Get access to all packs'),
                        leading: const Icon(Icons.star, color: Colors.amber),
                        trailing: const Text('\$9.99'),
                        onTap: () {
                          _showPremiumDialog(context);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Support Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: const Text('Help & FAQ'),
                      leading: const Icon(Icons.help),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Help section coming soon'),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Contact Support'),
                      leading: const Icon(Icons.support_agent),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Support contact coming soon'),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('About'),
                      leading: const Icon(Icons.info),
                      onTap: () {
                        _showAboutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPackName(String packId) {
    return packId
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _showLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign In'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  
                  final accountProvider = Provider.of<AccountProvider>(
                    context, 
                    listen: false,
                  );
                  
                  accountProvider.signIn(
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
              child: const Text('Sign In'),
            ),
          ],
        );
      },
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upgrade to Premium'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Get access to all current and future flashcard packs for a one-time payment.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '\$9.99',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                
                final accountProvider = Provider.of<AccountProvider>(
                  context, 
                  listen: false,
                );
                
                if (accountProvider.isLoggedIn) {
                  accountProvider.upgradeToPremium();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Upgraded to Premium!'),
                    ),
                  );
                } else {
                  _showLoginDialog(context);
                }
              },
              child: const Text('Upgrade'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About MathFlash'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'MathFlash is a flashcard app designed to help you learn math concepts through visual flashcards.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Version 1.0.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '© 2025 MathFlash',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
