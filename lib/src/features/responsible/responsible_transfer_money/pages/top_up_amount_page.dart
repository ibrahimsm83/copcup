import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/resposible_transfer_provider/reposible_transfer_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfe_money_amount_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfer_money_custom_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopUpAmountPage extends StatelessWidget {
  TopUpAmountPage({super.key});

  @override
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MoneyTransferAppbar(titil: 'Top-up Amount')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransfeMoneyWidget(
                description:
                    'Please, enter the amount of Sim Card Number Top-up in below field.',
                amountText: 'Enter Amount',
              ),
              Consumer<ResponsibleTransferProvider>(
                builder: (context, value, child) => TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    value.updateAmountValidation(val.isEmpty);
                  },
                  // controller: accountController,
                  validator: (validator) {
                    if (validator!.isEmpty) {
                      return 'Enter the amount .';
                    } else {
                      return null;
                    }
                    // validatePhoneNumber(val);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: 'Rs. 500.00',
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
                      suffixIcon: value.amountPrice == false
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
                      context.pushNamed(AppRoute.selectSimCardServicPage);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
