import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:expense_tracker/src/features/auth/pin_service.dart';

class PinLockScreen extends ConsumerStatefulWidget {
  const PinLockScreen({super.key});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  String input = '';
  String? error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tryBiometric();
  }

  Future<void> _tryBiometric() async {
    final svc = ref.read(pinServiceProvider);
    if (await svc.biometricAvailable()) {
      final ok = await svc.biometricAuth();
      if (ok && mounted) context.go('/');
    }
  }

  Future<void> _onKey(String d) async {
    if (d == 'del') {
      setState(() => input = input.isEmpty ? '' : input.substring(0, input.length - 1));
      return;
    }
    if (input.length >= 6) return;
    setState(() => input += d);

    if (input.length == 4 || input.length == 6) {
      final ok = await ref.read(pinServiceProvider).verifyPin(input);
      if (ok && mounted) {
        context.go('/');
      } else {
        setState(() {
          error = 'Incorrect PIN';
          input = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dots = List.generate(6, (i) => Icon(i < input.length ? Icons.radio_button_checked : Icons.radio_button_unchecked));

    return Scaffold(
      appBar: AppBar(title: const Text('Unlock')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 24),
            Column(
              children: [
                const Text('Enter PIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: dots),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(error!, style: const TextStyle(color: Colors.red)),
                  ),
              ],
            ),
            _Numpad(onKey: _onKey),
          ],
        ),
      ),
    );
  }
}

class _Numpad extends StatelessWidget {
  final void Function(String) onKey;
  const _Numpad({required this.onKey});

  Widget _btn(String label) => SizedBox(
    width: 96,
    height: 64,
    child: ElevatedButton(
      onPressed: () => onKey(label),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
      child: Text(label, style: const TextStyle(fontSize: 20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['1', '2', '3'].map(_btn).toList()),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['4', '5', '6'].map(_btn).toList()),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: ['7', '8', '9'].map(_btn).toList()),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 96, height: 64),
              _btn('0'),
              SizedBox(
                width: 96,
                height: 64,
                child: ElevatedButton(
                  onPressed: () => onKey('del'),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Icon(Icons.backspace_outlined),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
