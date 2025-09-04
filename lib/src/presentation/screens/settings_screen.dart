import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'change_pin_screen.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Settings'),
          ),
          child: SafeArea(
            child: Column(
              children: [
                CupertinoListSection.insetGrouped(
                  header: const Text('Security'),
                  children: <CupertinoListTile>[
                    CupertinoListTile(
                      title: const Text('Enable Biometric Unlock'),
                      trailing: CupertinoSwitch(
                        value: settingsProvider.biometricsEnabled,
                        onChanged: (bool value) {
                          settingsProvider.setBiometrics(value);
                        },
                      ),
                    ),
                    CupertinoListTile(
                      title: const Text('Change PIN'),
                      trailing: const Icon(CupertinoIcons.right_chevron),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const ChangePinScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text('Data'),
                  children: <CupertinoListTile>[
                    CupertinoListTile(
                      title: const Text('Export to CSV'),
                      trailing: const Icon(CupertinoIcons.right_chevron),
                      onTap: () {
                        // TODO: Implement export to CSV
                      },
                    ),
                    CupertinoListTile(
                      title: const Text('Export to JSON'),
                      trailing: const Icon(CupertinoIcons.right_chevron),
                      onTap: () {
                        // TODO: Implement export to JSON
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
