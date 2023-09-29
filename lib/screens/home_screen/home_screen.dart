import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/features/login/firebase/firebase_login.dart';
import 'package:note_app/features/store/firebase/note_firebase_store.dart';
import 'package:note_app/features/store/store.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/screens/login_screen/login_screen.dart';
import 'package:note_app/screens/note_editor_screen/note_editor_screen.dart';
import 'package:note_app/screens/note_reader_screen/note_reader_screen.dart';
import 'package:note_app/style/app_style.dart';
import 'package:note_app/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "FireNotes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: AppStyle.mainDesc,
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _noteCards(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteEditorScreen(),
            ),
          );
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _logout() {
    switch (kStore) {
      case Stores.firebase:
        return _firebaseLogout();
      case Stores.appwrite:
        return Container();
      case Stores.sharedPreferences:
        return Container();
      default:
        return Container();
    }
  }

  Widget _firebaseLogout() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        FirebaseLogin.signOut().then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
        );
      },
      child: CircleAvatar(
        radius: 20.0,
        foregroundImage: NetworkImage(
          FirebaseLogin.user!.photoURL!,
        ),
      ),
    );
  }

  Widget _noteCards() {
    switch (kStore) {
      case Stores.firebase:
        return _notesFirebaseStreamBuilder();
      case Stores.appwrite:
        return Container();
      case Stores.sharedPreferences:
        return Container();
      default:
        return Container();
    }
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      _notesFirebaseStreamBuilder() {
    return StreamBuilder(
      stream: NoteFirebaseStore().snapshot,
      builder: (context, snapshot) {
        // checking the connection state, if we still load the data we can display a progress
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: snapshot.data!.docs
                .map(
                  (note) => noteCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return NoteReaderScreen(
                            note: Note.fromFirestore(
                              note,
                              SnapshotOptions(),
                            ),
                          );
                        }),
                      );
                    },
                    doc: note,
                  ),
                )
                .toList(),
          );
        }

        return Text(
          'there is no Notes',
          style: AppStyle.mainWarn,
        );
      },
    );
  }
}
