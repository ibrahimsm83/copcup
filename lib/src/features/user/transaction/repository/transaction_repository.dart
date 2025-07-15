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
        print("ibrahim--1---$data");
        // print("ibrahim---2--$data");

        // return data.map((e) => Transaction.fromJson(e)).toList();
        // return data.map((e) {
        //   print('Parsing transaction: $e');
        //   return Transaction.fromJson(e);
        // }).toList();
        final List<Transaction> tranList = [];
        for (int i = 0; i < data.length; i++) {
          tranList.add(Transaction.fromJson(data[i]));
        }
        print("tranList ${tranList.length} ");
        return tranList;
        // return data.map((e) => Transaction.fromJson(e)).toList();
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
