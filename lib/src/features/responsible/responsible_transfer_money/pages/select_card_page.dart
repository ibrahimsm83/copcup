import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/resposible_transfer_provider/reposible_transfer_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfe_money_amount_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfer_money_custom_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

class SelectCardPage extends StatelessWidget {
  SelectCardPage({super.key});

  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MoneyTransferAppbar(titil: 'Select a Card')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransfeMoneyWidget(
                description:
                    'Please, enter the amount of money transfer in below field.',
                amountText: 'Enter Amount',
              ),
              Consumer<ResponsibleTransferProvider>(
                builder: (context, value, child) => TextFormField(
                  controller: priceController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter the amount .';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    value.updatePriceValidation(val.isNotEmpty);
                  },
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: 'Rs. 56,000.00',
                      hintStyle: textTheme(context).bodyMedium?.copyWith(
                            color: AppColor.appGreyColor.withOpacity(.75),
                          ),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).error),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme(context).secondary),
                      ),
                      suffixIcon: value.pricevalidate == false
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 15,
                                width: 15,
                                child: Icon(
                                  Icons.check,
                                  size: 10,
                                  color: colorScheme(context).surface,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorScheme(context).secondary,
                                ),
                              ),
                            )),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                  child: TransferMoneyCustomButton(
                text: 'Next',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.pushNamed(AppRoute.selectBankTransfer);
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const NextScreen({
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Location")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latitude: $latitude"),
            Text("Longitude: $longitude"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can save to Firestore or local DB here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Location saved successfully!")),
                );
              },
              child: Text("Final Save"),
            )
          ],
        ),
      ),
    );
  }
}
