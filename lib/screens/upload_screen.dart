import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/services/firestore_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _videoUrlController = TextEditingController();
  final _thumbnailUrlController = TextEditingController();
  String _selectedType = 'feed'; // Default value
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Video')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a title' : null,
                    ),
                    TextFormField(
                      controller: _videoUrlController,
                      decoration: const InputDecoration(labelText: 'Video URL'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a video URL' : null,
                    ),
                    TextFormField(
                      controller: _thumbnailUrlController,
                      decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a thumbnail URL' : null,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: const InputDecoration(labelText: 'Type'),
                      items: ['feed', 'reel']
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await firestoreService.uploadVideo(
                              userId: authService.firebaseUser!.uid,
                              title: _titleController.text,
                              videoUrl: _videoUrlController.text,
                              thumbnailUrl: _thumbnailUrlController.text,
                              type: _selectedType,
                            );
                            Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to upload video: $e')),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Text('Upload'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
