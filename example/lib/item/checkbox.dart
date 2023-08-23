import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class ItemCheckbox extends StatefulWidget {
  const ItemCheckbox({super.key});

  @override
  State<ItemCheckbox> createState() => _ItemCheckboxState();
}

class _ItemCheckboxState extends State<ItemCheckbox> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];
  String? singleSelected;
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return CheckboxListTile(
            value: state.selected(choices[i]),
            onChanged: state.onSelected(choices[i]),
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
