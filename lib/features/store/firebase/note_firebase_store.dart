import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/features/store/store.dart';
import 'package:note_app/models/note.dart';

class NoteFirebaseStore implements StoreInterface<Note> {
  static final NoteFirebaseStore instance = NoteFirebaseStore._internal();
  factory NoteFirebaseStore() => instance;

  late final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  late final CollectionReference<Map<String, dynamic>> _notesColRef;
  late final User? _user;

  NoteFirebaseStore._internal() {
    _user = FirebaseAuth.instance.currentUser;
    _notesColRef = FirebaseFirestore.instance
        .collection('user')
        .doc(_user!.uid)
        .collection('notes');
    snapshot = _notesColRef.snapshots();
  }

  @override
  Future<void> add(Note model) async {
    return _notesColRef.doc(model.uid).set(model.toFirestore());
  }

  @override
  Future<void> update(Note model) async {
    return _notesColRef.doc(model.uid).update(model.toFirestore());
  }

  @override
  Future<void> delete(Note model) async {
    return _notesColRef.doc(model.uid).delete();
  }
}
