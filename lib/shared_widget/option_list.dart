import 'package:adeo_app/shared_widget/select_option.dart';
import 'package:adeo_app/views/level_preference.screen.dart';
import 'package:flutter/material.dart';

class CustomOptionList extends StatefulWidget {
  final dynamic selectedValue;
  final List<dynamic> list;
  final dynamic itemValue;
  final dynamic itemLabel;
  final Function(dynamic) onChanged;

  const CustomOptionList({
    Key key,
    @required this.list,
    @required this.itemValue,
    @required this.itemLabel,
    this.onChanged,
    @required this.selectedValue,
  }) : super(key: key);

  @override
  _CustomOptionListState createState() => _CustomOptionListState();
}

class _CustomOptionListState extends State<CustomOptionList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = ListView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          var label = widget.list[index][widget.itemLabel];
          var value = widget.list[index][widget.itemValue];
          return OptionSelect(
            text: label,
            isSelected: widget.selectedValue == value,
            onPressed: () => widget.onChanged(value),
          );
        });

    return options;
  }
}
