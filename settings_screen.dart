import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Import Provider
// import 'theme_provider.dart'; // Import ThemeProvider

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool _notificationsEnabled = true;
  // bool _leakAlertsEnabled = true;
  // bool _weeklyReportsEnabled = true;
  // bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section
              _buildSectionHeader('Profile'),
              const SizedBox(height: 8),
              _buildProfileCard(),

              const SizedBox(height: 24),

              // Notifications section
              // _buildSectionHeader('Notifications'),
              // const SizedBox(height: 8),
              // _buildSettingSwitch(
              //   'Enable Notifications',
              //   'Receive push notifications',
              //   _notificationsEnabled,
              //       (value) {
              //     setState(() {
              //       _notificationsEnabled = value;
              //     });
              //   },
              // ),
              // _buildSettingSwitch(
              //   'Leak Alerts',
              //   'Get notified immediately when a leak is detected',
              //   _leakAlertsEnabled,
              //       (value) {
              //     setState(() {
              //       _leakAlertsEnabled = value;
              //     });
              //   },
              // ),
              // _buildSettingSwitch(
              //   'Weekly Reports',
              //   'Receive weekly water consumption reports',
              //   _weeklyReportsEnabled,
              //       (value) {
              //     setState(() {
              //       _weeklyReportsEnabled = value;
              //     });
              //   },
              // ),
              //
              // const SizedBox(height: 24),

              // // Appearance section
              // _buildSectionHeader('Appearance'),
              // const SizedBox(height: 8),
              // _buildSettingSwitch(
              //   'Dark Mode',
              //   'Use dark theme',
              //   _darkModeEnabled,
              //       (value) {
              //     setState(() {
              //       _darkModeEnabled = value;
              //     });
              //   },
              // ),
              //
              // const SizedBox(height: 24),

              // About section
              _buildSectionHeader('General Settings'),
              const SizedBox(height: 8),
              _buildGeneralCard(),

              const SizedBox(height: 24),

              // Logout button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle logout
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
                              // Perform logout
                              Navigator.pop(context);
                              // Navigate to login screen
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Go to Home',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.person_2_rounded,
                    size: 30,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vivek Tiwari',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'vivek@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit profile screen
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            _buildProfileInfoRow('Phone', '+91 88662 46103'),
            const SizedBox(height: 8),
            _buildProfileInfoRow('Address', 'Ahmedabad'),
            const SizedBox(height: 8),
            _buildProfileInfoRow('Member Since', 'March 2025'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget _buildSettingSwitch(
  //     String title,
  //     String subtitle,
  //     bool value,
  //     Function(bool) onChanged,
  //     ) {
  //   return Card(
  //     elevation: 7,
  //     color: Colors.blueGrey.shade50,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   subtitle,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey.shade600,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Switch(
  //             value: value,
  //             onChanged: onChanged,
  //             activeColor: Colors.blue,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildGeneralCard() {
    return Card(
      elevation: 7,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.blue.shade700),
            title: const Text('App Version'),
            trailing: const Text('1.0.0.1'),
          ),
          // const Divider(height: 1),
          // ListTile(
          //   leading: Icon(Icons.description_outlined, color: Colors.blue.shade700),
          //   title: const Text('Terms of Service'),
          //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          //   onTap: () {
          //     // Navigate to terms of service
          //   },
          // ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: Colors.blue.shade700),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.developer_board, color: Colors.blue.shade700),
            title: const Text('About Us'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.blue.shade700),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to help & support
            },
          ),
        ],
      ),
    );
  }
}