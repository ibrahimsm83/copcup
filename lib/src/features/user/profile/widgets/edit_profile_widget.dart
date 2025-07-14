import 'dart:io';
import 'dart:developer' as dev;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';

import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/country_picker_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final name = TextEditingController();
  final email = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  await _cropImage(File(pickedFile.path));
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  await _cropImage(File(pickedFile.path));
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  void initState() {
    super.initState();
    final countryPickerProvider =
        Provider.of<CountryPickerProvider>(context, listen: false);
    final user = Provider.of<UserDataProvider>(context, listen: false).user;

    if (user != null) {
      name.text = user.name ?? '';
      email.text = user.email ?? '';
      _controller.text = user.contactNumber ?? '';
      countryPickerProvider.selectedPrefixVaue = user.countryCode!;

      // if (user.countryCode != null) {
      //   final country = Country.parse(user.countryCode!);
      //   if (country != null) {
      //     countryPickerProvider.updateCountry(
      //       country.flagEmoji,
      //       '+${country.phoneCode}',
      //     );
      //     _controller.text = '+${country.phoneCode} ';
      //   }
      // }
    } else {
      countryPickerProvider.selectedPrefixVaue = '+93';
    }
  }

  @override
  Widget build(BuildContext context) {
    final countryPickerProvider = Provider.of<CountryPickerProvider>(
      context,
    );
    final _provider =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    AppLocalizations.of(context)!.editProfileTitle,
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontSize: 21,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: Provider.of<UserDataProvider>(
                                                context,
                                                listen: false)
                                            .user
                                            ?.image ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 50,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: CircleAvatar(
                                        radius: 50,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                            // backgroundImage: _selectedImage != null
                            //     ? FileImage(_selectedImage!) as ImageProvider
                            //     : (Provider.of<UserDataProvider>(context,
                            //                     listen: false)
                            //                 .user
                            //                 ?.image !=
                            //             null
                            //         ? NetworkImage(
                            //             Provider.of<UserDataProvider>(context,
                            //                     listen: false)
                            //                 .user!
                            //                 .image!,
                            //           )
                            //         : const NetworkImage(
                            //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                            //           )),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showImagePickerDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 4),
                            borderRadius: BorderRadius.circular(12),
                            color: colorScheme(context).surface,
                          ),
                          child: Icon(
                            Icons.photo_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AppIcons.profileInActiveIcon,
                    color: colorScheme(context).onSurface,
                  ),
                ),
                hint: AppLocalizations.of(context)!.nameHint,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.name,
                controller: name,
                filled: true,
                fillColor: colorScheme(context).surface,
                height: 60,
                isDense: true,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AppIcons.emailIcon,
                  ),
                ),
                hint: AppLocalizations.of(context)!.emailHint,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                filled: true,
                validationType: ValidationType.email,
                height: 70,
                isDense: true,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                isEnabled: false,
                customDecoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: colorScheme(context)
                                .onSurface
                                .withOpacity(.10)))),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: _controller,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => Validation.phoneValidation(
                  value,
                ),
                textStyle: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10.0,
                ),
                prefixIcon: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        countryPickerProvider.updateCountry(
                          country.flagEmoji,
                          '+${country.phoneCode}',
                        );
                        // _controller.text = '+${country.phoneCode} ';
                        _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: _controller.text.length),
                        );
                        dev.log(
                            '-----------${country.displayName}\n---------------${country.displayName}----------------\n${_controller.selection}');
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 10),
                      Consumer<UserDataProvider>(
                        builder: (context, value, child) => Text(
                            value.user!.countryCode == null
                                ? value.user!.countryCode!
                                : countryPickerProvider.selectedPrefix),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme(context).onSurface,
                      ),
                      const SizedBox(width: 5),
                      // Text(
                      //   countryPickerProvider.selectedPrefix,
                      //   style: textTheme(context)
                      //       .bodyLarge
                      //       ?.copyWith(color: colorScheme(context).onSurface),
                      // ),
                    ],
                  ),
                ),
                hint: "(+1) 724-848-1225",
              ),
              // IntlPhoneField(
              //   dropdownIconPosition: IconPosition.leading,
              //   showDropdownIcon: false,
              //   showCountryFlag: false,
              //   controller: _controller,

              //   validator: (value) => Validation.fieldValidation(
              //       value!.completeNumber, 'Country'),
              //   decoration: InputDecoration(
              //     hintText: "(+1) 724-848-1225",
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.transparent,
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: colorScheme(context).onSurface.withOpacity(.10),
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     errorBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         color: Colors.red,
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     focusedErrorBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.red),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //     disabledBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(
              //         color: Colors.transparent,
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6),
              //     ),
              //   ),
              // ),

              SizedBox(height: 80),
              Consumer<UserDataProvider>(
                  builder: (context, userdataProvider, child) {
                return CustomButton(
                  text: AppLocalizations.of(context)!.na_saveChanges,
                  backgroundColor: colorScheme(context).primary,
                  iconColor: colorScheme(context).primary,
                  onPressed: () async {
                    var data = File(userdataProvider.user!.image!);
                    dev.log('the path of defult image is -------------${data}');

                    dev.log('controller ---------------${_controller.text}');
                    if (_formKey.currentState?.validate() ?? false) {
                      // await userdataProvider.updateProfileControllerData(
                      //   countryCode: countryPickerProvider.selectedPrefix,
                      //   context: context,
                      //   profileimage: _selectedImage ??
                      //       File(userdataProvider.user!.image!),
                      //   name: name.text,
                      //   email: email.text,
                      //   contact_number: _controller.text,
                      //   id: userdataProvider.user!.id,
                      // );
                      await userdataProvider.updateProfileControllerData(
                        countryCode: countryPickerProvider.selectedPrefix,
                        context: context,
                        profileimage: _selectedImage != null
                            ? File(_selectedImage!.path)
                            : null, // Send null if no new image is selected
                        name: name.text,
                        email: email.text,
                        contact_number: _controller.text,
                        id: userdataProvider.user!.id,
                      );
                      dev.log(_controller.text.toString());

                      context.pushNamed(AppRoute.userBottomNavBar);
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
