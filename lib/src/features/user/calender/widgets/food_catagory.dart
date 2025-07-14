import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class FoodCategoryIcon extends StatelessWidget {
  final String label;
  final String imageurl;
  final VoidCallback ontap;
  const FoodCategoryIcon(
      {required this.label, required this.imageurl, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            // padding: EdgeInsets.all(1),
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme(context).onSurface.withOpacity(0.3),
              ),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
