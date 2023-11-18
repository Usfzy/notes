import 'package:flutter/material.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  const NoteItemWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.note),
    );
  }
}
