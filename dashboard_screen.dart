import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leak_detection_screen.dart';
import 'plumber_booking_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dummy data for water consumption chart
  final List<FlSpot> weeklyConsumptionData = [
    FlSpot(0, 3.5),
    FlSpot(1, 2.8),
    FlSpot(2, 3.2),
    FlSpot(3, 4.1),
    FlSpot(4, 3.6),
    FlSpot(5, 2.9),
    FlSpot(6, 3.3),
  ];

  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  String userName = "Vivek"; // This would come from your authentication system
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _toggleNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
    await prefs.setBool('notifications_enabled', _notificationsEnabled);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_notificationsEnabled
            ? 'Notifications enabled'
            : 'Notifications disabled'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your logo asset
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.water_drop,
                color: Colors.blue.shade700,
                size: 30,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aquaminder',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Because, every drop counts!',
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              _notificationsEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined,
              color: _notificationsEnabled ? Colors.blue : Colors.grey,
            ),
            onPressed: _toggleNotifications,
            tooltip: _notificationsEnabled ? 'Disable notifications' : 'Enable notifications',
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen())
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Welcome section
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.blue.withOpacity(0.1),
              //         blurRadius: 10,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   // child: Column(
              //   //   crossAxisAlignment: CrossAxisAlignment.start,
              //   //   children: [
              //   //     Row(
              //   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   //       children: [
              //   //         Text(
              //   //           'Welcome back, $userName!',
              //   //           style: const TextStyle(
              //   //             fontSize: 18,
              //   //             fontWeight: FontWeight.bold,
              //   //           ),
              //   //         ),
              //   //         Container(
              //   //           padding: const EdgeInsets.symmetric(
              //   //             horizontal: 12,
              //   //             vertical: 6,
              //   //           ),
              //   //           decoration: BoxDecoration(
              //   //             color: Colors.green.shade100,
              //   //             borderRadius: BorderRadius.circular(20),
              //   //           ),
              //   //           child: Row(
              //   //             children: [
              //   //               Icon(
              //   //                 Icons.check_circle,
              //   //                 size: 16,
              //   //                 color: Colors.green.shade700,
              //   //               ),
              //   //               const SizedBox(width: 4),
              //   //               Text(
              //   //                 'No Leaks Detected',
              //   //                 style: TextStyle(
              //   //                   fontSize: 12,
              //   //                   color: Colors.green.shade700,
              //   //                   fontWeight: FontWeight.w500,
              //   //                 ),
              //   //               ),
              //   //             ],
              //   //           ),
              //   //         ),
              //   //       ],
              //   //     ),
              //   //     const SizedBox(height: 16),
              //   //     Text(
              //   //       'Water Consumption History',
              //   //       style: TextStyle(
              //   //         fontSize: 16,
              //   //         fontWeight: FontWeight.w600,
              //   //         color: Colors.blue.shade800,
              //   //       ),
              //   //     ),
              //   //     const SizedBox(height: 8),
              //   //     Text(
              //   //       'This Week',
              //   //       style: TextStyle(
              //   //         fontSize: 14,
              //   //         color: Colors.grey.shade600,
              //   //       ),
              //   //     ),
              //   //     const SizedBox(height: 16),
              //   //     SizedBox(
              //   //       height: 200,
              //   //       child: LineChart(
              //   //         LineChartData(
              //   //           gridData: FlGridData(
              //   //             show: true,
              //   //             drawVerticalLine: false,
              //   //             horizontalInterval: 1,
              //   //             getDrawingHorizontalLine: (value) {
              //   //               return FlLine(
              //   //                 color: Colors.grey.shade200,
              //   //                 strokeWidth: 1,
              //   //               );
              //   //             },
              //   //           ),
              //   //           titlesData: FlTitlesData(
              //   //             show: true,
              //   //             rightTitles: AxisTitles(
              //   //               sideTitles: SideTitles(showTitles: false),
              //   //             ),
              //   //             topTitles: AxisTitles(
              //   //               sideTitles: SideTitles(showTitles: false),
              //   //             ),
              //   //             bottomTitles: AxisTitles(
              //   //               sideTitles: SideTitles(
              //   //                 showTitles: true,
              //   //                 reservedSize: 30,
              //   //                 interval: 1,
              //   //                 getTitlesWidget: (value, meta) {
              //   //                   return SideTitleWidget(
              //   //                     axisSide: meta.axisSide,
              //   //                     space: 8.0,
              //   //                     child: Text(
              //   //                       weekDays[value.toInt() % weekDays.length],
              //   //                       style: TextStyle(
              //   //                         color: Colors.grey.shade600,
              //   //                         fontWeight: FontWeight.bold,
              //   //                         fontSize: 12,
              //   //                       ),
              //   //                     ),
              //   //                   );
              //   //                 },
              //   //               ),
              //   //             ),
              //   //             leftTitles: AxisTitles(
              //   //               sideTitles: SideTitles(
              //   //                 showTitles: true,
              //   //                 interval: 1,
              //   //                 getTitlesWidget: (value, meta) {
              //   //                   return SideTitleWidget(
              //   //                     axisSide: meta.axisSide,
              //   //                     space: 8.0,
              //   //                     child: Text(
              //   //                       '${value.toInt()} L',
              //   //                       style: TextStyle(
              //   //                         color: Colors.grey.shade600,
              //   //                         fontWeight: FontWeight.bold,
              //   //                         fontSize: 12,
              //   //                       ),
              //   //                     ),
              //   //                   );
              //   //                 },
              //   //                 reservedSize: 40,
              //   //               ),
              //   //             ),
              //   //           ),
              //   //           borderData: FlBorderData(
              //   //             show: false,
              //   //           ),
              //   //           minX: 0,
              //   //           maxX: 6,
              //   //           minY: 0,
              //   //           maxY: 6,
              //   //           lineBarsData: [
              //   //             LineChartBarData(
              //   //               spots: weeklyConsumptionData,
              //   //               isCurved: true,
              //   //               color: Colors.blue.shade500,
              //   //               barWidth: 3,
              //   //               isStrokeCapRound: true,
              //   //               dotData: FlDotData(
              //   //                 show: true,
              //   //                 getDotPainter: (spot, percent, barData, index) {
              //   //                   return FlDotCirclePainter(
              //   //                     radius: 4,
              //   //                     color: Colors.white,
              //   //                     strokeWidth: 2,
              //   //                     strokeColor: Colors.blue.shade500,
              //   //                   );
              //   //                 },
              //   //               ),
              //   //               belowBarData: BarAreaData(
              //   //                 show: true,
              //   //                 color: Colors.blue.withOpacity(0.2),
              //   //               ),
              //   //             ),
              //   //           ],
              //   //         ),
              //   //       ),
              //   //     ),
              //   //     const SizedBox(height: 16),
              //   //     Row(
              //   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   //       children: [
              //   //         _buildStatCard(
              //   //           'Total Usage',
              //   //           '23.4 L',
              //   //           Icons.water,
              //   //           Colors.blue,
              //   //         ),
              //   //         _buildStatCard(
              //   //           'Avg. Daily',
              //   //           '3.3 L',
              //   //           Icons.calendar_today,
              //   //           Colors.green,
              //   //         ),
              //   //         _buildStatCard(
              //   //           'Saved',
              //   //           '12%',
              //   //           Icons.trending_down,
              //   //           Colors.orange,
              //   //         ),
              //   //       ],
              //   //     ),
              //   //   ],
              //   // ),
              // ),

              const SizedBox(height: 24),
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 16),

              // Feature cards
              _buildFeatureCard(
                'Detect Leak',
                'Start monitoring for water leaks in real-time',
                Icons.warning_amber_rounded,
                Colors.red.shade400,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LeakDetectionScreen())
                  );
                },
              ),

              const SizedBox(height: 16),
              _buildFeatureCard(
                'Book a Plumber',
                'Schedule a professional plumber visit',
                Icons.plumbing,
                Colors.blue.shade400,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PlumberBookingScreen())
                  );
                },
              ),

              const SizedBox(height: 16),
              _buildFeatureCard(
                'Settings',
                'Manage your profile, notifications and preferences',
                Icons.settings,
                Colors.grey.shade700,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen())
                  );
                },
              ),

              const SizedBox(height: 24),
              // Water saving tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.amber.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Water Saving Tip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fix that dripping tap! A tap that drips once per second can waste more than 3,000 gallons of water per year.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      String title,
      String description,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}