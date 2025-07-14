import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/repository/seller_bank_repository.dart';

import 'package:loader_overlay/loader_overlay.dart';

class SellerBankAccountController with ChangeNotifier {
  final SellerBankAccountRepository _sellerBankAccountRepository =
      SellerBankAccountRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //! Create Seller Bank Account
  Future<void> createSellerBankAccount({
    required BuildContext context,
    required String bankName,
    required String accountNumber,
    required String accountType,
    required String accountHolderName,
    required String email,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    context.loaderOverlay.show();

    final bool result =
        await _sellerBankAccountRepository.createSellerBankAccount(
      bankName,
      accountNumber,
      accountType,
      accountHolderName,
      email,
    );

    _isLoading = false;
    notifyListeners();

    context.loaderOverlay.hide();

    if (result) {
      onSuccess("Seller bank account created successfully");
    } else {
      onError("Something went wrong");
    }
  }
}
