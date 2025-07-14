import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';

import '../model/transaction_model.dart';

class TransactionRepository {
  final ApiHelper apiHelper = ApiHelper();

  Future<List<Transaction>> getUserTransactions() async {
    try {
      final response = await apiHelper.getRequest(
        endpoint: ApiEndpoints.userTransaction,
        authToken: StaticData.accessToken,
      );
      log('-----------response -----------${response.statusCode}');
      log('-----------response -----------${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['transactions'];

        return data.map((e) => Transaction.fromJson(e)).toList();
      } else {
        log('Failed to fetch transactions: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching transactions: $e');
      return [];
    }
  }
}
