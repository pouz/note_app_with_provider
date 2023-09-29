import 'package:flutter/material.dart';
import 'package:note_app/features/store/store.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/note_editor_screen/note_editor_screen.dart';
import 'package:note_app/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  final NoteStore _noteStore = NoteStore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int colorId = widget.note.colorId!.toInt();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text(
            widget.note.noteTitle!,
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 4.0),
          Text(
            widget.note.creationDate!,
            style: AppStyle.dateTitle,
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.note.noteContent!,
            style: AppStyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // to edit
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NoteEditorScreen(
                    note: widget.note,
                  );
                }),
              );
            },
            backgroundColor: AppStyle.accentColor,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(width: 12),
          // to delete
          FloatingActionButton(
            onPressed: () {
              _noteStore
                  .delete(widget.note)
                  .then((value) => Navigator.pop(context));
            },
            backgroundColor: AppStyle.accentColor,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
