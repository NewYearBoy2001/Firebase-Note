import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_easy/src/ui/bloc/home/note_bloc.dart';
import 'package:ui_easy/src/ui/detailedscreen/detailed_screen.dart';
import 'package:ui_easy/src/ui/home/editnote_screen.dart';
import 'package:ui_easy/src/ui/home/note_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Home Page"),
      ),
      drawer: Drawer(
        
        child: DrawerWidget(user: user),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var notes = snapshot.data!.docs;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(25),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var note = notes[index];
              var timestamp = (note['timestamp'] as Timestamp).toDate();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: const Border(right: BorderSide(color: Colors.white30)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade300,
                          spreadRadius: 2,
                          offset: Offset(1, 1)
                      ),
                    ],
                  ),

                  child: ListTile(
                    title: Text(note['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note['content']),
                        Text(
                          'Created on: ${DateFormat('MMM dd, yyyy - hh:mm a').format(timestamp)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNoteScreen(note: note),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Show a confirmation dialog before deleting
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this note?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close the dialog
                                      },
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Delete the note
                                        FirebaseFirestore.instance.collection('notes').doc(note.id).delete();
                                        Navigator.pop(context); // Close the dialog
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to the details screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteDetailsScreen(note: note),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteScreen()),
          );
        },
        child: const Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(

          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.photoURL ?? "https://via.placeholder.com/150",
                  ),
                  radius: 40.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: Text(
                  user.displayName ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  user.email ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Sign Out'),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context); // Close the drawer
          },
        ),
      ],
    );
  }
}
