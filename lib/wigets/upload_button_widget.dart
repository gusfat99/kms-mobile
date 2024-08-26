import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class UploadButtonWidget extends StatefulWidget {
  final String label;
  final Function(File file) onChanged;
  final List<String> allowedExtensions;

  const UploadButtonWidget(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.allowedExtensions});

  @override
  State<UploadButtonWidget> createState() =>
      // ignore: no_logic_in_create_state
      _UploadButtonWidgetState(labelDoc: label);
}

class _UploadButtonWidgetState extends State<UploadButtonWidget> {
  String labelDoc;
  _UploadButtonWidgetState({required this.labelDoc});

  @override
  Widget build(BuildContext context) {
    print(labelDoc);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          widget.label,
          textColor: textColor,
          fontSize: 16.0,
          textAlign: TextAlign.start,
        ),
        10.height,
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: widget.allowedExtensions,
            );

            if (result != null) {
              PlatformFile file = result.files.first;
              // print(file.name);
              setState(() {
                widget.onChanged(File(result.files.single.path.toString()));
                labelDoc = file.name;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shadowColor: Colors.transparent.withOpacity(0),
            side: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.image_outlined, color: Colors.white, size: 20),
              6.width,
              text(
                labelDoc,
                textColor: whiteColor,
                fontSize: 14.0,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.start,
              ).expand(),
            ],
          ),
        ),
        text("* Max 1Mb, Format ${widget.allowedExtensions.join(", ")}",
            fontSize: 14.0),
      ],
    );
  }
}
