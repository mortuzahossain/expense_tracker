import 'package:flutter/cupertino.dart';

class AddEditAccountScreen extends StatelessWidget {
  const AddEditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Add Account'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // TODO: Save account logic
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ),
      child: const Center(
        child: Text('Add Account Form Placeholder'),
      ),
    );
  }
}
