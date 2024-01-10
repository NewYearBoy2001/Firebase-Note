import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<DocumentSnapshot> notes;

  NotesLoadedState({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class NotesErrorState extends NotesState {
  final String error;

  NotesErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
