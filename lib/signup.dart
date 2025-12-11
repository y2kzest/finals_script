import 'package:flutter/material.dart';
import 'main.dart';

const Color kScaffoldBgColor = Color(0xFF2E619E);
const Color kInputFillColor = Color(0xFF4C8CD2);
const Color kButtonColor = Color(0xFF75A6D3);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),

            Image.asset(
              'assets/logo.png',
              height: 80,
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
            const SizedBox(height: 40),

            const Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),

            const _CustomInputField(
              labelText: 'Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 15),

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
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            TextFormField(
              obscureText: !_isConfirmPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock_reset),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginApp()),
                );
              },
              child: const Text('SIGN UP'),
            ),
            const SizedBox(height: 40),

            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(color: Colors.white70),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or sign up with',
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
                  "Already have an account?",
                  style: TextStyle(color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Log In',
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
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: '',
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