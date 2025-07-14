import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/model/renevue_model.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/model/weekly_renevue_order.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/professional_renevue_repository/professional_renever_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RefundProvider with ChangeNotifier {
  int? selectedItemIndex;

  void toggleItemSelection(int index) {
    if (selectedItemIndex == index) {
      selectedItemIndex = null;
    } else {
      selectedItemIndex = index;
    }
    notifyListeners();
  }

  RenevueModel? _renevueModel;
  RenevueModel? get renevueModel => _renevueModel;
  Future<void> getDailyRenevue({
    required int id,
    required BuildContext context,
  }) async {
    try {
      notifyListeners();

      final result =
          await ProfessionalReneverRepository.getProfessionalRenevuePerdaily(
              id: id);

      result.fold(
        (onLeft) {
          log('Error fetching revenue data: $onLeft');
        },
        (onRight) {
          _renevueModel = onRight;
          log('Successfully fetched revenue: ${_renevueModel?.toJson()}');
        },
      );
    } catch (e) {
      log('Exception occurred: $e');
    } finally {
      notifyListeners();
    }
  }

  RenevueModel? _renevueWeeklyModel;
  RenevueModel? get renevueWeeklyModel => _renevueWeeklyModel;
  Future<void> getWeeklyRenevue({
    required int id,
    required BuildContext context,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();

      final result =
          await ProfessionalReneverRepository.getProfessionalRenevuePerWeek(
              id: id);

      result.fold(
        (onLeft) {
          log('Error fetching revenue data: $onLeft');
        },
        (onRight) {
          _renevueWeeklyModel = onRight;
          log('Successfully fetched revenue: ${_renevueModel?.toJson()}');
        },
      );
    } catch (e) {
      log('Exception occurred: $e');
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  AllIncomeModel? _allIncomeModel;
  AllIncomeModel? get allIncomeModel => _allIncomeModel;

  void getAllInComeData() async {
    try {
      final result =
          await ProfessionalReneverRepository.getAllProfessionalIncome();
      _allIncomeModel = result;
    } catch (e) {
      log('Exception occurred while fetching all income data: $e');
    } finally {
      notifyListeners();
    }
  }

  bool _selectedEventBool = false;
  bool get selectedEventBool => _selectedEventBool;
  void updateSelectedBool(val) {
    _selectedEventBool = val;
    notifyListeners();
  }

  WeeklyRevenueModel? _weeklygraphRenevue;
  WeeklyRevenueModel? get weeklygraphRenevue => _weeklygraphRenevue;
  Future<void> getWeeklyGraphRenevue({
    required int id,
    required BuildContext context,
  }) async {
    try {
      final result =
          await ProfessionalReneverRepository.weeklyGraphRenevue(id: id);

      notifyListeners();
      result.fold(
        (onLeft) {
          log('Error fetching revenue data: $onLeft');
        },
        (onRight) {
          _weeklygraphRenevue = onRight;
          log('Successfully fetched revenue: ${_renevueModel?.toJson()}');
        },
      );
    } catch (e) {
      log('Exception occurred: $e');
    } finally {
      notifyListeners();
    }
  }
}
