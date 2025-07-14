import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/model/renevue_model.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/model/weekly_renevue_order.dart';
import 'package:fpdart/fpdart.dart';

class ProfessionalReneverRepository {
  static ApiHelper _apiHelper = ApiHelper();

  static Future<Either<String, RenevueModel>> getProfessionalRenevuePerdaily(
      {required int id}) async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint:
            '${ApiEndpoints.professionalRenevue}?period=daily&event_id=$id',
      );

      log('-before----------${response.body}');
      log('-----------${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        RenevueModel renevueModel = RenevueModel.fromJson(responseData);

        log('Parsed RenevueModel: ${renevueModel.toJson()}');

        return Right(renevueModel);
      } else {
        log('Error: ${response.statusCode}, Response: ${response.body}');
        return left('Failed to get data');
      }
    } catch (e) {
      log('Exception occurred: $e');
      return left('failed to get data ');
    }
  }

  static Future<Either<String, RenevueModel>> getProfessionalRenevuePerWeek(
      {required int id}) async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint:
            '${ApiEndpoints.professionalRenevue}?period=weekly&event_id=$id',
      );

      log('-before----------${response.body}');
      log('-----------${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        RenevueModel renevueModel = RenevueModel.fromJson(responseData);

        log('Parsed RenevueModel: ${renevueModel.toJson()}');

        return Right(renevueModel);
      } else {
        log('Error: ${response.statusCode}, Response: ${response.body}');
        return left('Failed to get data');
      }
    } catch (e) {
      log('Exception occurred: $e');
      return left('failed to get data ');
    }
  }

  static Future<Either<String, WeeklyRevenueModel>> weeklyGraphRenevue({
    required int id,
  }) async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: '${ApiEndpoints.professionalweeklyGraph}?event_id=$id',
      );

      log('========================== ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        WeeklyRevenueModel weeklyRevenueModel =
            WeeklyRevenueModel.fromJson(responseData);

        log('Parsed WeeklyRevenueModel: ${weeklyRevenueModel.toJson()}');

        return Right(weeklyRevenueModel);
      } else {
        log('Error: ${response.statusCode}, Response: ${response.body}');
        return left('Failed to get data');
      }
    } catch (e) {
      log('Exception occurred: $e');
      return left('Failed to get data');
    }
  }

  static Future<AllIncomeModel> getAllProfessionalIncome() async {
    final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allProfessionalIncome,
        authToken: StaticData.accessToken);
    log('------------all icone ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return AllIncomeModel.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load income data');
    }
  }
}
