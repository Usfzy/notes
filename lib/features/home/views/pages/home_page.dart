import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_error_widget.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/features/home/controller/notes_controller.dart';
import 'package:skeleton_app/features/home/views/widgets/notes_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Notes',
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(getAllNotesProvider);
          return state.when(
            data: (notes) {
              if (notes.isEmpty) return const Text('No notes found');

              return NotesListWidget(notes: notes);
            },
            error: (error, stackTrace) =>
                CustomErrorWidget(error: error.toString()),
            loading: () => const CustomProgressIndicator(),
          );
        },
      ),
    );
  }
}
