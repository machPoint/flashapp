import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/account_provider.dart';
import 'package:mathflash/screens/account/account_screen.dart';

class UpperStrip extends StatelessWidget {
  const UpperStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final user = accountProvider.currentUser;
    
    return Container(
      height: 40,
      color: Theme.of(context).colorScheme.surfaceVariant,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Logo/Brand
          Row(
            children: [
              Icon(
                Icons.school,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'MathFlash',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          
          // Right side - Account info
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
            child: Row(
              children: [
                // Show premium badge if applicable
                if (user.isPremium) ...[
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber.shade700,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                
                // User avatar/initial
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    user.isGuest 
                        ? 'G' 
                        : user.displayName.isNotEmpty 
                            ? user.displayName[0].toUpperCase() 
                            : '?',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // User name or "Account"
                Text(
                  user.isGuest ? 'Account' : user.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 4),
                
                // Dropdown indicator
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
