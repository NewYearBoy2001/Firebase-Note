import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final String title;
  final String content;

  AddNoteEvent({required this.title, required this.content});
}

class EditNoteEvent extends NotesEvent {
  final String noteId;
  final String title;
  final String content;

  EditNoteEvent({required this.noteId, required this.title, required this.content});
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;

  DeleteNoteEvent({required this.noteId});
}
