import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 150, 245, 87),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade50, Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection(
              context,
              'Account Information',
              [
                _buildListTile('Name', user?.name ?? 'Not set', Icons.person),
                _buildListTile('Email', user?.email ?? 'Not set', Icons.email),
                _buildListTile('Member Since',
                    user?.memberSince ?? 'Not available', Icons.calendar_today),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'App Settings',
              [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme for the app'),
                  value: authService.isDarkMode,
                  onChanged: (value) => authService.setDarkMode(value),
                  secondary: const Icon(Icons.nightlight_round,
                      color: Colors.blueGrey),
                ),
                SwitchListTile(
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Receive updates and reminders'),
                  value: authService.enableNotifications,
                  onChanged: (value) =>
                      authService.setNotificationSettings(value),
                  secondary:
                      const Icon(Icons.notifications, color: Colors.blueGrey),
                ),
                ListTile(
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  leading: const Icon(Icons.language, color: Colors.blueGrey),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement language selection
                    Navigator.pushNamed(context, '/language');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Privacy & Security',
              [
                ListTile(
                  title: const Text('Change Password'),
                  leading: const Icon(Icons.lock, color: Colors.blueGrey),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement change password functionality
                    Navigator.pushNamed(context, '/change_password');
                  },
                ),
                ListTile(
                  title: const Text('Privacy Policy'),
                  leading:
                      const Icon(Icons.privacy_tip, color: Colors.blueGrey),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Show privacy policy
                    Navigator.pushNamed(context, '/privacy_policy');
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Button(
              onPressed: () {
                // Show confirmation dialog before logout
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          authService.logout();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              text: 'Logout',
            ),
            const SizedBox(height: 16),
            Text(
              'App Version: 1.0.0',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon, color: Colors.blueGrey),
    );
  }
}
