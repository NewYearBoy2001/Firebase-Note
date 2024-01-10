import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_easy/src/ui/bloc/home/note_bloc.dart';


class NoteScreenBlocProvider extends StatelessWidget {
  final Widget child;

  NoteScreenBlocProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(),
      child: child,
    );
  }
}

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);

    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    void addNote() async {
      final String title = titleController.text.trim();
      final String content = contentController.text.trim();

      if (title.isNotEmpty && content.isNotEmpty) {
        try {
          await FirebaseFirestore.instance.collection('notes').add({
            'title': title,
            'content': content,
            'timestamp': FieldValue.serverTimestamp(),
          });

          titleController.clear();
          contentController.clear();

        } catch (error) {
          print("Error adding note: $error");
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please provide both title and content for the note.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addNote,
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
