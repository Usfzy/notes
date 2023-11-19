import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_error_widget.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/features/home/controller/notes_controller.dart';
import 'package:skeleton_app/features/home/views/dialog/add_notes_dialog.dart';
import 'package:skeleton_app/features/home/views/widgets/notes_list_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    _getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Notes',
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getAllNotesNotifierProvider);

          return state.when(
            data: (notes) {
              if (notes == null || notes.isEmpty) {
                return const Center(child: Text('No notes found'));
              }

              return NotesListWidget(notes: notes);
            },
            error: (error, stackTrace) =>
                CustomErrorWidget(error: error.toString()),
            loading: () => const CustomProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onFabPressed() async{
    final result =await showAddNoteDialog(context: context);
    if (result == null) return;

    _getAllNotes();
  }

  void _getAllNotes() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getAllNotesNotifierProvider.notifier).getAllNotes();
    });
  }
}
