import 'package:flutter/material.dart';
import 'home.dart'; 
import 'signup.dart'; 

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Script',
      theme: ThemeData(
        
        scaffoldBackgroundColor: const Color(0xFF2E619E),
        
        primaryColor: const Color(0xFF4C8CD2),
        
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF4C8CD2), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none, 
          ),
          hintStyle: TextStyle(color: Colors.white70),
          prefixIconColor: Colors.white, 
          suffixIconColor: Colors.white, 
          contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
          labelStyle: TextStyle(color: Colors.white70), 
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF75A6D3),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),

            
            Image.asset(
              'assets/logo.png',
              height: 100, 
              color: Colors.white, 
              errorBuilder: (context, error, stackTrace) => const Text(
                'LOGO',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),

            
            const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),

            
            const _CustomInputField(
              labelText: 'Email',
              icon: Icons.email_outlined, 
            ),
            const SizedBox(height: 15),

            
            TextFormField(
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password', 
                prefixIcon: const Icon(Icons.lock_outline), 
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreenV2()),
                );
              },
              child: const Text('LOG IN'), 
            ),

            
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(color: Colors.white70),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or sign in with',
                    style: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
                  ),
                ),
                Expanded(
                  child: Divider(color: Color.fromARGB(179, 255, 255, 255)),
                ),
              ],
            ),
            const SizedBox(height: 30),

            
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _SocialIcon(icon: Icons.g_mobiledata_rounded, color: Colors.red), 
                SizedBox(width: 20),
                _SocialIcon(icon: Icons.facebook, color: Colors.blue), 
                SizedBox(width: 20),
                _SocialIcon(icon: Icons.apple, color: Colors.black), 
              ],
            ),
            const SizedBox(height: 50),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()), 
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData? icon;

  const _CustomInputField({
    
    required this.labelText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null
            ? Icon(icon)
            : null,
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SocialIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
      ),
    );
  }
}