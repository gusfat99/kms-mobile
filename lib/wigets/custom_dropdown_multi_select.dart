import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/models/common_model.dart';

Widget customDropdownMultiSelect(
    BuildContext context, List<OptionsModel> selectedItems) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Text(
      selectedItems.map((option) => option.label).join(', '),
      style: const TextStyle(fontSize: 16),
    ),
  );
}
