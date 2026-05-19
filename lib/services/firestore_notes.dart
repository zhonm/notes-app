import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constant_data.dart';

class FirestoreNotes {
  static final CollectionReference<NoteItem> _notesCollection =
      FirebaseFirestore.instance.collection('notes').withConverter(
            fromFirestore: (snapshot, _) => NoteItem.fromFirestore(snapshot),
            toFirestore: (note, _) => note.toMap(),
          );

  static Stream<List<NoteItem>> notesStream() {
    return _notesCollection
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static Future<void> addNote(NoteItem note) async {
    final newNote = NoteItem(
      title: note.title,
      content: note.content,
      color: note.color,
      category: note.category,
      updatedAt: DateTime.now(),
    );
    await _notesCollection.add(newNote);
  }

  static Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }

  static Future<void> updateNote(NoteItem note) async {
    if (note.id == null) return;
    await _notesCollection.doc(note.id).set(note);
  }
}
