import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/src/features/auth/pin_service.dart';
import 'package:expense_tracker/src/features/settings/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Light / Dark / System'),
            trailing: DropdownButton<String>(
              value: 'system',
              items: const [
                DropdownMenuItem(value: 'system', child: Text('System')),
                DropdownMenuItem(value: 'light', child: Text('Light')),
                DropdownMenuItem(value: 'dark', child: Text('Dark')),
              ],
              onChanged: (v) => ref.read(settingsControllerProvider.notifier).setThemeMode(ref, v ?? 'system'),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Set/Change PIN'),
            onTap: () async {
              final controller = TextEditingController();
              final pin = await showDialog<String>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Set PIN (4 or 6 digits)'),
                  content: TextField(controller: controller, keyboardType: TextInputType.number, maxLength: 6),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    FilledButton(onPressed: () => Navigator.pop(ctx, controller.text.trim()), child: const Text('Save')),
                  ],
                ),
              );
              if (pin != null && pin.isNotEmpty) {
                await ref.read(pinServiceProvider).setPin(pin);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN updated')));
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Export Data (JSON)'),
            onTap: () {
              // TODO: implement export
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Export coming soon')));
            },
          ),
          ListTile(
            title: const Text('Import Data (JSON)'),
            onTap: () {
              // TODO: implement import
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Import coming soon')));
            },
          ),
        ],
      ),
    );
  }
}
