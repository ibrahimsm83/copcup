import 'dart:developer';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';

class SellerBankAccountRepository {
  final ApiHelper _apiHelper = ApiHelper();
  Future<bool> createSellerBankAccount(
    String bankname,
    String accountnumber,
    String accounttype,
    String accountholdername,
    String email,
  ) async {
    try {
      final data = {
        'bank_name': bankname,
        'account_number': accountnumber,
        'account_type': accounttype,
        'account_holder_name': accountholdername,
        'email': email,
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.sellerCreateBankAccount,
        data: data,
      );

      log('seller account created ');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Regsiter succesfully');

        return true;
      } else {
        log('Request failed with status ');
        return false;
      }
    } catch (e) {
      log('Error during creation: $e');
      return false;
    }
  }
}
