// ignore_for_file: unused_field

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/image_picker_dialog.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/validations.dart';
import '../../../../common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AddFoodCatagoryPage extends StatefulWidget {
  const AddFoodCatagoryPage({super.key});

  @override
  State<AddFoodCatagoryPage> createState() => _AddFoodCatagoryPageState();
}

class _AddFoodCatagoryPageState extends State<AddFoodCatagoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ResponsibleBottomBarWidget(),
        // appBar: CustomAppBar(
        //   title: AppLocalizations.of(context)!.na_addCategory,
        //   onLeadingPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        body: Consumer<ResponsibleHomeProvider>(
          builder: (context, value, child) => page[value.currentIndex],
        ));
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAddCategory
            ? ResponsibleAddFoodCategoryWidget()
            : ResponsibleStock()),
    InboxPage(),
    ResponsibleProfilePage()
  ];
}

class ResponsibleAddFoodCategoryWidget extends StatefulWidget {
  const ResponsibleAddFoodCategoryWidget({super.key});

  @override
  State<ResponsibleAddFoodCategoryWidget> createState() =>
      _ResponsibleAddFoodCategoryWidgetState();
}

class _ResponsibleAddFoodCategoryWidgetState
    extends State<ResponsibleAddFoodCategoryWidget> {
  final FoodCatagoryController controller = FoodCatagoryController();
  final catagoryName = TextEditingController();
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

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  List<EventModel> events = [];
  int? selectedEventId;
  String? selectedEvent;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfessionalEvents();
    });
    super.initState();
  }

  getProfessionalEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalEvents();
    if (mounted) {
      setState(() {
        events = provider.professionalEventList;
        print(provider.eventList);
      });
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.na_addCategory,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _showImagePickerDialog();
            },
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
            focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            isDense: true,
            validator: (value) =>
                Validation.fieldValidation(value, 'Category Name'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme(context).onSurface.withOpacity(.10),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                underline: SizedBox.shrink(),
                value: selectedEvent,
                hint: Text(AppLocalizations.of(context)!.select_event),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                items: events.map((event) {
                  return DropdownMenuItem(
                    value: event.eventName,
                    child: Text(
                      event.eventName,
                      style: textTheme(context).bodyLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEvent = value;
                    selectedEventId = events
                        .firstWhere((event) => event.eventName == value)
                        .id;
                    log('----------event id is ======>>>>> ${selectedEventId}');
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 240,
          ),
          Consumer<FoodCatagoryController>(
            builder: (context, provider, child) => CustomButton(
              height: 55,
              iconColor: colorScheme(context).secondary,
              backgroundColor: colorScheme(context).secondary,
              text: AppLocalizations.of(context)!.na_addCategory,
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _selectedImage != null &&
                    selectedEventId != null) {
                  final String name = catagoryName.text.trim();
                  final id = selectedEventId;
                  log('----------event id is ======>>>>> ${id}');

                  await provider.addFoodCatagory(
                    eventid: id!,
                    context: context,
                    name: name,
                    image: File(_selectedImage!.path),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(" Event and image also required! "),
                    backgroundColor: colorScheme(context).secondary,
                  ));
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}
