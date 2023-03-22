import 'package:flutter/material.dart';
import 'package:spacetube/provider/search_provider.dart';
import 'package:provider/provider.dart';

class InputChipsWidget extends StatefulWidget {
  @override
  _InputChipsWidgetState createState() => _InputChipsWidgetState();
}

class _InputChipsWidgetState extends State<InputChipsWidget> {
  List<String> _selectedTypes = ["Image"];

  @override
  Widget build(BuildContext context) {
    final userSearchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    return Wrap(
      spacing: 6.0,
      children: [
        InputChip(
          backgroundColor: const Color(0xffefe9f5),
          selectedColor: Color.fromARGB(120, 109, 68, 255),
          label: Text('Image'),
          selected: userSearchProvider.selectedTypes.contains('image'),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                userSearchProvider.addSelectedType('image');
                _selectedTypes.add('Image');
              } else if (_selectedTypes.length > 1) {
                _selectedTypes.remove('Image');
                userSearchProvider.removeSelectedType('image');
              }
            });
          },
        ),
        InputChip(
          label: Text('Video'),
          backgroundColor: const Color(0xffefe9f5),
          selectedColor: Color.fromARGB(120, 109, 68, 255),
          selected: userSearchProvider.selectedTypes.contains('video'),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                userSearchProvider.addSelectedType('video');
                _selectedTypes.add('Video');
              } else if (_selectedTypes.length > 1) {
                _selectedTypes.remove('Video');
                userSearchProvider.removeSelectedType('video');
              }
            });
          },
        ),
        InputChip(
          label: Text('Audio'),
          backgroundColor: const Color(0xffefe9f5),
          selectedColor: Color.fromARGB(120, 109, 68, 255),
          selected: userSearchProvider.selectedTypes.contains('audio'),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                userSearchProvider.addSelectedType('audio');
                _selectedTypes.add('Audio');
              } else if (_selectedTypes.length > 1) {
                _selectedTypes.remove('Audio');
                userSearchProvider.removeSelectedType('audio');
              }
            });
          },
        ),
      ],
    );
  }
}
