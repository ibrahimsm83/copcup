// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/image_picker_dialog.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/location_controller.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String? selectedCategory;
  int? selectedCatgoryId;
  String? selectedDay;

  List<EventCategoryModel> categories = [];
  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  String? startDate;
  String? endDate;

  Future<void> _pickDate(BuildContext context, String dateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(pickedDate),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime);

        setState(() {
          if (dateType == 'start') {
            startDate = formattedDate;
          } else if (dateType == 'end') {
            endDate = formattedDate;
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEventsCategory();
      print(categories.length);
      Provider.of<LocationController>(context, listen: false)
          .getCurrentLocation();
    });
  }

  getEventsCategory() async {
    final provider =
        Provider.of<EventCategoryController>(context, listen: false);
    await provider.getCategoryList();
    setState(() {
      categories = provider.eventCategoryList;
      print(provider.eventCategoryList);
    });
  }

  final eventname = TextEditingController();
  final eventCatagory = TextEditingController();
  final eventaddress = TextEditingController();
  final eventOpeningDays = TextEditingController();
  final eventDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
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
    final eventCatagoryProvider =
        Provider.of<EventCategoryController>(context, listen: false);
    final locationController = Provider.of<LocationController>(context);
    final size = MediaQuery.of(context).size;
    eventaddress.text = locationController.location;
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: AppLocalizations.of(context)!.add_events,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 30,
              ),
              CustomTextFormField(
                validator: (value) =>
                    Validation.fieldValidation(value, 'Event Name'),
                hint: AppLocalizations.of(context)!.na_eventName,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: eventname,
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
                    value: selectedCategory,
                    hint: Text(
                      AppLocalizations.of(context)!.select_event_catagory,
                      style: textTheme(context).bodyLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w700),
                    ),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category.categoryName,
                        child: Text(
                          category.categoryName!,
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedCatgoryId = categories
                            .firstWhere(
                                (category) => category.categoryName == value)
                            .id;
                        log('$selectedCatgoryId');
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.na_eventAddress,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Address'),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: eventaddress,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                maxline: 4,
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
                  child: DropdownButton<String>(
                    underline: SizedBox.shrink(),
                    value: selectedDay,
                    hint: Text(AppLocalizations.of(context)!.na_openingDays),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items: daysOfWeek.map((day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(
                          day,
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                validator: (value) =>
                    Validation.fieldValidation(value, 'Description'),
                hint: (AppLocalizations.of(context)!.description),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: eventDescription,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                maxline: 6,
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickDate(context, 'start');
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colorScheme(context).surface,
                          border: Border.all(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              startDate ?? 'Start Date',
                              style: TextStyle(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.date_range,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        _pickDate(context, 'end');
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colorScheme(context).surface,
                          border: Border.all(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              endDate ?? 'End Date',
                              style: TextStyle(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.8),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.date_range,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Consumer<EventController>(
                builder: (context, provider, child) => CustomButton(
                  iconColor: colorScheme(context).secondary,
                  arrowCircleColor: colorScheme(context).surface,
                  text: (AppLocalizations.of(context)!.na_createEvent),
                  backgroundColor: colorScheme(context).secondary,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final eventName = eventname.text;
                      final eventAddress = locationController.location;
                      final eventDays = eventOpeningDays.text.split(',');
                      final eventDescriptionText = eventDescription.text;

                      final day = selectedDay;
                      final id = selectedCatgoryId;
                      bool success = await provider.createEvent(
                          start_Date: startDate!,
                          end_Date: endDate!,
                          event_name: eventName,
                          image: File(_selectedImage!.path),
                          address: eventAddress,
                          days: [day!],
                          description: eventDescriptionText,
                          event_category_id: id!);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Event created Succesfully")),
                        );
                        context.pushNamed(AppRoute.responsibleBottomBar);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to create event")),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
