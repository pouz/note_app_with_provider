import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/features/store/store.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/store_provider.dart';
import 'package:note_app/route.dart';
import 'package:note_app/style/app_style.dart';
import 'package:uuid/uuid.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  const NoteEditorScreen({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late final NoteStore _noteStoreProvider;

  int colorId = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  bool _isUpdate = false;

  late TextEditingController _titleController;
  late TextEditingController _mainController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _mainController = TextEditingController();

    if (widget.note != null) {
      _titleController.text = widget.note!.noteTitle as String;
      _mainController.text = widget.note!.noteContent as String;
      // go_router의 extra로 빈 note가 넘어오기에 update 체크가 되어버림
      //_isUpdate = true;
      _isUpdate = true;
    }

    _noteStoreProvider = ref.read(noteStoreProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        title: const Text('Add a new Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 8.0),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainTitle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Note newNote = Note(
            uid: _isUpdate ? widget.note!.uid : const Uuid().v4(),
            noteTitle: _titleController.text,
            creationDate: date,
            noteContent: _mainController.text,
            colorId: _isUpdate ? widget.note!.colorId : colorId,
          );

          Future<void> save = _isUpdate
              ? _noteStoreProvider.update(newNote)
              : _noteStoreProvider.add(newNote);
          save.then((value) => AppRoute.router.go('/'));
        },
        backgroundColor: AppStyle.accentColor,
        child: const Icon(Icons.save),
      ),
    );
  }
}
