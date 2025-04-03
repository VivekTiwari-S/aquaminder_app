import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen for tab changes to clear form fields when switching tabs
    _tabController.addListener(() {
      // Clear form fields when switching tabs
      if (_tabController.indexIsChanging) {
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _nameController.clear();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [const Color(0xFF1A2151), const Color(0xFF0D1333)]
                : [const Color(0xFFE6F0FF), const Color(0xFFCCE0FF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App Logo
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.blue.shade800 : Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.water_drop,
                          color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        'Welcome to AquaMinder',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        'Because, every drop counts!',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tab content
                      SizedBox(
                        height: _tabController.index == 0 ? 280 : 380,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Login Tab
                            _buildLoginForm(),

                            // Register Tab
                            _buildRegisterForm(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Footer
                      Text(
                        'By continuing, you agree to our Terms of Service and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'name@example.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Login button
          ElevatedButton(
            onPressed: () {
              if (_loginFormKey.currentState!.validate()) {
                // In a real app, you would authenticate with a backend here
                // For now, we'll just navigate to the dashboard
                _navigateToDashboard();
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 24),

          // Register link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _tabController.animateTo(1); // Switch to register tab
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          // Name field
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'John Doe',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'name@example.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
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
          const SizedBox(height: 16),

          // Confirm password field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Register button
          ElevatedButton(
            onPressed: () {
              if (_registerFormKey.currentState!.validate()) {
                // In a real app, you would register with a backend here
                // For now, we'll just navigate to the dashboard
                _navigateToDashboard();
              }
            },
            child: const Text('Create Account'),
          ),
          const SizedBox(height: 24),

          // Login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _tabController.animateTo(0); // Switch to login tab
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'dashboard_screen.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final _loginFormKey = GlobalKey<FormState>();
//   final _registerFormKey = GlobalKey<FormState>();
//
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _nameController = TextEditingController();
//
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//
//     // Listen for tab changes to clear form fields when switching tabs
//     _tabController.addListener(() {
//       // Clear form fields when switching tabs
//       if (_tabController.indexIsChanging) {
//         _emailController.clear();
//         _passwordController.clear();
//         _confirmPasswordController.clear();
//         _nameController.clear();
//         setState(() {
//           _errorMessage = null;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   void _navigateToDashboard() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const DashboardScreen()),
//     );
//   }
//
//   // Firebase email/password login
//   Future<void> _signInWithEmailAndPassword() async {
//     if (_loginFormKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });
//
//       try {
//         await _auth.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//         _navigateToDashboard();
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           _errorMessage = _getFirebaseErrorMessage(e.code);
//         });
//       } catch (e) {
//         setState(() {
//           _errorMessage = 'An error occurred. Please try again.';
//         });
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   // Firebase email/password registration
//   Future<void> _registerWithEmailAndPassword() async {
//     if (_registerFormKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });
//
//       try {
//         final userCredential = await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//
//         // Update user profile with name
//         await userCredential.user?.updateDisplayName(_nameController.text.trim());
//
//         _navigateToDashboard();
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           _errorMessage = _getFirebaseErrorMessage(e.code);
//         });
//       } catch (e) {
//         setState(() {
//           _errorMessage = 'An error occurred. Please try again.';
//         });
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   // Google Sign In
//   Future<void> _signInWithGoogle() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         // User canceled the sign-in flow
//         setState(() {
//           _isLoading = false;
//         });
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       await _auth.signInWithCredential(credential);
//       _navigateToDashboard();
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Google sign in failed. Please try again.';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   String _getFirebaseErrorMessage(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return 'No user found with this email.';
//       case 'wrong-password':
//         return 'Wrong password provided.';
//       case 'email-already-in-use':
//         return 'The email address is already in use.';
//       case 'weak-password':
//         return 'The password is too weak.';
//       case 'invalid-email':
//         return 'The email address is invalid.';
//       case 'operation-not-allowed':
//         return 'Email/password accounts are not enabled.';
//       case 'user-disabled':
//         return 'This user has been disabled.';
//       case 'too-many-requests':
//         return 'Too many requests. Try again later.';
//       case 'network-request-failed':
//         return 'Network error. Check your connection.';
//       default:
//         return 'An error occurred. Please try again.';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: isDarkMode
//                 ? [const Color(0xFF1A2151), const Color(0xFF0D1333)]
//                 : [const Color(0xFFE6F0FF), const Color(0xFFCCE0FF)],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // App Logo
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           color: isDarkMode ? Colors.blue.shade800 : Colors.blue.shade100,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.water_drop,
//                           color: isDarkMode ? Colors.blue.shade300 : Colors.blue.shade700,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Title
//                       Text(
//                         'Welcome to AquaMinder',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: isDarkMode ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//
//                       // Subtitle
//                       Text(
//                         'Because, every drop counts!',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Tabs
//                       Container(
//                         decoration: BoxDecoration(
//                           color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: TabBar(
//                           controller: _tabController,
//                           indicator: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade500,
//                           ),
//                           labelColor: Colors.white,
//                           unselectedLabelColor: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
//                           tabs: const [
//                             Tab(text: 'Login'),
//                             Tab(text: 'Register'),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Error message
//                       if (_errorMessage != null) ...[
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade100,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.error_outline, color: Colors.red.shade700),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   _errorMessage!,
//                                   style: TextStyle(color: Colors.red.shade700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//
//                       // Tab content
//                       SizedBox(
//                         height: _tabController.index == 0 ? 320 : 420,
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: [
//                             // Login Tab
//                             _buildLoginForm(),
//
//                             // Register Tab
//                             _buildRegisterForm(),
//                           ],
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Footer
//                       Text(
//                         'By continuing, you agree to our Terms of Service and Privacy Policy',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginForm() {
//     return Form(
//       key: _loginFormKey,
//       child: Column(
//         children: [
//           // Email field
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               labelText: 'Email',
//               hintText: 'name@example.com',
//               prefixIcon: Icon(Icons.email_outlined),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//
//           // Password field
//           TextFormField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Password',
//               prefixIcon: Icon(Icons.lock_outline),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 24),
//
//           // Login button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _isLoading ? null : _signInWithEmailAndPassword,
//               child: _isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Text('Login'),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Divider
//           Row(
//             children: [
//               const Expanded(child: Divider()),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Or continue with',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//               const Expanded(child: Divider()),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           // Google sign in button
//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: _isLoading ? null : _signInWithGoogle,
//               icon: Image.network(
//                 'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
//                 height: 18,
//               ),
//               label: const Text('Sign in with Google'),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Register link
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Don't have an account? ",
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _tabController.animateTo(1); // Switch to register tab
//                 },
//                 child: Text(
//                   "Register",
//                   style: TextStyle(
//                     color: Colors.blue.shade700,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRegisterForm() {
//     return Form(
//       key: _registerFormKey,
//       child: Column(
//         children: [
//           // Name field
//           TextFormField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Full Name',
//               hintText: 'John Doe',
//               prefixIcon: Icon(Icons.person_outline),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your name';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//
//           // Email field
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               labelText: 'Email',
//               hintText: 'name@example.com',
//               prefixIcon: Icon(Icons.email_outlined),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//
//           // Password field
//           TextFormField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Password',
//               prefixIcon: Icon(Icons.lock_outline),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               if (value.length < 6) {
//                 return 'Password must be at least 6 characters';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
//
//           // Confirm password field
//           TextFormField(
//             controller: _confirmPasswordController,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Confirm Password',
//               prefixIcon: Icon(Icons.lock_outline),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please confirm your password';
//               }
//               if (value != _passwordController.text) {
//                 return 'Passwords do not match';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 24),
//
//           // Register button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _isLoading ? null : _registerWithEmailAndPassword,
//               child: _isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               )
//                   : const Text('Create Account'),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Divider
//           Row(
//             children: [
//               const Expanded(child: Divider()),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Or continue with',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//               const Expanded(child: Divider()),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           // Google sign in button
//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: _isLoading ? null : _signInWithGoogle,
//               icon: Image.network(
//                 'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
//                 height: 18,
//               ),
//               label: const Text('Sign up with Google'),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Login link
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Already have an account? ",
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _tabController.animateTo(0); // Switch to login tab
//                 },
//                 child: Text(
//                   "Login",
//                   style: TextStyle(
//                     color: Colors.blue.shade700,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }