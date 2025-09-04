import 'package:flutter/cupertino.dart';
import 'main_app_screen.dart';

class PinLockScreen extends StatefulWidget {
  const PinLockScreen({super.key});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  String _enteredPin = '';
  final int _pinLength = 4;

  void _onNumberPressed(int number) {
    if (_enteredPin.length < _pinLength) {
      setState(() {
        _enteredPin += number.toString();
      });
      if (_enteredPin.length == _pinLength) {
        _verifyPin();
      }
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  void _onBiometricPressed() {
    // TODO: Implement biometric authentication using local_auth
    print("Biometric authentication triggered");
  }

  void _verifyPin() {
    // TODO: Implement PIN verification using flutter_secure_storage
    print("Verifying PIN: $_enteredPin");

    // For now, assume PIN is correct and navigate to the main app screen
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => const MainAppScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Enter PIN'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            _buildPinDisplay(),
            const Spacer(),
            _buildNumericKeypad(),
            _buildBiometricButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pinLength, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < _enteredPin.length
                ? CupertinoTheme.of(context).primaryColor
                : CupertinoColors.inactiveGray.withOpacity(0.5),
          ),
        );
      }),
    );
  }

  Widget _buildNumericKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [1, 2, 3].map((number) => _buildNumberButton(number)).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [4, 5, 6].map((number) => _buildNumberButton(number)).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [7, 8, 9].map((number) => _buildNumberButton(number)).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 80, height: 80), // Placeholder for alignment
            _buildNumberButton(0),
            _buildBackspaceButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(int number) {
    return SizedBox(
      width: 80,
      height: 80,
      child: CupertinoButton(
        onPressed: () => _onNumberPressed(number),
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: CupertinoColors.black),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return SizedBox(
      width: 80,
      height: 80,
      child: CupertinoButton(
        onPressed: _onBackspacePressed,
        child: const Icon(CupertinoIcons.delete_left, size: 32),
      ),
    );
  }

  Widget _buildBiometricButton() {
    return CupertinoButton(
      onPressed: _onBiometricPressed,
      child: const Column(
        children: [
          Icon(CupertinoIcons.lock_shield, size: 40),
          SizedBox(height: 8),
          Text("Unlock with Biometrics"),
        ],
      ),
    );
  }
}
