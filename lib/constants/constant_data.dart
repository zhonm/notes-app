import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<String> noteCategories = ["All", "Important", "Favourite", "ToDo"];

List<Color> noteColors = [
  const Color(0xFFff9f43),
  const Color(0xFF8e44ad),
  const Color(0xFF22a6b3),
  const Color(0xFFf9ca24),
  const Color(0xFF6ab04c),
  const Color(0xFF30336b),
  const Color(0xFFeb4d4b),
  const Color(0xFF5352ed),
];

class NoteItem {
  NoteItem({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.category,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  String? id;
  String title;
  String content;
  Color color;
  String category;
  DateTime updatedAt;

  factory NoteItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing note data for ${doc.id}');
    }

    final Timestamp? timestamp = data['updatedAt'] as Timestamp?;
    return NoteItem(
      id: doc.id,
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? '',
      color: Color((data['color'] as int?) ?? noteColors.first.toARGB32()),
      category: data['category'] as String? ?? noteCategories.first,
      updatedAt: timestamp?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'color': color.toARGB32(),
      'category': category,
      'updatedAt': updatedAt,
    };
  }
}

List<NoteItem> noteList = [
  NoteItem(
    title: "Welcome to the modern Notes experience",
    content:
        "This app now uses a responsive card grid, search and category chips, and a smoother mobile/web layout. Tap the + button to create a new note.",
    color: noteColors[2],
    category: noteCategories[0],
  ),
];
