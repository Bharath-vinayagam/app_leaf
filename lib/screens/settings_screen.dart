import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../providers/disease_history_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            const SizedBox(width: 10),
            const Text('Settings'),
          ],
        ),
        elevation: 4,
        backgroundColor: const Color(0xFF047857),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe0f2f1), Color(0xfff1f8f4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Theme Settings
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appearance',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Column(
                          children: [
                            _SettingsTile(
                              icon: Icons.brightness_auto,
                              title: 'System',
                              subtitle: 'Follow system theme',
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.system,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                            _SettingsTile(
                              icon: Icons.light_mode,
                              title: 'Light',
                              subtitle: 'Light theme',
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.light,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                            _SettingsTile(
                              icon: Icons.dark_mode,
                              title: 'Dark',
                              subtitle: 'Dark theme',
                              trailing: Radio<ThemeMode>(
                                value: ThemeMode.dark,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setThemeMode(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Data Management
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Management',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SettingsTile(
                      icon: Icons.delete_forever,
                      title: 'Clear History',
                      subtitle: 'Delete all detection history',
                      onTap: () {
                        _showClearHistoryDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // About
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SettingsTile(
                      icon: Icons.info,
                      title: 'App Version',
                      subtitle: '1.0.0',
                    ),
                    _SettingsTile(
                      icon: Icons.description,
                      title: 'Privacy Policy',
                      subtitle: 'Read our privacy policy',
                      onTap: () {
                        // TODO: Navigate to privacy policy
                      },
                    ),
                    _SettingsTile(
                      icon: Icons.description,
                      title: 'Terms of Service',
                      subtitle: 'Read our terms of service',
                      onTap: () {
                        // TODO: Navigate to terms of service
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Notification Settings
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notifications',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile.adaptive(
                      value: true, // TODO: Bind to real setting
                      onChanged: (val) {
                        // TODO: Save notification setting
                      },
                      title: const Text('Disease Reminders & Tips'),
                      subtitle: const Text('Enable notifications for disease reminders and tips'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Image Quality Settings
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Image Quality',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: 'standard', // TODO: Bind to real setting
                            items: const [
                              DropdownMenuItem(value: 'standard', child: Text('Standard')),
                              DropdownMenuItem(value: 'high', child: Text('High Resolution')),
                            ],
                            onChanged: (val) {
                              // TODO: Save image quality setting
                            },
                            decoration: const InputDecoration(
                              labelText: 'Scan Mode',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Storage Info
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Storage',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Storage Used: 12.3 MB',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // TODO: Clear cache logic
                          },
                          icon: const Icon(Icons.cleaning_services),
                          label: const Text('Clear Cache'),
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Export Data
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Export Data',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Export as PDF
                            },
                            icon: const Icon(Icons.picture_as_pdf),
                            label: const Text('Export as PDF'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Export as CSV
                            },
                            icon: const Icon(Icons.table_chart),
                            label: const Text('Export as CSV'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Developer Info / Credits
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Developer & Credits',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Created by Cavin and Bharath'),
                      subtitle: const Text('github.com/Bharath-123'),
                      onTap: () {
                        // TODO: Open GitHub
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Acknowledgements'),
                      subtitle: const Text('Thanks to open source & contributors'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Feedback & Support
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback & Support',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Open feedback form or email
                      },
                      icon: const Icon(Icons.feedback),
                      label: const Text('Send Feedback / Report Issue'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Reset App
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset App',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        _showResetAppDialog(context);
                      },
                      icon: const Icon(Icons.restore),
                      label: const Text('Restore to Default Settings'),
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

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text(
          'Are you sure you want to delete all detection history? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<DiseaseHistoryProvider>().clearHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App'),
        content: const Text('Are you sure you want to reset the app to default settings? This will clear all data and preferences.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Reset app logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('App reset to default settings')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
} 