import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/model/coupon_model.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/repository/coupons_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CouponController with ChangeNotifier {
  final CouponsRepository _couponsRepository = CouponsRepository();

  //! Gel All Coupons Of Current Seller
  List<CouponModel> _couponsList = [];
  List<CouponModel> get couponsList => _couponsList;
  bool _isCouponLoading = false;
  bool get isCouponLoading => _isCouponLoading;

  Future<void> getAllCouponsOfSeller({
    required BuildContext context,
  }) async {
    _isCouponLoading = true;
    notifyListeners();
    final result = await _couponsRepository.getAllCouponsOfSeller(
        sellerID: StaticData.userId);
    result.fold(
      (failure) => showSnackbar(message: 'No Coupons Found', isError: false),
      (allCouponsList) => _couponsList = allCouponsList,
    );

    _isCouponLoading = false;
    notifyListeners();
  }

  //! Generate A Coupon
  Future<void> generateCoupon({
    required BuildContext context,
    required int discountAmount,
    required int discountPercentage,
    required String validFrom,
    required String validUntil,
    required int usageLimit,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _couponsRepository.generateCoupon(
        sellerID: StaticData.userId,
        discountAmount: discountAmount,
        discountPercentage: discountPercentage,
        validFrom: validFrom,
        validUntil: validUntil,
        usageLimit: usageLimit);
    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        getAllCouponsOfSeller(context: context);
        showSnackbar(message: success);
        context.pop();
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Validate Coupon
  Future<void> validateCoupon({
    required BuildContext context,
    required String couponCode,
    required int sellerID,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _couponsRepository.validateCoupon(
        sellerID: sellerID, couponCode: couponCode);
    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) {
        showSnackbar(message: success);
      },
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }
}
