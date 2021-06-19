import 'dart:io';

import 'package:aim_common/common.dart';
import 'package:aim/presentation_constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ATImageInput extends FormField<File> {
  final String labelText;
  final bool isRequired;
  final String? existingNetworkFile;
  final Function(File? value)? onChange;

  ATImageInput({
    Key? key,
    this.labelText = "",
    this.isRequired = false,
    this.existingNetworkFile,
    this.onChange,
  }) : super(
          key: key,
          builder: (FormFieldState<File> state) => ATCustomImageInput(
            labelText: labelText,
            isRequired: isRequired,
            existingNetworkFile: existingNetworkFile,
            onChange: onChange,
            state: state,
          ),
          validator: (File? file) {
            if (isRequired && file == null) {
              return "$labelText is required.";
            }
            return null;
          },
        );
}

class ATCustomImageInput extends StatefulWidget {
  final String labelText;
  final bool isRequired;
  final String? existingNetworkFile;
  final Function(File? value)? onChange;

  final FormFieldState<File> state;

  const ATCustomImageInput({
    Key? key,
    this.labelText = "",
    this.isRequired = false,
    this.existingNetworkFile,
    this.onChange,
    required this.state,
  }) : super(key: key);

  @override
  _ATCustomImageInputState createState() => _ATCustomImageInputState();
}

class _ATCustomImageInputState extends State<ATCustomImageInput> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  String? _existingImageNetworkPath;

  @override
  void initState() {
    _existingImageNetworkPath = widget.existingNetworkFile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: widget.state.hasError ? Colors.red : Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Builder(builder: (_) {
            if (_image != null || _existingImageNetworkPath != null) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _image = null;
                      _existingImageNetworkPath = null;
                      widget.onChange!(null);
                      widget.state.setValue(null);
                    }),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AIMColors.primaryColor_700),
                    ),
                    child: Text("Remove ${widget.labelText}"),
                  ),
                  Spacer(),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _image != null
                            ? FileImage(_image!)
                            // todo use fadeinimage
                            : NetworkImage(ApplicationHelper.getFullNetworkFilePath(widget.existingNetworkFile!)) as ImageProvider,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 4)),
                        BoxShadow(blurRadius: 0.5, color: Colors.grey, offset: Offset(0, 0)),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () => getImage(ImageSource.gallery),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AIMColors.secondaryColor_700),
                    ),
                    child: Text("Upload ${widget.labelText}"),
                  ),
                  SizedBox(width: 50),
                  GestureDetector(
                    onTap: () => getImage(ImageSource.gallery),
                    child: Icon(Icons.image, size: 35, color: Colors.grey.shade700),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => getImage(ImageSource.camera),
                    child: Icon(Icons.camera_alt, size: 35, color: Colors.grey.shade700),
                  ),
                ],
              );
            }
          }),
        ),
        Container(
          child: widget.state.hasError
              ? Column(
                  children: [
                    SizedBox(height: 7),
                    Text(widget.state.errorText ?? "", style: TextStyle(fontSize: 12.5, color: Colors.red)),
                  ],
                )
              : null,
        )
      ],
    );
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
    if (widget.onChange != null) {
      widget.onChange!(_image);
      widget.state.setValue(_image);
    }
  }
}
