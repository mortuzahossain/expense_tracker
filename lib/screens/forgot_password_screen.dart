import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await authService.sendPasswordResetEmail(_emailController.text);
                            setState(() {
                              _message = 'Password reset email sent. Please check your inbox.';
                              _isLoading = false;
                            });
                          } catch (e) {
                            setState(() {
                              _message = 'Failed to send email. Please try again.';
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Text('Send Reset Email'),
                    ),
              if (_message.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(_message, style: TextStyle(color: _message.startsWith('Failed') ? Colors.red : Colors.green)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
