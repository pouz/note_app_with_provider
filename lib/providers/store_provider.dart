import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/features/store/firebase/note_firebase_store.dart';
import 'package:note_app/features/store/store.dart';

final noteFirebaseProvider = Provider<NoteFirebaseStore>((ref) {
  return NoteFirebaseStore();
});

// 'ref' has to be passed by argument
final noteStoreProvider = Provider<NoteStore>((ref) {
  return NoteStore(ref);
});
