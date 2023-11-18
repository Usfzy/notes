import 'package:flutter/material.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';
import 'package:skeleton_app/features/home/views/widgets/note_item_widget.dart';

class NotesListWidget extends StatelessWidget {
  final List<Note> notes;
  const NotesListWidget({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteItemWidget(note: notes[index]);
      },
    );
  }
}
