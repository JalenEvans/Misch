import 'package:flutter/material.dart';
import 'package:misch/components/my_button.dart';
import 'package:misch/components/my_text_field.dart';
import 'package:misch/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user
  Future<void> signIn() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text,
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                Icon(
                  Icons.message, // TODO: replace with Misch logo
                  size: 80,
                  color: Colors.grey[800],
                ),

                const SizedBox(height: 50),

                // welcome back message
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(onTap: signIn, text: 'Sign In'),

                const SizedBox(height: 25),

                // register now prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}
