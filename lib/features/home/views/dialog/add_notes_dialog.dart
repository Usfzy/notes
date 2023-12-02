import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton_app/core/utils/extensions.dart';
import 'package:skeleton_app/core/widgets/custom_button.dart';
import 'package:skeleton_app/core/widgets/custom_text_field.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';
import 'package:skeleton_app/features/home/data/models/product.dart';

Future<bool?> showAddNoteDialog(
    {required BuildContext context, Product? note}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(note == null ? 'Add Product' : 'Update Product'),
      content:
          SizedBox(width: double.maxFinite, child: AddNotesDialog(note: note)),
    ),
  );
}

class AddNotesDialog extends ConsumerStatefulWidget {
  final Product? note;
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
      noteController.text = widget.note!.description;
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
            hintText: 'Product',
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
            ],
          )
        ],
      ),
    );
  }
}
