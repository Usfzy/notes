import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';
import 'package:skeleton_app/features/home/data/repositories/notes_repository.dart';

final getNotesController = Provider<NotesController>(
  (ref) => NotesController(
    ref.read(notesRepositoryProvider),
  ),
);

class NotesController extends StateNotifier<AsyncValue> {
  final NotesRepository notesRepository;
  NotesController(this.notesRepository) : super(const AsyncData(null));
}

final getAllNotesProvider = FutureProvider<List<Note>>(
  (ref) {
    return ref.read(notesRepositoryProvider).getAllNotes();
  },
);
