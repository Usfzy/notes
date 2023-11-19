import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/utils/extensions.dart';
import 'package:skeleton_app/core/widgets/custom_button.dart';
import 'package:skeleton_app/core/widgets/custom_progress_indicator.dart';
import 'package:skeleton_app/core/widgets/custom_snackbar.dart';
import 'package:skeleton_app/core/widgets/custom_text_field.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';
import 'package:skeleton_app/features/home/controller/notes_controller.dart';
import 'package:skeleton_app/features/home/data/models/note.dart';

Future<bool?> showAddNoteDialog(
    {required BuildContext context, Note? note}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(note == null ? 'Add Note' : 'Update Note'),
      content:
          SizedBox(width: double.maxFinite, child: AddNotesDialog(note: note)),
    ),
  );
}

class AddNotesDialog extends ConsumerStatefulWidget {
  final Note? note;
  const AddNotesDialog({Key? key, this.note}) : super(key: key);

  @override
  ConsumerState<AddNotesDialog> createState() => _AddNotesDialogState();
}

class _AddNotesDialogState extends ConsumerState<AddNotesDialog> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      noteController.text = widget.note!.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: titleController,
            hintText: 'Title',
          ),
          vSpace(),
          CustomTextField(
            controller: noteController,
            hintText: 'Note',
          ),
          vSpace(24),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => context.pop(false),
                  ),
                ),
              ),
              vSpace(16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Consumer(builder: (_, ref, __) {
                    final AsyncValue state;

                    if (widget.note == null) {
                      state = ref.watch(addNotesNotifierProvider);
                      _listenToaddRef(ref);
                    } else {
                      state = ref.watch(updateNotesNotifierProvider);

                      _listenToUpdateRef(ref);
                    }

                    return state.when(
                      data: (data) {
                        return _saveUpdateButton();
                      },
                      error: (error, stackTrace) {
                        return _saveUpdateButton();
                      },
                      loading: () => const CustomProgressIndicator(),
                    );
                  }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _listenToUpdateRef(WidgetRef ref) {
    ref.listen(updateNotesNotifierProvider, (previous, next) {
      next.when(
        data: (data) {
          context.pop(true);
          showCustomSnackBar(
            context,
            'Item updated',
          );
        },
        error: (error, stackTrace) {
          context.pop(false);
          showCustomSnackBar(
            context,
            'Failed to update item',
            isError: true,
          );
        },
        loading: () => null,
      );
    });
  }

  void _listenToaddRef(WidgetRef ref) {
    ref.listen(addNotesNotifierProvider, (previous, next) {
      next.when(
        data: (data) {
          context.pop(true);
          showCustomSnackBar(
            context,
            'Item added',
          );
        },
        error: (error, stackTrace) {
          context.pop(false);
          showCustomSnackBar(
            context,
            'Failed to add item',
            isError: true,
          );
        },
        loading: () => null,
      );
    });
  }

  Widget _saveUpdateButton() {
    return CustomButton(
      text: widget.note == null ? 'Add' : 'Update',
      onPressed: onAddUpdateTap,
    );
  }

  void onAddUpdateTap() async {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text;
      final noteText = noteController.text;

      final note = Note(
        id: '1',
        title: title,
        note: noteText,
        date: DateTime.now().toString(),
      );

      if (widget.note == null) {
        ref.read(addNotesNotifierProvider.notifier).addNote(note);
      } else {
        ref.read(updateNotesNotifierProvider.notifier).updateNote(note);
      }
    }
  }
}
