import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';

class SellerReviewBottomSheet extends StatefulWidget {
  const SellerReviewBottomSheet({Key? key}) : super(key: key);

  @override
  _SellerReviewBottomSheetState createState() =>
      _SellerReviewBottomSheetState();
}

class _SellerReviewBottomSheetState extends State<SellerReviewBottomSheet> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: colorScheme(context).onSurface,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    Text(
                      'Review',
                      style: textTheme(context).headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).onSurface,
                            fontSize: 27,
                          ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _reviewController,
                  maxLength: 400,
                  hint: 'Would you like to write anything about us?',
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Please Add a Review'),
                  borderRadius: 12,
                  hintColor: colorScheme(context).onSurface.withOpacity(0.6),
                  filled: true,
                  fillColor: colorScheme(context).onSurface.withOpacity(0.08),
                  borderColor: Colors.transparent,
                  height: 70,
                  maxline: 7,
                  focusBorderColor:
                      colorScheme(context).onSurface.withOpacity(.10),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  isDense: true,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "${400 - _reviewController.text.length} characters remaining",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 20),
                if (_reviewController.text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme(context).onSurface.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Your Review: ${_reviewController.text}",
                      style: TextStyle(
                        color: colorScheme(context).onSurface,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_reviewController.text.isNotEmpty) {
                      Navigator.pop(context, _reviewController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a review before submitting'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(175, 50),
                    backgroundColor: colorScheme(context).secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  child: Text("Submit",
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(color: colorScheme(context).surface)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
