// image_picker_dialog.dart
import 'package:flutter/material.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ImagePickerDialog({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text(
        'Choose an Option',
        style: TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.black),
            title: const Text('Open Camera',
                style: TextStyle(color: Colors.black)),
            onTap: onCameraTap,
          ),
          ListTile(
            leading: const Icon(Icons.photo, color: Colors.black),
            title: const Text('Pick from Gallery',
                style: TextStyle(color: Colors.black)),
            onTap: onGalleryTap,
          ),
        ],
      ),
    );
  }
}
