import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';

import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variable.dart';
import '../../../../common/utils/image_picker_dialog.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_buton.dart';
import 'package:http/http.dart' as http;

class UpdateFoodCatagoryPage extends StatefulWidget {
  final FoodCatagoryModel foodcatagory;
  const UpdateFoodCatagoryPage({super.key, required this.foodcatagory});

  @override
  State<UpdateFoodCatagoryPage> createState() => _UpdateFoodCatagoryPageState();
}

class _UpdateFoodCatagoryPageState extends State<UpdateFoodCatagoryPage> {
  final catagoryName = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  Future<XFile?> urlToXFile(String imageUrl) async {
    context.loaderOverlay.show();
    try {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a new file path in the temp directory
      final filePath =
          '${tempDir.path}/temp_image${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Download the image bytes
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Write the image bytes to the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Convert to XFile and return
        return XFile(file.path);
      } else {
        print('Failed to download image');
        return null;
      }
    } catch (e) {
      print('Error converting image URL to XFile: $e');
      return null;
    } finally {
      context.loaderOverlay.hide();
    }
  }

  convertImage() async {
    if (widget.foodcatagory.image != null &&
        widget.foodcatagory.image!.isNotEmpty) {
      _selectedImage = await urlToXFile(widget.foodcatagory.image!);
      setState(() {}); // Update UI after fetching the image
    }
  }

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

  // List<EventModel> events = [];
  // int? selectedEventId;
  // String? selectedEvent;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getEvents();
      catagoryName.text = widget.foodcatagory.categoryName!;
      convertImage();
      print("Selected Image: $_selectedImage");
    });
    super.initState();
  }

  // getEvents() async {
  //   final provider = Provider.of<EventController>(context, listen: false);
  //   await provider.getEventList();
  //   if (mounted) {
  //     setState(() {
  //       events = provider.eventList;

  //       print(provider.eventList);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Update Category',
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
                              'Upload Icon',
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
                hint: 'Category Name',
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
                    Validation.fieldValidation(value, 'Updated Category Name'),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   width: double.infinity,
              //   height: size.height * 0.07,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: colorScheme(context).onSurface.withOpacity(.10),
              //     ),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: DropdownButton(
              //       underline: SizedBox.shrink(),
              //       value: selectedEvent,
              //       hint: Text(AppLocalizations.of(context)!.select_event),
              //       isExpanded: true,
              //       icon: Icon(Icons.arrow_drop_down),
              //       items: events.map((event) {
              //         return DropdownMenuItem(
              //           value: event.eventName,
              //           child: Text(
              //             event.eventName,
              //             style: textTheme(context).bodyLarge?.copyWith(
              //                 color: colorScheme(context)
              //                     .onSurface
              //                     .withOpacity(0.7),
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           selectedEvent = value;
              //           selectedEventId = events
              //               .firstWhere((event) => event.eventName == value)
              //               .id;
              //           print('$selectedEventId');
              //         });
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 100,
              ),
              Consumer<FoodCatagoryController>(
                builder: (context, provider, child) => CustomButton(
                  height: 55,
                  iconColor: colorScheme(context).secondary,
                  backgroundColor: colorScheme(context).secondary,
                  text: 'Update Category',
                  onPressed: () {
                    print("Selected Image: $_selectedImage");
                    if (_formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      final String name = catagoryName.text.trim();
                      // final id = selectedEventId;
                      provider.updateFoodCatagory(
                        // eventid: id,
                        id: widget.foodcatagory.id!,
                        context: context,
                        name: name,
                        image: File(_selectedImage!.path),
                      );
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
