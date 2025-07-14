import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/user_management/model/all_users_model.dart';
import 'package:flutter_application_copcup/src/features/user_management/model/incoming_request_model.dart';
import 'package:flutter_application_copcup/src/features/user_management/repository/user_manage_repository.dart';
import 'package:flutter_application_copcup/src/models/support_message_model.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserManageController extends ChangeNotifier {
  final UserManageRepository userManageRepository = UserManageRepository();

  bool _isAllUserLoading = false;
  bool get isAllUsersLoading => _isAllUserLoading;

  final useremail = TextEditingController();
  final username = TextEditingController();
  final userpassword = TextEditingController();
  final contactNumber = TextEditingController();
  List<AllUsersModel> _allUsersList = [];
  List<AllUsersModel> get allUsersList => _allUsersList;

  Future<void> getAllUsers() async {
    _isAllUserLoading = true;
    notifyListeners();
    try {
      List<AllUsersModel> fetchedUsers =
          await userManageRepository.getAllUsers();
      _allUsersList = fetchedUsers;
    } catch (error) {
      print("Error fetching all users: $error");
      _allUsersList = [];
    } finally {
      _isAllUserLoading = false;
      notifyListeners();
    }

    print(_allUsersList);
  }

  bool _isAllIncomingRequestLoading = false;
  bool get isAllIncomingRequestLoading => _isAllIncomingRequestLoading;

  List<IncomingRequestModel> _allIncomingRequest = [];
  List<IncomingRequestModel> get allIncomingRequest => _allIncomingRequest;

  Future<void> getAllIncomingRequest() async {
    _isAllIncomingRequestLoading = true;
    notifyListeners();
    try {
      List<IncomingRequestModel> fetchedUsers =
          await userManageRepository.getAllIncomingRequests();
      _allIncomingRequest = fetchedUsers;
    } catch (error) {
      print("Error fetching all users: $error");
      _allIncomingRequest = [];
    } finally {
      _isAllIncomingRequestLoading = false;
      notifyListeners();
    }

    print(_allIncomingRequest);
  }

  //! Approve request
  Future<void> approveProfessionalrequests({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();

    final bool result =
        await userManageRepository.approveProfessionalrequests(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Request Approved for professional");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  //! reject request
  Future<void> rejectProfessionalrequests({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();

    final bool result =
        await userManageRepository.rejectProfessionalrequests(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: " Reject Request for professional");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  //! Delete users
  Future<void> deleteUsers({
    required BuildContext context,
    required int id,
  }) async {
    context.loaderOverlay.show();

    final bool result = await userManageRepository.deleteUsers(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Deleted Succesfully");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
    required String contact_number,
    required String surName,
  }) async {
    try {
      final bool isAdded = await userManageRepository.createUser(
        email: email,
        name: name,
        password: password,
        phoneNumber: contact_number,
        surName: surName,
      );

      return isAdded;
    } catch (e) {
      print('Error in create user: $e');
      return false;
    }
  }

  Future<bool> changePassword(
      {required String current_password,
      required String newPassword,
      required String new_password_confirmation,
      required BuildContext context}) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      final bool isAdded = await userManageRepository.changePassword(
          currentPassword: current_password,
          newPassword: newPassword,
          newPasswordConfirmation: new_password_confirmation);

      return isAdded;
    } catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print('Invalid Password: $e');
      return false;
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  UserProfessionalModel? _user;
  final bool _isLoading = false;
  String? _errorMessage;

  UserProfessionalModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  Future<void> updateUser(
      {required BuildContext context,
      required Uint8List profileimage,
      required String name,
      required String email,
      required String password,
      required String contact_number,
      required int id}) async {
    context.loaderOverlay.show();

    final bool result = await userManageRepository.updateUser(
      name: name,
      profileImage: profileimage,
      id: id,
      email: email,
      password: password,
      contact_number: contact_number,
    );
    // .whenComplete(getUsersData);

    print("result in controller is $result");
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "user updated successfully");
      notifyListeners();
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
      notifyListeners();
    }
  }

  // Future<void> logout(
  //   BuildContext context,
  // ) async {
  //   print('Logging out...');

  //   bool success = await userManageRepository.logout();

  //   print('Logout success: $success');

  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Logout successful')),
  //     );
  //     context.pushReplacementNamed(AppRoute.adminLoginPage);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Logout failed. Please try again.')),
  //     );
  //   }
  // }

  bool _isSupportMessageLoading = false;
  bool get isSupportMessageLoading => _isSupportMessageLoading;

  List<SupportMessage> _supportMessage = [];
  List<SupportMessage> get supportMessage => _supportMessage;

  Future<void> getSupportMessages() async {
    _isSupportMessageLoading = true;
    notifyListeners();
    _supportMessage = await userManageRepository.getAllUserMessages();
    _isSupportMessageLoading = false;
    notifyListeners();
    print(_supportMessage);
  }
}
