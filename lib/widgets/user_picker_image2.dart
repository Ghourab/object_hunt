import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserPickerImage2 extends StatefulWidget {

      UserPickerImage2(this.imagePickFn,this.url);

     final void Function(File pickedImage) imagePickFn;
      final String url;

  @override
  State<UserPickerImage2> createState() => _UserPickerImage2State(this.url);
}

class _UserPickerImage2State extends State<UserPickerImage2> {
     String url;
    _UserPickerImage2State(this.url);
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
    return Stack(
      children: [
        CircleAvatar(radius: 50,backgroundColor: Colors.grey, backgroundImage: _pickedImage !=null? FileImage(_pickedImage!): NetworkImage(
                          this.url) as ImageProvider),
        
        Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(height: 35,width: 35,
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: IconButton(onPressed:_pickImage ,
                            icon:Icon( Icons.edit),
                            color: Colors.purpleAccent,
                            iconSize: 18,
                            
                          )),
                    ),
      ],
    );
  }
}
