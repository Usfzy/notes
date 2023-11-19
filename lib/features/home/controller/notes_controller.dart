import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';
import 'package:skeleton_app/features/home/data/repositories/notes_repository.dart';

final getAllNotesNotifierProvider =
    StateNotifierProvider<GetNotesController, AsyncValue>(
  (ref) => GetNotesController(
    ref.read(notesRepositoryProvider),
  ),
);

class GetNotesController extends StateNotifier<AsyncValue> {
  final NotesRepository notesRepository;
  GetNotesController(this.notesRepository) : super(const AsyncData(null));

  Future<void> getAllNotes() async {
    state = const AsyncLoading();
    final result = await notesRepository.getAllNotes();
    state = AsyncData(result);
  }
}

final addNotesNotifierProvider =
    StateNotifierProvider<AddNotesController, AsyncValue>(
  (ref) => AddNotesController(
    ref.read(notesRepositoryProvider),
  ),
);

class AddNotesController extends StateNotifier<AsyncValue> {
  final NotesRepository notesRepository;
  AddNotesController(this.notesRepository) : super(const AsyncData(null));

  Future<void> addNote(Note note) async {
    state = const AsyncLoading();
    await notesRepository.addNote(note);
    state = const AsyncData(null);
  }
}

final updateNotesNotifierProvider =
    StateNotifierProvider<UpdateNotesController, AsyncValue>(
  (ref) => UpdateNotesController(
    ref.read(notesRepositoryProvider),
  ),
);

class UpdateNotesController extends StateNotifier<AsyncValue> {
  final NotesRepository notesRepository;
  UpdateNotesController(this.notesRepository) : super(const AsyncData(null));

  Future<void> updateNote(Note note) async {
    state = const AsyncLoading();
    await notesRepository.updateNote(note);
    state = const AsyncData(null);
  }
}

final deleteNotesNotifierProvider =
    StateNotifierProvider<DeleteNotesController, AsyncValue>(
  (ref) => DeleteNotesController(
    ref.read(notesRepositoryProvider),
  ),
);

class DeleteNotesController extends StateNotifier<AsyncValue> {
  final NotesRepository notesRepository;
  DeleteNotesController(this.notesRepository) : super(const AsyncData(null));

  Future<void> deleteNote(String noteId) async {
    state = const AsyncLoading();
    await notesRepository.deleteNote(noteId);
    state = const AsyncData(null);
  }
}

final getAllNotesProvider = FutureProvider<List<Note>>(
  (ref) {
    return ref.read(notesRepositoryProvider).getAllNotes();
  },
);
