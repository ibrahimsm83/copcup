import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperService {
  Future<File?> cropImage({
    required BuildContext context,
    required File imageFile,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
          toolbarTitle: 'Cropper',
          toolbarColor: Theme.of(context).colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          // aspectRatioPresets: [
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.square,
          // ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          // aspectRatioPresets: [
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.square,
          // ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
