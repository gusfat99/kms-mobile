import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/models/common_model.dart';
import 'package:kms_bpkp_mobile/wigets/custom_dropdown_multi_select.dart';
import 'package:kms_bpkp_mobile/wigets/custom_popup_item_select.dart';
import 'package:flutter/src/widgets/text.dart' as text;

class CustomDropdownMultipleSearch extends StatelessWidget {
  final List<OptionsModel> options;
  final List<OptionsModel> selectedItems;
  final void Function(List<OptionsModel> data) onChanged;
  final String label;

  const CustomDropdownMultipleSearch(
      {super.key,
      required this.label,
      required this.options,
      required this.onChanged,
      required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text.Text(label),
        DropdownSearch<OptionsModel>.multiSelection(
          items: options,
          dropdownBuilder: customDropdownMultiSelect,
          onChanged: onChanged,
          compareFn: (item, selectedItem) => item.value == selectedItem.value,
          popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true,
            showSelectedItems: true,
            itemBuilder: customPopupItemSelect,
          ),
          dropdownButtonProps: const DropdownButtonProps(color: mainColor),
          selectedItems: selectedItems,
        ),
      ],
    );
  }
}
