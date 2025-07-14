import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String selectedOption = 'email';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void setSelectedOption(String option) {
    selectedOption = option;
    notifyListeners();
  }

  bool validateInput(BuildContext context) {
    if (selectedOption == 'email' && emailController.text.isEmpty) {
      _showErrorSnackbar(context, 'Please enter your email');
      return false;
    }
    if (selectedOption == 'phone' && phoneController.text.isEmpty) {
      _showErrorSnackbar(context, 'Please enter your phone number');
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
