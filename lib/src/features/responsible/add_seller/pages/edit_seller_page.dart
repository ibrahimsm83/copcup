// ignore_for_file: unused_local_variable, unused_field
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/constants/global_variable.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class EditSellerPage extends StatefulWidget {
  final UserProfessionalModel userProfessionalModel;
  const EditSellerPage({super.key, required this.userProfessionalModel});

  @override
  State<EditSellerPage> createState() => _EditSellerPageState();
}

class _EditSellerPageState extends State<EditSellerPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final attributedEvent = TextEditingController();

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

  List<EventModel> events = [];
  int? selectedEventId;
  String? selectedEvent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final seller =
          Provider.of<SellerAuthController>(context, listen: false).seller;
      // if (seller != null) {
      name.text = widget.userProfessionalModel.name ?? '';
      email.text = widget.userProfessionalModel.email ?? '';
      _controller.text = widget.userProfessionalModel.contactNumber ?? '';
      // selectedEvent = widget.userProfessionalModel.
      // }
      getProfessionalEvents();
    });
  }

  getProfessionalEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalEvents();
    setState(() {
      events = provider.professionalEventList;
      print(provider.eventList);
    });
  }

  @override
  Widget build(BuildContext context) {
    log('seller id is this ---------------${widget.userProfessionalModel.eventId}');
    final size = MediaQuery.of(context).size;
    final _provider =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);

    return Scaffold(
      appBar: ResponsibleAppBar(
        title: AppLocalizations.of(context)!.na_editSellerProfile,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme(context).primary),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // CircleAvatar(
                          //   radius: 50,
                          //   backgroundImage: _selectedImage == null
                          //       ? NetworkImage(
                          //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                          //         )
                          //       : FileImage(_selectedImage!) as ImageProvider,
                          // ),

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
                                    imageUrl: widget
                                            .userProfessionalModel.image ??
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
                                color: colorScheme(context).primary, width: 4),
                            borderRadius: BorderRadius.circular(12),
                            color: colorScheme(context).surface,
                          ),
                          child: Icon(Icons.photo_outlined,
                              color: colorScheme(context).primary, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.nameHint,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validationType: ValidationType.name,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: name,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
                isDense: true,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                isEnabled: false,
                hint: AppLocalizations.of(context)!.emailHint,
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
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    AppIcons.emailIcon,
                    height: 15,
                  ),
                ),
                isDense: true,
              ),
              const SizedBox(
                height: 20,
              ),

              DropdownButtonFormField<String>(
                hint: Text(
                  AppLocalizations.of(context)!.select_event,
                ),
                value:
                    attributedEvent.text.isEmpty ? null : attributedEvent.text,
                // onChanged: (String? newValue) {
                //   setState(() {
                //     attributedEvent.text = newValue!;
                //   });
                // },
                onChanged: (value) {
                  setState(() {
                    selectedEvent = value;
                    selectedEventId = events
                        .firstWhere((event) => event.eventName == value)
                        .id;
                    print('---------------------------$selectedEventId');
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a event ';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: colorScheme(context).onSurface.withOpacity(.10)),
                  ),
                  // labelText: "Discount Type",
                  // labelStyle: TextStyle(color: Color(0xff555555)),
                  filled: true,
                  fillColor: colorScheme(context).surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: colorScheme(context).onSurface.withOpacity(.10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: colorScheme(context).onSurface.withOpacity(.10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colorScheme(context).error),
                  ),
                ),

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
                // items:events .map<DropdownMenuItem<String>>((String value) {
                //   return DropdownMenuItem<String>(
                //     value: value,
                //     child: Text(
                //       value,
                //       style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   );
                // }).toList(),
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
              //           print('---------------------------$selectedEventId');
              //         });
              //       },
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 80,
              ),
              Consumer<SellerAuthController>(
                  builder: (context, sellerauthcontroller, child) {
                return CustomButton(
                  iconColor: colorScheme(context).secondary,
                  arrowCircleColor: colorScheme(context).surface,
                  text: AppLocalizations.of(context)!.na_saveChanges,
                  backgroundColor: colorScheme(context).secondary,
                  onPressed: () async {
                    log(_provider.password.text);

                    log('---------------select event ${selectedEvent}');
                    final overlay = context.loaderOverlay;
                    if (_formKey.currentState!.validate()) {
                      final eventid = selectedEventId;
                      overlay.show();
                      await sellerauthcontroller
                          .updateSellerProfileControllerData(
                        eventid: eventid!,
                        context: context,
                        image: _selectedImage != null
                            ? File(_selectedImage!.path)
                            : null, //_selectedImage!,
                        name: name.text,
                        email: email.text,
                        password: _provider.password.text,
                        id: widget.userProfessionalModel.id,
                        onSuccess: (message) async {
                          overlay.hide();
                          showSnackbar(message: 'Sucess$message');

                          context.pop();
                        },
                        onError: (error) {
                          log('${sellerauthcontroller.seller!.id}');
                          showSnackbar(message: error, isError: true);
                        },
                      );
                    }
                  },
                );
              }),
            ]),
          )),
    );
  }
}
