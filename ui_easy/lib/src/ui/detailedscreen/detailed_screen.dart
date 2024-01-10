import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot note;

  const NoteDetailsScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    var timestamp = (note['timestamp'] as Timestamp).toDate();

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(note['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  border: const Border(right: BorderSide(color: Colors.white30)),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.shade300,
                        spreadRadius: 5,
                        offset: Offset(1, 1)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note['content'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Created on: ${DateFormat('MMM dd, yyyy - hh:mm a').format(timestamp)}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
