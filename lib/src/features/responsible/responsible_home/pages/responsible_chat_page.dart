import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/widgets/refund_item.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/widgets/refund_summary.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/widgets/custom_app_bar.dart';

class ResponsibleChatPage extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ResponsibleChatPage> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    setState(() {
      messages.insert(0, _controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'James Anderson',
        action: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: GestureDetector(
            onTap: () {
              showRefundDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colorScheme(context).secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Refund Order',
                  style: textTheme(context)
                      .bodySmall
                      ?.copyWith(color: colorScheme(context).surface),
                ),
              ),
            ),
          ),
        ),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: colorScheme(context).secondary,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset(AppImages.userImage)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            softWrap: true,
                            messages[index],
                            style: textTheme(context).bodyLarge?.copyWith(
                                overflow: TextOverflow.visible,
                                color: colorScheme(context).surface),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(
            color: colorScheme(context).onSurface.withOpacity(0.4),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _controller,
                  hint: "Enter message...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: colorScheme(context).secondary,
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sendMessage();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showRefundDialog(BuildContext context) {
  final size = MediaQuery.of(context).size;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          width: size.width * 0.9,
          height: size.height * 0.65,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'What You Want to Refund?',
                    style: textTheme(context).titleMedium?.copyWith(
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Text(
                'Items',
                style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              RefundItems(),
              Divider(
                color: colorScheme(context).onSurface.withOpacity(0.6),
              ),
              SizedBox(
                height: 10,
              ),
              RefundSummary(),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.35,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).surface,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cancel',
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).secondary,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).secondary,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).surface,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Item will be refunded"),
                          backgroundColor: colorScheme(context).secondary,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).secondary,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Refund Item',
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: colorScheme(context).surface,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).primary,
                              size: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
