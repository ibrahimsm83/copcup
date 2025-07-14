import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/model/delivery_charges_model.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/repository/delivery_charges_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DeliveryChargesController with ChangeNotifier {
  final DeliveryChargesRepository _deliveryChargesRepository =
      DeliveryChargesRepository();

  //! Get DeliveryCharges
  List<DeliveryChargesModel> _deliveryChargesList = [];
  List<DeliveryChargesModel> get deliveryChargesList => _deliveryChargesList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getDeliveryCharges({
    required BuildContext context,
  }) async {
    try {
      context.loaderOverlay.show();
      _deliveryChargesList =
          await _deliveryChargesRepository.getDeliveryCharges();

      notifyListeners();
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);

      print('Error in Fetching Delivery Charges: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  //! Create Delivery Charges
  Future<void> createDeliveryCharges({
    required BuildContext context,
    required String sellerid,
    required String basedeliveryfee,
    required String deliveryperkm,
    required String minimumorderfee,
    required String freedeliverythreshold,
    required Function(String message) onSuccess,
    required Function(String error) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    context.loaderOverlay.show();

    final bool result = await _deliveryChargesRepository.createDeliveryCharges(
      sellerid,
      basedeliveryfee,
      deliveryperkm,
      minimumorderfee,
      freedeliverythreshold,
    );

    _isLoading = false;
    notifyListeners();

    context.loaderOverlay.hide();

    if (result) {
      onSuccess("delivery charges created succesfully");
    } else {
      onError("Something went wrong");
    }
  }

  //! Delete Food Item
  Future<void> deleteDeliveryCharges({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();

    final bool result =
        await _deliveryChargesRepository.deleteDeliveryCharges(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Delivery charges deleted successfully");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }
}
