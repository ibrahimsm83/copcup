import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

customAlertDialog({
  required BuildContext context,
  required String content,
  required Function()? onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Alert!',
            style: textTheme(context).titleLarge?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600),
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: textTheme(context).bodySmall?.copyWith(
              color: colorScheme(context).onSurface,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme(context).secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Done',
                        style: textTheme(context).bodySmall?.copyWith(
                            color: colorScheme(context).surface,
                            fontWeight: FontWeight.w600),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: colorScheme(context).surface,
                        child: Icon(
                          Icons.arrow_forward,
                          color: colorScheme(context).secondary,
                          size: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
