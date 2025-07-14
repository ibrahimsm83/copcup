import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variable.dart';
import '../../../../common/utils/image_picker_dialog.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AddEventCatagoryPage extends StatefulWidget {
  const AddEventCatagoryPage({super.key});

  @override
  State<AddEventCatagoryPage> createState() =>
      _ResponsibleCreateItemPageState();
}

class _ResponsibleCreateItemPageState extends State<AddEventCatagoryPage> {
  final catagoryName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => ImagePickerDialog(
        onCameraTap: () async {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile;
            });
          }
          Navigator.pop(context);
        },
        onGalleryTap: () async {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile;
            });
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.add_event_category,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
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
                        color: colorScheme(context).outline.withOpacity(0.4),
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
                              AppLocalizations.of(context)!.na_uploadIcon,
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
              SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                hint: AppLocalizations.of(context)!.na_categoryName,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: catagoryName,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                isDense: true,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Category Name'),
              ),
              SizedBox(
                height: 280,
              ),
              Consumer<EventCategoryController>(
                builder: (context, provider, child) => CustomButton(
                  height: 55,
                  iconColor: colorScheme(context).secondary,
                  backgroundColor: colorScheme(context).secondary,
                  text: AppLocalizations.of(context)!.na_addCategory,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      final String name = catagoryName.text.trim();
                      provider.addEventCategory(
                        context: context,
                        name: name,
                        image: File(_selectedImage!.path),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Catagory added successfully "),
                        backgroundColor: colorScheme(context).secondary,
                      ));
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
