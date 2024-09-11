import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kms_bpkp_mobile/helpers/my_validation_locale.dart';
import 'package:kms_bpkp_mobile/helpers/space.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  final String hint;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    this.maxLines = 1,
    this.validator,
    required this.label,
    required this.text,
    required this.onChanged,
    required bool readonly,
    this.hint = '',
  });

  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style:
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
        const Space(4),
        TextFormField(
          controller: controller,
          validator: widget.validator,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: const BorderSide(
                width: 0.3, color: Color.fromARGB(255, 35, 35, 35)),
          )),
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
        ),
        if (widget.hint.isNotEmpty)
          Text(
            widget.hint,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
      ],
    );
  }
}
