import 'package:flutter/cupertino.dart';

class AddEditCategoryScreen extends StatelessWidget {
  const AddEditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Add Category'), // Should be dynamic (Add/Edit)
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // TODO: Save category logic
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ),
      child: const Center(
        child: Text('Add/Edit Category Form Placeholder'),
      ),
    );
  }
}
