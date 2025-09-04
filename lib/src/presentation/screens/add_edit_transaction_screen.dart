import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/add_edit_transaction_provider.dart';

// This enum is now also used by the provider, so it's good that it's here.
enum TransactionFormType { income, expense, transfer }

class AddEditTransactionScreen extends StatelessWidget {
  const AddEditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Consumer to rebuild the widget when the provider notifies listeners.
    return Consumer<AddEditTransactionProvider>(
      builder: (context, provider, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Add Transaction'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // TODO: Implement save logic using provider data
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTypeSelector(context, provider),
                  const SizedBox(height: 24),
                  _buildAmountField(provider),
                  const SizedBox(height: 16),
                  _buildFormRow(
                    'Date',
                    '${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}',
                    CupertinoIcons.calendar,
                    () => _showDatePicker(context, provider),
                  ),
                  _buildFormRow('Account', 'Cash', CupertinoIcons.creditcard, () {
                    // TODO: Show account selection
                  }),
                  if (provider.selectedType != TransactionFormType.transfer)
                    _buildFormRow('Category', 'Food', CupertinoIcons.tag, () {
                      // TODO: Show category selection
                    }),
                  if (provider.selectedType == TransactionFormType.transfer)
                    _buildFormRow(
                        'To Account', 'Savings', CupertinoIcons.arrow_right_arrow_left_circle,
                        () {
                      // TODO: Show account selection
                    }),
                  const SizedBox(height: 16),
                  _buildNoteField(provider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDatePicker(BuildContext context, AddEditTransactionProvider provider) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: provider.selectedDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  provider.setSelectedDate(val);
                },
              ),
            ),
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector(BuildContext context, AddEditTransactionProvider provider) {
    return CupertinoSlidingSegmentedControl<TransactionFormType>(
      groupValue: provider.selectedType,
      onValueChanged: (TransactionFormType? newValue) {
        if (newValue != null) {
          provider.setSelectedType(newValue);
        }
      },
      children: const <TransactionFormType, Widget>{
        TransactionFormType.income: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Income'),
        ),
        TransactionFormType.expense: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Expense'),
        ),
        TransactionFormType.transfer: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Transfer'),
        ),
      },
    );
  }

  Widget _buildAmountField(AddEditTransactionProvider provider) {
    return CupertinoTextField(
      placeholder: '0.00',
      prefix: const Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Text('\$', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CupertinoColors.secondaryLabel)),
      ),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) => provider.setAmount(value),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
    );
  }

  Widget _buildFormRow(String title, String value, IconData icon, VoidCallback onPressed) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey4)),
        ),
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.secondaryLabel),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(value, style: const TextStyle(color: CupertinoColors.secondaryLabel)),
            const SizedBox(width: 8),
            const Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey2),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteField(AddEditTransactionProvider provider) {
    return CupertinoTextField(
      placeholder: 'Note (optional)',
      maxLines: 3,
      onChanged: (value) => provider.setNote(value),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
    );
  }
}
