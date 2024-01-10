import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_easy/src/ui/bloc/home/note_event.dart';
import 'package:ui_easy/src/ui/bloc/home/note_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NotesBloc() : super(NotesLoadingState());

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    try {
      if (event is LoadNotesEvent) {
        emit(NotesLoadingState());
        List<DocumentSnapshot> notes = await _loadNotes();
        emit(NotesLoadedState(notes: notes));
      } else if (event is AddNoteEvent) {
        await _addNote(event.title, event.content);
        add(LoadNotesEvent());
      } else if (event is EditNoteEvent) {
        await _editNote(event.noteId, event.title, event.content);
        add(LoadNotesEvent());
      } else if (event is DeleteNoteEvent) {
        await _deleteNote(event.noteId);
        add(LoadNotesEvent());
      }
    } catch (e) {
      emit(NotesErrorState(error: e.toString()));
    }
  }

  Future<List<DocumentSnapshot>> _loadNotes() async {
    QuerySnapshot snapshot = await _firestore.collection('notes').get();
    return snapshot.docs;
  }

  Future<void> _addNote(String title, String content) async {
    await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _editNote(String noteId, String title, String content) async {
    await _firestore.collection('notes').doc(noteId).update({
      'title': title,
      'content': content,
    });
  }

  Future<void> _deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
