import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/models/common_model.dart';

Widget customPopupItemSelect(
    BuildContext context, OptionsModel item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: ListTile(
      selected: isSelected,
      title: Text(
        item.label,
        style: TextStyle(color: isSelected ? mainColor : textColor),
      ),
    ),
  );
}
