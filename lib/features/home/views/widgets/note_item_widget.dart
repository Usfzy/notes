import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/features/home/controller/notes_controller.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';
import 'package:skeleton_app/features/home/views/dialog/add_notes_dialog.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  const NoteItemWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title),
              Text(note.note),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer(builder: (_, ref, __) {
                    final state = ref.read(updateNotesNotifierProvider);

                    return state.when(
                      data: (data) {
                        return updateIconButton(context, ref, note);
                      },
                      error: (error, stackTrace) =>
                          updateIconButton(context, ref, note),
                      loading: () => const CustomProgressIndicator(),
                    );
                  }),
                  Consumer(builder: (_, ref, __) {
                    final state = ref.watch(deleteNotesNotifierProvider);

                    return state.when(
                      data: (data) {
                        return deleteIconButton(ref, '1');
                      },
                      error: (error, stackTrace) => deleteIconButton(ref, '1'),
                      loading: () => const CustomProgressIndicator(),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton deleteIconButton(WidgetRef ref, String noteId) {
    return IconButton(
      onPressed: () {
        ref.read(deleteNotesNotifierProvider.notifier).deleteNote(noteId);
        ref.read(getAllNotesNotifierProvider.notifier).getAllNotes();
      },
      icon: const Icon(Icons.delete),
    );
  }

  IconButton updateIconButton(BuildContext context, WidgetRef ref, Note note) {
    return IconButton(
      onPressed: () async {
        final result = await showAddNoteDialog(context: context, note: note);
        if (result == null) return;

        ref.read(getAllNotesNotifierProvider.notifier).getAllNotes();
      },
      icon: const Icon(Icons.edit),
    );
  }
}
