import 'package:flutter/cupertino.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Change PIN'),
      ),
      child: Center(
        child: Text('Change PIN Form Placeholder'),
      ),
    );
  }
}
