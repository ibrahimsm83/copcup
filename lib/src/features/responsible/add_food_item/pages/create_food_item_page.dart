import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variable.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class CreateFoodItemPage extends StatefulWidget {
  const CreateFoodItemPage({super.key});

  @override
  State<CreateFoodItemPage> createState() => _CreateFoodItemPageState();
}

class _CreateFoodItemPageState extends State<CreateFoodItemPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Selector<ResponsibleHomeProvider, int>(
        selector: (_, provider) => provider.currentIndex,
        builder: (context, index, child) => page[index],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resCreateItem
            ? ResponsibleCreateFoodWidget()
            : ResponsibleStock()),
    InboxPage(),
    ResponsibleProfilePage(),
  ];
}

class ResponsibleCreateFoodWidget extends StatefulWidget {
  const ResponsibleCreateFoodWidget({super.key});

  @override
  State<ResponsibleCreateFoodWidget> createState() =>
      _ResponsibleCreateFoodWidgetState();
}

class _ResponsibleCreateFoodWidgetState
    extends State<ResponsibleCreateFoodWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final TextEditingController itemType = TextEditingController();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();
  final itemQuantity = TextEditingController();
  final itemDescription = TextEditingController();

  List<FoodCatagoryModel> foodcategories = [];
  List<EventModel> events = [];
  String? selectedFoodCategory;
  int? selectedFoodCatgoryId;
  int? selectedEventId;
  String? selectedEvent;
  int selectedAlcoholType = 0;

  final _formKey = GlobalKey<FormState>();
  String startTime = '';

  String endTime = '';

  Future<void> _pickTime(BuildContext context, String timeType) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      String formattedTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime);

      setState(() {
        if (timeType == 'start') {
          startTime = formattedTime;
        } else if (timeType == 'end') {
          endTime = formattedTime;
        }
      });
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFoodCategory();
      getProfessionalEvents();
    });
    super.initState();
  }

  getFoodCategory() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);
    await provider.getResponsibleFoodCategoryListData();
    setState(() {
      foodcategories = provider.responsiblefoodCategoryList;
      print(provider.responsiblefoodCategoryList);
    });
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

  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.na_selectImageSource),
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
            child: Text(AppLocalizations.of(context)!.na_pickCamera),
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
            child: Text(AppLocalizations.of(context)!.na_pickGallery),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(Icons.arrow_back)),
                Text(
                  AppLocalizations.of(context)!.create_item,
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
              hint: AppLocalizations.of(context)!.item_name,
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: itemName,
              filled: true,
              inputAction: TextInputAction.next,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 60,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              isDense: true,
              validator: (value) => Validation.fieldValidation(
                  value, AppLocalizations.of(context)!.na_itemName),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CustomTextFormField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                hint: AppLocalizations.of(context)!.item_price,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: itemPrice,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                isDense: true,
                keyboardType: TextInputType.number,
                validator: (value) => Validation.fieldValidation(
                    value, AppLocalizations.of(context)!.item_price),
              ),
            ),
            SizedBox(
              height: 10,
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
                  value: selectedFoodCategory,
                  hint:
                      Text(AppLocalizations.of(context)!.select_food_category),
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  items: foodcategories.map((foodcategory) {
                    return DropdownMenuItem(
                      value: foodcategory.categoryName,
                      child: Text(
                        foodcategory.categoryName!,
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFoodCategory = value;
                      selectedFoodCatgoryId = foodcategories
                          .firstWhere(
                              (category) => category.categoryName == value)
                          .id;
                      print('$selectedFoodCatgoryId');
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 19,
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
                      print('$selectedEventId');
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 19,
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
                child: DropdownButton<int>(
                  value: selectedAlcoholType,
                  hint: Text(
                    AppLocalizations.of(context)!.alcoholic,
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedAlcoholType = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text(
                        AppLocalizations.of(context)!.non_alcoholic,
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(
                        AppLocalizations.of(context)!.alcoholic,
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  underline: SizedBox.shrink(),
                  isExpanded: true,
                  icon: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: colorScheme(context).onSurface.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CustomTextFormField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                hint: AppLocalizations.of(context)!.na_itemDescription,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: itemDescription,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                isDense: true,
                validator: (value) => Validation.fieldValidation(
                    value, AppLocalizations.of(context)!.item_description),
                maxline: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CustomTextFormField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                hint: AppLocalizations.of(context)!.na_sellerHomeQuantity,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: itemQuantity,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                isDense: true,
                validator: (value) => Validation.fieldValidation(value,
                    '${AppLocalizations.of(context)!.sellerHomeItems} ${AppLocalizations.of(context)!.na_sellerHomeQuantity}'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           _pickTime(context, 'start');
            //         },
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             color: colorScheme(context).surface,
            //             border: Border.all(
            //               color:
            //                   colorScheme(context).onSurface.withOpacity(0.1),
            //             ),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 startTime.isEmpty
            //                     ? AppLocalizations.of(context)!.start_time
            //                     : startTime,
            //                 style: TextStyle(
            //                   color: colorScheme(context)
            //                       .onSurface
            //                       .withOpacity(0.8),
            //                   fontSize: 16,
            //                 ),
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Icon(
            //                 Icons.access_time,
            //                 color:
            //                     colorScheme(context).onSurface.withOpacity(0.6),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 16),
            //       GestureDetector(
            //         onTap: () {
            //           _pickTime(context, 'end');
            //         },
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             color: colorScheme(context).surface,
            //             border: Border.all(
            //               color:
            //                   colorScheme(context).onSurface.withOpacity(0.1),
            //             ),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 endTime.isEmpty
            //                     ? AppLocalizations.of(context)!.end_time
            //                     : endTime,
            //                 style: TextStyle(
            //                   color: colorScheme(context)
            //                       .onSurface
            //                       .withOpacity(0.8),
            //                   fontSize: 16,
            //                 ),
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Icon(
            //                 Icons.access_time,
            //                 color:
            //                     colorScheme(context).onSurface.withOpacity(0.6),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Consumer<FoodItemController>(
              builder: (context, provider, child) => CustomButton(
                height: 55,
                iconColor: colorScheme(context).secondary,
                backgroundColor: colorScheme(context).secondary,
                text: AppLocalizations.of(context)!.create_item,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final alcoholType =
                        itemType.text.toLowerCase() == "alcoholic" ? 1 : 0;

                    if (selectedFoodCategory!.isNotEmpty &&
                        selectedEvent!.isNotEmpty &&
                        _selectedImage != null) {
                      final id = selectedFoodCatgoryId;
                      final eventid = selectedEventId;
                      context.loaderOverlay.show();
                      Provider.of<FoodItemController>(context, listen: false)
                          .addFoodItem(
                        quantity: int.parse(itemQuantity.text.trim()),
                        name: itemName.text.trim(),
                        image: File(_selectedImage!.path),
                        foodcategory_id: id!,
                        eventid: eventid!,
                        price: double.parse(itemPrice.text.trim()),
                        is_alcoholic: alcoholType,
                        description: itemDescription.text.trim(),
                        // start_time: startTime!,
                        // end_time: endTime!,
                      )
                          .then((val) {
                        context.loaderOverlay.hide();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .item_created_successfully),
                          backgroundColor: colorScheme(context).secondary,
                        ));

                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Lottie.asset(
                                        AppLottieImage.lottieCongrats,
                                        height: 142,
                                        width: 139,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .congratulations,
                                          style: textTheme(context)
                                              .titleLarge
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w600)),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .item_created_message,
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      width: size.width * 0.7,
                                      height: size.height * 0.07,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.pushNamed(
                                              AppRoute.responsibleBottomBar);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              colorScheme(context).secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 20),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .view_item,
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color:
                                                            colorScheme(context)
                                                                .surface,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  colorScheme(context).surface,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: colorScheme(context)
                                                    .secondary,
                                                size: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            AppLocalizations.of(context)!.na_fillAllInputs),
                        backgroundColor: colorScheme(context).secondary,
                      ));
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
