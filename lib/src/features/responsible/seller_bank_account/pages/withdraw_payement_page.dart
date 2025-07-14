import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WithdrawPayementPage extends StatefulWidget {
  final int amount;
  const WithdrawPayementPage({super.key, required this.amount});

  @override
  State<WithdrawPayementPage> createState() => _WithdrawPayementPageState();
}

class _WithdrawPayementPageState extends State<WithdrawPayementPage> {
  final PageController _pageController = PageController();
  final messageRecipent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: 'Translate',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: PageView(
                controller: _pageController,
                children: [
                  _buildCard("Salary card", "10,000\$", "•••• •••• •••• 3040"),
                  _buildCard("Savings card", "20,000\$", "•••• •••• •••• 5678"),
                  _buildCard(
                      "Business card", "50,000\$", "•••• •••• •••• 1234"),
                  _buildCard(
                      "Business card", "50,000\$", "•••• •••• •••• 1234"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: _pageController,
              count: 4,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColor.contentColorBlue,
                dotColor: Colors.grey,
                dotHeight: 4,
                dotWidth: 4,
                expansionFactor: 3,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aleksandr",
                    style: textTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color:
                            colorScheme(context).onSurface.withOpacity(0.5))),
                const SizedBox(height: 8),
                Text("+995 559 72 88",
                    style: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 16),
                Text("Sum",
                    style: textTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color:
                            colorScheme(context).onSurface.withOpacity(0.5))),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "from 10\$ to 99,999\$",
                    hintStyle: textTheme(context).titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: colorScheme(context).onSurface.withOpacity(0.3)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Commission is not charged by the bank",
                    style: textTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color:
                            colorScheme(context).onSurface.withOpacity(0.5))),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 2,
                  controller: messageRecipent,
                  decoration: InputDecoration(
                    hintText: "Message to the recipient",
                    hintStyle: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.4),
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColor.lightGreishShade,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                CustomButton(
                    iconColor: colorScheme(context).secondary,
                    arrowCircleColor: colorScheme(context).surface,
                    text: 'Withdraw',
                    backgroundColor: colorScheme(context).secondary,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String amount, String cardNumber) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Color(0xFF0052D4), Color(0xFF65A3E1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme(context).bodySmall?.copyWith(
                    fontSize: 13,
                    color: colorScheme(context).surface.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 10),
            Text(amount,
                style: textTheme(context).headlineMedium?.copyWith(
                    color: colorScheme(context).surface,
                    fontWeight: FontWeight.w800)),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                cardNumber,
                style: textTheme(context).bodySmall?.copyWith(
                      color: colorScheme(context).surface.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
