import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/providers/my_profile_provider.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthService>(context, listen: false).appUser;
    if (user != null) {
      _nameController.text = user.name;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final user = authService.appUser;

    return ChangeNotifierProvider(
      create: (_) => MyProfileProvider(authService, firestoreService),
      child: Consumer<MyProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('My Profile')),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _imageFile != null
                                ? FileImage(File(_imageFile!.path))
                                : (user?.profileImageUrl != null
                                    ? NetworkImage(user!.profileImageUrl!)
                                    : null) as ImageProvider?,
                            child: _imageFile == null && user?.profileImageUrl == null
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        const SizedBox(height: 20),
                        Text('Email: ${user?.email ?? ''}'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await provider.updateProfile(
                                name: _nameController.text,
                                imageFile: _imageFile,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profile updated successfully!')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to update profile: $e')),
                              );
                            }
                          },
                          child: const Text('Save Changes'),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () => _showDeleteAccountDialog(context, provider),
                          child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, MyProfileProvider provider) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('This is a permanent action. Please enter your password to confirm.'),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(); // Close the dialog
                  try {
                    await provider.deleteAccount(passwordController.text);
                    // The AuthWrapper will handle navigating away from the authenticated part of the app.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account deleted successfully.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete account: $e')),
                    );
                  }
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
