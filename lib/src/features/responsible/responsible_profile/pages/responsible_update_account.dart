import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ResponsibleUpdateAccountPage extends StatefulWidget {
  const ResponsibleUpdateAccountPage({super.key});

  @override
  State<ResponsibleUpdateAccountPage> createState() =>
      ResponsibleUpdateAccountPageState();
}

class ResponsibleUpdateAccountPageState
    extends State<ResponsibleUpdateAccountPage> {
  final email = TextEditingController();
  final companyName = TextEditingController();
  final mangerName = TextEditingController();
  final businessType = TextEditingController();
  final phoneNo = TextEditingController();
  final address = TextEditingController();
  final kbIs = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                setState(() {
                  _selectedImage = pickedFile;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _selectedImage = pickedFile;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: '',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Professional Account",
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _showImagePickerDialog,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colorScheme(context).surface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme(context).outline.withOpacity(0.3),
                        offset: const Offset(3, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: _selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SvgPicture.asset(
                                AppIcons.uploadIcon,
                                fit: BoxFit.fill,
                              ),
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Upload Image',
                              style: textTheme(context).titleMedium?.copyWith(
                                  fontSize: 16,
                                  color: colorScheme(context).onSurface),
                            )
                          ],
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Company Name',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Compnay Name'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: companyName,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Business Type',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Business Type'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: businessType,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Phone Number',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.phoneNumber,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: phoneNo,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Address',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.address,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: address,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Email',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.email,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: email,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'KBIS',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => Validation.fieldValidation(value, 'KBIS'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: kbIs,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
              ),
              SizedBox(
                height: 55,
              ),
              CustomButton(
                iconColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
                text: 'Update',
                backgroundColor: colorScheme(context).secondary,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final ResponsibleAuthController responsibleAuthController =
                        ResponsibleAuthController();
                    responsibleAuthController.editResponsibleAccount(
                      email: email.text,
                      // bannerImage: File(_selectedImage!.path),
                      context: context,
                      companyName: companyName.text,
                      buinessType: businessType.text,
                      phonenumber: phoneNo.text,
                      address: address.text,
                      kbisnumber: kbIs.text,
                      onSuccess: (message) async {
                        showSnackbar(message: 'Sucess$message');
                        MyAppRouter.clearAndNavigate(
                            context, AppRoute.responsibleBottomBar);
                      },
                      onError: (error) {
                        showSnackbar(message: error, isError: true);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
