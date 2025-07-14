import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/controller/transcation_controller.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/pages/transaction_page.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
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
                AppLocalizations.of(context)!.transactionOption,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.recentPaymentsTitle,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<TranscationController>(
                builder: (context, transaction, child) {
              if (transaction.isUserTransactionLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (transaction.userTransactionList == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final userTransaction = transaction.userTransactionList;

              return ListView.builder(
                itemCount: userTransaction.length,
                itemBuilder: (context, index) {
                  final transaction = userTransaction[index];
                  return TransactionCard(
                    name: transaction.seller.name,
                    amount: priceFormated(transaction.amount) + ' €',
                    date: transaction.createdAt,
                    imageUrl:
                        'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  );
                },
              );
            }),
          ),
        ]));
  }
}
