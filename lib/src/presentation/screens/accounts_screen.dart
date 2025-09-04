import 'package:flutter/cupertino.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Accounts'),
      ),
      child: Center(
        child: Text('Accounts Screen'),
      ),
    );
  }
}
