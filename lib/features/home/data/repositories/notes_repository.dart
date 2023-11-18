import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';
import 'package:skeleton_app/features/home/data/service/notes_service.dart';

final notesRepositoryProvider = Provider<NotesRepository>(
  (ref) => NotesRepository(ref.read(notesServiceProvider)),
);

class NotesRepository {
  final NotesService notesService;
  const NotesRepository(this.notesService);

  Future<List<Note>> getAllNotes() async {

    // final response = await notesService.getAllNotes();
    // if (response.isSuccessful) return response.body!;

    // throw ServerException(message: response.error);

    return [
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
      Note(
          id: "1",
          title: 'Note',
          note: 'this is a note',
          date: DateTime.now().toString()),
    ];
  }
}
