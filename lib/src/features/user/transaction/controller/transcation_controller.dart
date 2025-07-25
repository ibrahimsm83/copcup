import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/model/transaction_model.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/repository/transaction_repository.dart';

class TranscationController extends ChangeNotifier {
  final TransactionRepository transactionRepository = TransactionRepository();

  bool _isUserTransactionLoading = false;
  bool get isUserTransactionLoading => _isUserTransactionLoading;

  List<Transaction> _userTransactionList = [];
  List<Transaction> get userTransactionList => _userTransactionList;

  Future<void> getUserTransactions() async {
    _isUserTransactionLoading = true;
    notifyListeners();
    print("----ds-fs-df-asd-fa-sd-f---1");
    _userTransactionList = await transactionRepository.getUserTransactions();
    print("----ds-fs-df-asd-fa-sd-f--2${_userTransactionList}");
    _isUserTransactionLoading = false;
    notifyListeners();
    print(_userTransactionList);
  }
}
