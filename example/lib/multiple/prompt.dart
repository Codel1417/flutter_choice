import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class MultiplePrompted extends StatefulWidget {
  const MultiplePrompted({super.key});

  @override
  State<MultiplePrompted> createState() => _MultiplePromptedState();
}

class _MultiplePromptedState extends State<MultiplePrompted> {
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

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .7,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemSkip: (q, i) => !ChoiceSearch.match(choices[i], q),
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModalHeader.createBuilder(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceConfirmButton.createBuilder(),
              ChoiceModal.createBuilder(
                child: const SizedBox(width: 20),
              ),
            ],
          ),
          modalFooterBuilder: (state) {
            return Container(
              color: Colors.white,
              child: CheckboxListTile(
                value: state.selectedMany(choices),
                onChanged: state.onSelectedMany(choices),
                tristate: true,
                title: const Text('Select All'),
              ),
            );
          },
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
        ),
      ),
    );
  }
}
