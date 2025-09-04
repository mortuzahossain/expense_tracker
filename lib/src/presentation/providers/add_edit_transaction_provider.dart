import 'package:flutter/foundation.dart';
import '../screens/add_edit_transaction_screen.dart'; // For the enum

class AddEditTransactionProvider with ChangeNotifier {
  TransactionFormType _selectedType = TransactionFormType.expense;
  DateTime _selectedDate = DateTime.now();
  String _amount = '';
  String _note = '';

  TransactionFormType get selectedType => _selectedType;
  DateTime get selectedDate => _selectedDate;
  String get amount => _amount;
  String get note => _note;

  void setSelectedType(TransactionFormType type) {
    if (_selectedType != type) {
      _selectedType = type;
      notifyListeners();
    }
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setAmount(String amount) {
    _amount = amount;
    notifyListeners();
  }

  void setNote(String note) {
    _note = note;
    notifyListeners();
  }
}
