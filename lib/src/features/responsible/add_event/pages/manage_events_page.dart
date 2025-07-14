import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/image_picker_dialog.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';

import '../../../../common/utils/validations.dart';

class ManageEventsPage extends StatefulWidget {
  final EventModel event;
  const ManageEventsPage({super.key, required this.event});

  @override
  State<ManageEventsPage> createState() => _ManageEventsPageState();
}

class _ManageEventsPageState extends State<ManageEventsPage> {
  final ImagePicker _picker = ImagePicker();
  String? selectedCategory;
  int? selectedCatgoryId;
  String? selectedDay;

  List<EventCategoryModel> categories = [];
  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEventsCategory();
      // Provider.of<LocationController>(context, listen: false)
      //     .getCurrentLocation();
      print(categories.length);
      eventname.text = widget.event.eventName;
      eventDescription.text = widget.event.description.toString();
      eventaddress.text = widget.event.address;
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

  String? startDate;
  String? endDate;

  Future<void> _pickDate(BuildContext context, String dateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set the minimum date
      lastDate: DateTime(2100), // Set the maximum date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        if (dateType == 'start') {
          startDate = formattedDate;
        } else if (dateType == 'end') {
          endDate = formattedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('0000');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: AppLocalizations.of(context)!.manage_events,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _selectedImage == null
                        ? widget.event.image.isNotEmpty
                            ? Image.network(
                                widget.event.image,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SvgPicture.asset(
                                        AppIcons.uploadIcon,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    AppLocalizations.of(context)!.na_uploadIcon,
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 16,
                                            color:
                                                colorScheme(context).onSurface),
                                  ),
                                ],
                              )
                        : Image.file(
                            File(_selectedImage!.path),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        _showImagePickerDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: colorScheme(context).primary, width: 4),
                          borderRadius: BorderRadius.circular(12),
                          color: colorScheme(context).surface,
                        ),
                        child: Icon(
                          Icons.photo_outlined,
                          color: colorScheme(context).primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: 'Gourmet Bites',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Event Name'),
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
                height: 25,
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
                        AppLocalizations.of(context)!.select_event_catagory),
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
                              fontWeight: FontWeight.w500),
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
                height: 25,
              ),
              CustomTextFormField(
                hint: '7 El Batrawy Street, Qalyub',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Event Location'),
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
              ),
              SizedBox(
                height: 25,
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
                height: 25,
              ),
              CustomTextFormField(
                hint:
                    'Join us for an unforgettable evening of music, magic, and memories at ....',
                validator: (value) =>
                    Validation.fieldValidation(value, 'Event Description'),
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
                height: 50,
              ),
              Consumer<EventController>(
                builder: (context, provider, child) => CustomButton(
                  iconColor: colorScheme(context).secondary,
                  arrowCircleColor: colorScheme(context).surface,
                  text: AppLocalizations.of(context)!.na_saveChanges,
                  backgroundColor: colorScheme(context).secondary,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      final day = selectedDay;
                      final id = selectedCatgoryId;
                      provider.updateEvent(
                          start_Date: startDate!,
                          end_Date: endDate!,
                          context: context,
                          id: widget.event.id,
                          event_name: eventname.text,
                          image: File(_selectedImage!.path),
                          address: eventaddress.text,
                          days: [day!],
                          description: eventDescription.text,
                          event_category_id: id!);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("event updated successfully"),
                        backgroundColor: colorScheme(context).secondary,
                      ));
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
