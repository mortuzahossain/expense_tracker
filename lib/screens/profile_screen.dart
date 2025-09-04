import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_youtube/services/auth_service.dart';
import 'package:flutter_youtube/screens/upload_screen.dart';
import 'package:flutter_youtube/screens/my_profile_screen.dart';
import 'package:flutter_youtube/screens/manage_video_screen.dart';
import 'package:flutter_youtube/screens/privacy_policy_screen.dart';
import 'package:flutter_youtube/screens/terms_condition_screen.dart';
import 'package:flutter_youtube/screens/faq_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('My Profile'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfileScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_call),
          title: const Text('Add Video'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UploadScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.video_library),
          title: const Text('Manage Video'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageVideoScreen()));
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.gavel),
          title: const Text('Terms and Condition'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermsConditionScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('FAQ'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FaqScreen()));
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            authService.signOut();
          },
        ),
      ],
    );
  }
}
