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
import 'package:provider/provider.dart';

class ResponsibleSignUpPage extends StatefulWidget {
  const ResponsibleSignUpPage({super.key});

  @override
  State<ResponsibleSignUpPage> createState() => _ResponsibleSignUpPageState();
}

class _ResponsibleSignUpPageState extends State<ResponsibleSignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController mangerName = TextEditingController();
  TextEditingController businessType = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController kbIs = TextEditingController();
  TextEditingController password = TextEditingController();
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
                height: 10,
              ),
              Text(
                "Ask information to manage professional account",
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w700),
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Manager Name',
                inputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Manager Name'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: mangerName,
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Email',
                inputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => Validation.emailValidation(value),
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Company Name',
                inputAction: TextInputAction.next,
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Business Type',
                inputAction: TextInputAction.next,
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Phone Number',
                inputAction: TextInputAction.next,
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Address',
                inputAction: TextInputAction.next,
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'KBIS Number',
                inputAction: TextInputAction.next,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'KBIS Number'),
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
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Password',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => Validation.passwordValidation(value),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: password,
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
              Consumer<ResponsibleAuthController>(
                  builder: (context, responsibleAuthController, child) {
                return CustomButton(
                  iconColor: colorScheme(context).secondary,
                  arrowCircleColor: colorScheme(context).surface,
                  text: 'Sign up',
                  backgroundColor: colorScheme(context).secondary,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedImage != null) {
                        responsibleAuthController.registerResponsible(
                          bannerImage: File(_selectedImage!.path),
                          companyName: companyName.text.trim(),
                          buinessType: businessType.text.trim(),
                          phonenumber: phoneNo.text.trim(),
                          address: address.text.trim(),
                          kbisnumber: kbIs.text.trim(),
                          mangerName: mangerName.text.trim(),
                          companyEmail: email.text.trim(),
                          eventId: '',
                          password: password.text.trim(),
                          context: context,
                          // onSuccess: (message) async {
                          //   showSnackbar(message: 'Sucess$message');
                          //   showGeneralDialog(
                          //     context: context,
                          //     barrierDismissible: true,
                          //     barrierLabel: MaterialLocalizations.of(context)
                          //         .modalBarrierDismissLabel,
                          //     barrierColor: Colors.black45,
                          //     transitionDuration:
                          //         const Duration(milliseconds: 200),
                          //     pageBuilder: (BuildContext buildContext,
                          //         Animation animation,
                          //         Animation secondaryAnimation) {
                          //       return Center(
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(12),
                          //             color: Colors.white,
                          //           ),
                          //           width:
                          //               MediaQuery.of(context).size.width * 0.7,
                          //           height:
                          //               MediaQuery.of(context).size.height * 0.3,
                          //           padding: EdgeInsets.all(20),
                          //           child: Column(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               Center(
                          //                 child: Text(
                          //                   'Alert!',
                          //                   style: textTheme(context)
                          //                       .titleLarge
                          //                       ?.copyWith(
                          //                           color: colorScheme(context)
                          //                               .onSurface,
                          //                           fontWeight: FontWeight.w600),
                          //                 ),
                          //               ),
                          //               SizedBox(height: 20),
                          //               Center(
                          //                 child: Text(
                          //                   'Your account is in preview, You’ll receive an email when you are eligible for this.',
                          //                   style: textTheme(context)
                          //                       .bodySmall
                          //                       ?.copyWith(
                          //                           color: colorScheme(context)
                          //                               .onSurface,
                          //                           fontWeight: FontWeight.w400),
                          //                 ),
                          //               ),
                          //               const SizedBox(height: 30),
                          //               SizedBox(
                          //                 width: size.width * 0.7,
                          //                 height: size.height * 0.07,
                          //                 child: ElevatedButton(
                          //                   onPressed: () {},
                          //                   style: ElevatedButton.styleFrom(
                          //                     backgroundColor:
                          //                         colorScheme(context).secondary,
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(30.0),
                          //                     ),
                          //                   ),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       SizedBox(width: 20),
                          //                       Text(
                          //                         'Done',
                          //                         style: textTheme(context)
                          //                             .bodySmall
                          //                             ?.copyWith(
                          //                                 color:
                          //                                     colorScheme(context)
                          //                                         .surface,
                          //                                 fontWeight:
                          //                                     FontWeight.w600),
                          //                       ),
                          //                       CircleAvatar(
                          //                         radius: 15,
                          //                         backgroundColor:
                          //                             colorScheme(context)
                          //                                 .surface,
                          //                         child: Icon(
                          //                           Icons.arrow_forward,
                          //                           color: colorScheme(context)
                          //                               .secondary,
                          //                           size: 15.0,
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   );

                          //   Future.delayed(Duration(seconds: 4), () {
                          //     Navigator.of(context).pop();
                          //     context.pushReplacementNamed(
                          // AppRoute.responsibleOtpCreateNewPin);
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(
                          //             'Your account request has been approved'),
                          //         duration: Duration(seconds: 2),
                          //       ),
                          //     );
                          //   });
                          // },
                          // onError: (error) {
                          //   showSnackbar(message: error, isError: true);
                          // },
                        );
                      } else {
                        showSnackbar(
                            message: 'Imgae filed is required !',
                            isError: true);
                      }
                    }
                  },
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: textTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: colorScheme(context).onSurface.withOpacity(0.6)),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.responsiblesignInPage, extra: {
                        'role': 'professional',
                      });
                    },
                    child: Text(
                      ' Login',
                      style: textTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: colorScheme(context).secondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
