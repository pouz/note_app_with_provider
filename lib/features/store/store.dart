import 'package:note_app/features/store/firebase/note_firebase_store.dart';
import 'package:note_app/models/note.dart';

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

class NoteStore implements StoreInterface<Note> {
  // NoteStore.instance, NoteStore() 이 두가지로 접근 가능
  static final NoteStore instance = NoteStore._internal();
  factory NoteStore() => instance;

  late final StoreInterface _ref;

  // 초기화 코드 사용 가능
  NoteStore._internal() {
    switch (kStore) {
      case Stores.firebase:
        _ref = NoteFirebaseStore.instance;
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
    return _ref.add(model);
  }

  @override
  Future<void> delete(Note model) async {
    return _ref.delete(model);
  }

  @override
  Future<void> update(Note model) async {
    return _ref.update(model);
  }
}
