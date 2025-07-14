import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variable.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class EditFoodItemPage extends StatefulWidget {
  final FoodItemModel foodItem;
  const EditFoodItemPage({super.key, required this.foodItem});

  @override
  State<EditFoodItemPage> createState() => _CreateFoodItemPageState();
}

class _CreateFoodItemPageState extends State<EditFoodItemPage> {
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
  final List<int> alcoholTypes = [0, 1];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    log('----Event id ------------------------------${widget.foodItem.eventId}');

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFoodCategory();
      getProfessionalEvents();
      itemName.text = widget.foodItem.name!;
      itemPrice.text = widget.foodItem.price.toString();
      itemDescription.text = widget.foodItem.description!;
      selectedAlcoholType = widget.foodItem.isAlcoholic;
      itemQuantity.text = widget.foodItem.quantity.toString();
    });
  }

  getFoodCategory() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);
    await provider.responsibleGetFoodItem();
    setState(() {
      foodcategories = provider.foodCategoryList;
      selectedFoodCategory = foodcategories
          .firstWhere(
              (category) => category.id == widget.foodItem.foodCategoryId)
          .categoryName;
      print(provider.foodCategoryList);
    });
  }

  getProfessionalEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalEvents();
    setState(() {
      events = provider.professionalEventList;
      selectedEvent = provider.professionalEventList
          .firstWhere((event) => event.id == widget.foodItem.eventId)
          .eventName;
      print(provider.eventList);
    });
  }

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
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.edit_item,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
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
                        color: colorScheme(context).outline.withOpacity(0.3),
                        offset: const Offset(3, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: _selectedImage == null
                      ? widget.foodItem.image!.isNotEmpty
                          ? Image.network(widget.foodItem.image!)
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
                                )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.na_uploadIcon,
                                  style: textTheme(context)
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 16,
                                          color:
                                              colorScheme(context).onSurface),
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
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 60,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                isDense: true,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Item Name'),
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
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Item Price'),
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
                    hint: Text(
                        AppLocalizations.of(context)!.select_food_category),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items: foodcategories.map((foodcategory) {
                      return DropdownMenuItem(
                        value: foodcategory.categoryName,
                        child: Text(
                          foodcategory.categoryName!,
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
                        selectedFoodCategory = value;
                        selectedFoodCatgoryId = foodcategories
                            .firstWhere(
                                (category) => category.categoryName == value)
                            .id;
                        log('=========selected food category==========$selectedFoodCatgoryId');
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
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
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
                          color:
                              colorScheme(context).onSurface.withOpacity(0.7),
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
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text(
                          AppLocalizations.of(context)!.alcoholic,
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
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
                  hint: AppLocalizations.of(context)!.item_description,
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
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Item Description'),
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
                  validator: (value) =>
                      Validation.fieldValidation(value, 'Item Quantity'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<FoodItemController>(
                builder: (context, provider, child) => CustomButton(
                  height: 55,
                  iconColor: colorScheme(context).secondary,
                  backgroundColor: colorScheme(context).secondary,
                  text: AppLocalizations.of(context)!.update_item,
                  onPressed: () async {
                    print(_selectedImage);

                    if (_formKey.currentState!.validate()) {
                      final id = selectedFoodCatgoryId;
                      final eventid = selectedEventId;
                      final alcoholType =
                          itemType.text.toLowerCase() == "alcoholic" ? 1 : 0;

                      // ✅ Parse price and quantity safely (handle decimal values)
                      final parsedPrice =
                          double.parse(itemPrice.text.trim()).toInt();
                      final parsedQuantity =
                          int.parse(itemQuantity.text.trim());

                      await Provider.of<FoodItemController>(context,
                              listen: false)
                          .updateFoodItem(
                        quantity: parsedQuantity,
                        context: context,
                        name: itemName.text.trim(),
                        image: _selectedImage == null
                            ? File(widget.foodItem.image!)
                            : File(_selectedImage!.path),
                        foodcategoryid:
                            id != null ? id : widget.foodItem.foodCategoryId!,
                        eventid: eventid != null
                            ? eventid
                            : widget.foodItem.eventId!,
                        price: parsedPrice,
                        is_alcoholic: alcoholType,
                        description: itemDescription.text.trim(),
                        id: widget.foodItem.id!,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Item updated successfully"),
                        backgroundColor: colorScheme(context).secondary,
                      ));

                      context.pushNamed(AppRoute.responsibleBottomBar);
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
      ),
    );
  }
}
