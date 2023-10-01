import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/features/store/firebase/note_firebase_store.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/store_provider.dart';

const Stores kStore = Stores.firebase;

abstract interface class StoreInterface<T extends Object?> {
  // CRUD
  Future<void> add(T model);
  Future<void> update(T model);
  Future<void> delete(T model);
}

enum Stores {
  firebase,
  appwrite,
  sharedPreferences,
}

class NoteStore extends ChangeNotifier implements StoreInterface<Note> {
//  late final Provider<StoreInterface> _ref;
  late final NoteFirebaseStore _storeProvider;
  late final Ref ref;

  // 'ref' has to be passed by argument
  NoteStore(this.ref) {
    switch (kStore) {
      case Stores.firebase:
        _storeProvider = ref.read(noteFirebaseProvider);
        break;
      case Stores.appwrite:
        break;
      case Stores.sharedPreferences:
        break;
      default:
    }
  }

  @override
  Future<void> add(Note model) async {
    return _storeProvider.add(model);
  }

  @override
  Future<void> delete(Note model) async {
    return _storeProvider.delete(model);
  }

  @override
  Future<void> update(Note model) async {
    return _storeProvider.update(model);
  }
}
