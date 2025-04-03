import 'package:flutter/material.dart';
import 'plumber_booking_screen.dart';

class LeakDetectionScreen extends StatefulWidget {
  const LeakDetectionScreen({Key? key}) : super(key: key);

  @override
  State<LeakDetectionScreen> createState() => _LeakDetectionScreenState();
}

class _LeakDetectionScreenState extends State<LeakDetectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isScanning = true;
  bool _leakDetected = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Simulate a scan process
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          // For demo purposes, we'll simulate a leak detection
          _leakDetected = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leak Detection'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isScanning ? _buildScanningUI() : _buildResultUI(),
    );
  }

  Widget _buildScanningUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.5),
                    width: 8,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 150 + 20 * _animationController.value,
                    height: 150 + 20 * _animationController.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.3 - 0.2 * _animationController.value),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.water_drop,
                        size: 80,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          const Text(
            'Scanning for leaks...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Please wait while we analyze your water flow',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildResultUI() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _leakDetected ? _buildLeakDetectedUI() : _buildNoLeakUI(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Go to Home',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (_leakDetected)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to plumber booking
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlumberBookingScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Book a Plumber',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLeakDetectedUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.warning_rounded,
            size: 100,
            color: Colors.red.shade700,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Leak Detected!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildInfoRow('Location', 'Kitchen Sink'),
              const Divider(),
              _buildInfoRow('Flow Rate', '0.8 L/min'),
              const Divider(),
              _buildInfoRow('Estimated Waste', '48 L/day'),
              const Divider(),
              _buildInfoRow('Detected At', '${DateTime.now().hour}:${DateTime.now().minute}'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'We recommend fixing this leak as soon as possible to prevent water waste and potential damage.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildNoLeakUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            size: 100,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'No Leaks Detected',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildInfoRow('Last Scan', 'Just now'),
              const Divider(),
              _buildInfoRow('Flow Rate', 'Normal'),
              const Divider(),
              _buildInfoRow('Status', 'All systems normal'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Great! Your water system is working properly. We recommend scanning for leaks regularly.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class LeakDetectionScreen extends StatefulWidget {
//   const LeakDetectionScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LeakDetectionScreen> createState() => _LeakDetectionScreenState();
// }
//
// class _LeakDetectionScreenState extends State<LeakDetectionScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   bool _isScanning = true;
//   bool _deviceConnected = false;
//   bool _leakDetected = false;
//
//   // Dummy alert history data
//   final List<Map<String, dynamic>> _alertHistory = [
//     {
//       'date': '2023-06-15',
//       'time': '14:32',
//       'location': 'Kitchen Sink',
//       'severity': 'High',
//       'status': 'Fixed',
//       'flow_rate': '0.8 L/min',
//     },
//     {
//       'date': '2023-05-28',
//       'time': '09:15',
//       'location': 'Bathroom',
//       'severity': 'Medium',
//       'status': 'Fixed',
//       'flow_rate': '0.5 L/min',
//     },
//     {
//       'date': '2023-04-10',
//       'time': '22:45',
//       'location': 'Garden Hose',
//       'severity': 'Low',
//       'status': 'Fixed',
//       'flow_rate': '0.3 L/min',
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//
//     // Simulate connecting to IoT device
//     _showConnectingDialog();
//
//     // Simulate a scan process after device connection
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           _deviceConnected = true;
//           // For demo purposes, we'll simulate a leak detection
//           _leakDetected = true;
//         });
//
//         // After 2 more seconds, show the results
//         Future.delayed(const Duration(seconds: 2), () {
//           if (mounted) {
//             setState(() {
//               _isScanning = false;
//             });
//           }
//         });
//       }
//     });
//   }
//
//   void _showConnectingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Connecting to Device'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(height: 16),
//               const Text('Triggering IoT device sensor...'),
//               const SizedBox(height: 8),
//               Text(
//                 'Please wait while we connect to your device',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     // Close the dialog after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pop();
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Leak Detection'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: _isScanning ? _buildScanningUI() : _buildResultUI(),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: const Text(
//             'Go to Home',
//             style: TextStyle(fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildScanningUI() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.blue.withOpacity(0.5),
//                     width: 8,
//                   ),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 150 + 20 * _animationController.value,
//                     height: 150 + 20 * _animationController.value,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.blue.withOpacity(0.3 - 0.2 * _animationController.value),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.water_drop,
//                         size: 80,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 40),
//           Text(
//             _deviceConnected ? 'Scanning for leaks...' : 'Connecting to device...',
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             _deviceConnected
//                 ? 'Please wait while we analyze your water flow'
//                 : 'Triggering IoT device sensor',
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 40),
//           const CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildResultUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Current alert section
//           _leakDetected ? _buildLeakDetectedUI() : _buildNoLeakUI(),
//
//           const SizedBox(height: 32),
//
//           // Alert history section
//           Text(
//             'Alert History',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue.shade800,
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Alert history list
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: _alertHistory.length,
//             itemBuilder: (context, index) {
//               final alert = _alertHistory[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '${alert['date']} at ${alert['time']}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           _buildStatusBadge(alert['status']),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on_outlined,
//                             size: 16,
//                             color: Colors.grey.shade600,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             alert['location'],
//                             style: TextStyle(
//                               color: Colors.grey.shade700,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Icon(
//                             Icons.warning_amber_outlined,
//                             size: 16,
//                             color: _getSeverityColor(alert['severity']),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             '${alert['severity']} Severity',
//                             style: TextStyle(
//                               color: _getSeverityColor(alert['severity']),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Flow Rate: ${alert['flow_rate']}',
//                         style: TextStyle(
//                           color: Colors.grey.shade700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeakDetectedUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.warning_rounded,
//                 size: 24,
//                 color: Colors.red.shade700,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Text(
//               'Leak Detected!',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red.shade700,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.red.shade50,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.red.shade200),
//           ),
//           child: Column(
//             children: [
//               _buildInfoRow('Location', 'Kitchen Sink'),
//               const Divider(),
//               _buildInfoRow('Flow Rate', '0.8 L/min'),
//               const Divider(),
//               _buildInfoRow('Estimated Waste', '48 L/day'),
//               const Divider(),
//               _buildInfoRow('Detected At', '${DateTime.now().hour}:${DateTime.now().minute}'),
//               const Divider(),
//               _buildInfoRow('Status', 'Active'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           'We recommend fixing this leak as soon as possible to prevent water waste and potential damage.',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 24),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               // Navigate to plumber booking
//               Navigator.pushNamed(context, '/plumber-booking');
//             },
//             icon: const Icon(Icons.plumbing),
//             label: const Text('Book a Plumber'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNoLeakUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.check_circle,
//                 size: 24,
//                 color: Colors.green.shade700,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Text(
//               'No Leaks Detected',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green.shade700,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.green.shade50,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.green.shade200),
//           ),
//           child: Column(
//             children: [
//               _buildInfoRow('Last Scan', 'Just now'),
//               const Divider(),
//               _buildInfoRow('Flow Rate', 'Normal'),
//               const Divider(),
//               _buildInfoRow('Status', 'All systems normal'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           'Great! Your water system is working properly. We recommend scanning for leaks regularly.',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatusBadge(String status) {
//     Color backgroundColor;
//     Color textColor;
//
//     switch (status) {
//       case 'Active':
//         backgroundColor = Colors.red.shade100;
//         textColor = Colors.red.shade700;
//         break;
//       case 'Fixed':
//         backgroundColor = Colors.green.shade100;
//         textColor = Colors.green.shade700;
//         break;
//       default:
//         backgroundColor = Colors.grey.shade100;
//         textColor = Colors.grey.shade700;
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: textColor,
//         ),
//       ),
//     );
//   }
//
//   Color _getSeverityColor(String severity) {
//     switch (severity) {
//       case 'High':
//         return Colors.red.shade700;
//       case 'Medium':
//         return Colors.orange.shade700;
//       case 'Low':
//         return Colors.yellow.shade700;
//       default:
//         return Colors.grey.shade700;
//     }
//   }
// }