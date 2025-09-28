import 'dart:io';

import 'package:SMART/shared/components/components.dart';
import 'package:SMART/shared/localization/app_localization.dart';
import 'package:SMART/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final XFile? initialImage;
  final Function(XFile?) onImageSelected;

  const ProfileImagePicker({
    super.key,
    this.initialImage,
    required this.onImageSelected,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  XFile? image;

  @override
  void initState() {
    super.initState();
    image = widget.initialImage;
  }

  Future<void> imagePicker(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      widget.onImageSelected(image);
    }
  }

  Future<void> showBottomSheetImage(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 150,
        width: double.infinity,
        child: Column(
          children: [
            DefaultText(
              text: 'Profile_Picture'.tr(context),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    imagePicker(ImageSource.camera);
                  },
                  icon: const Icon(Icons.add_a_photo_outlined),
                  color: secondaryColor,
                  size: 70,
                ),
                const SizedBox(width: 40),
                DefaultIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    imagePicker(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  color: secondaryColor,
                  size: 70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment(0, 6),
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: BorderRadiusGeometry.vertical(
                  bottom: Radius.circular(300),
                ),
              ),
            ),
            Container(height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(100),
                border: Border.all(width: 3, color: secondaryColor),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image == null
                      ? AssetImage('assets/images/1.jpg')as ImageProvider
                      : FileImage(File(image!.path)),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment(.3, 0),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Builder(
              builder: (context) {
                return DefaultIconButton(
                  onPressed: () {
                    setState(() {
                    showBottomSheetImage(context,);
                    });
                  },
                  icon: Icon(Icons.add_a_photo_outlined),
                  color: Colors.white,
                  size: 16,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
