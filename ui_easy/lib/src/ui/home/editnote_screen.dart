import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_easy/src/ui/bloc/home/note_bloc.dart';


class EditNoteScreenBlocProvider extends StatelessWidget {
  final Widget child;
  final DocumentSnapshot note;

  EditNoteScreenBlocProvider({required this.child, required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(),
      child: child,
    );
  }
}

class EditNoteScreen extends StatefulWidget {
  final DocumentSnapshot note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    // If the generic type is not known, use Map<String, dynamic>
    final data = widget.note.data() as Map<String, dynamic>;
    titleController = TextEditingController(text: data['title']);
    contentController = TextEditingController(text: data['content']);
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Update the note
                FirebaseFirestore.instance.collection('notes').doc(widget.note.id).update({
                  'title': titleController.text,
                  'content': contentController.text,
                });

                Navigator.pop(context); // Close the edit screen
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
