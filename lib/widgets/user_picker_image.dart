import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserPickerImage extends StatefulWidget {

      UserPickerImage(this.imagePickFn);

     final void Function(File pickedImage) imagePickFn;


  @override
  State<UserPickerImage> createState() => _UserPickerImageState();
}

class _UserPickerImageState extends State<UserPickerImage> {


  
    File? _pickedImage;
    void _pickImage() async{
      final XFile?  imageFile= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);
      final imageFileFinal=File(imageFile!.path);
      setState(() {
        _pickedImage = imageFileFinal;
      });
      widget.imagePickFn(_pickedImage!);
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 40,backgroundColor: Colors.grey, backgroundImage: _pickedImage !=null? FileImage(_pickedImage!):null),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
