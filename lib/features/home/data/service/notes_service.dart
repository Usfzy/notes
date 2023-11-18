import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/service/chopper_service.dart';

part 'notes_service.chopper.dart';

final notesServiceProvider = Provider<NotesService>(
  (ref) => NotesService.create(chopperClient),
);

@ChopperApi()
abstract class NotesService extends ChopperService {
  static NotesService create([ChopperClient? client]) {
    return _$NotesService(client);
  }


  //   @Get(path: '/notes/verify')
  // Future<Response<NotesResponse>> getAllNotes();

}
