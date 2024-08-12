import 'package:flutter/material.dart';
import 'package:mynotes/core/tags_generator.dart';

class NoteTagSelector extends StatefulWidget {
  final List<String> initialSelectedTags;
  final ValueChanged<List<String>> onTagsChanged;

  const NoteTagSelector({
    super.key,
    required this.initialSelectedTags,
    required this.onTagsChanged,
  });

  @override
  NoteTagSelectorState createState() => NoteTagSelectorState();
}

class NoteTagSelectorState extends State<NoteTagSelector> {
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List<String>.from(widget.initialSelectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tags",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: tagGenerator.map((tag) {
            return ChoiceChip(
              label: Text(tag),
              selected: _selectedTags.contains(tag),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
                widget.onTagsChanged(_selectedTags);
              },
              selectedColor: Colors.teal,
              backgroundColor: Colors.grey[200],
            );
          }).toList(),
        ),
      ],
    );
  }
}
