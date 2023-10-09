// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? uid;
  final String? noteTitle;
  final String? creationDate;
  final String? noteContent;
  final int? colorId;

  Note({
    this.uid,
    this.noteTitle,
    this.creationDate,
    this.noteContent,
    this.colorId,
  });

  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? option,
  ) {
    final data = snapshot.data();
    return Note(
      uid: data?['uid'],
      noteTitle: data?['note_title'],
      creationDate: data?['creation_date'],
      noteContent: data?['note_content'],
      colorId: data?['color_id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid,
      if (noteTitle != null) "note_title": noteTitle,
      if (creationDate != null) "creation_date": creationDate,
      if (noteContent != null) "note_content": noteContent,
      if (colorId != null) "color_id": colorId,
    };
  }

  Note copyWith({
    String? uid,
    String? noteTitle,
    String? creationDate,
    String? noteContent,
    int? colorId,
  }) {
    return Note(
      uid: uid ?? this.uid,
      noteTitle: noteTitle ?? this.noteTitle,
      creationDate: creationDate ?? this.creationDate,
      noteContent: noteContent ?? this.noteContent,
      colorId: colorId ?? this.colorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'noteTitle': noteTitle,
      'creationDate': creationDate,
      'noteContent': noteContent,
      'colorId': colorId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      uid: map['uid'] != null ? map['uid'] as String : null,
      noteTitle: map['noteTitle'] != null ? map['noteTitle'] as String : null,
      creationDate:
          map['creationDate'] != null ? map['creationDate'] as String : null,
      noteContent:
          map['noteContent'] != null ? map['noteContent'] as String : null,
      colorId: map['colorId'] != null ? map['colorId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(uid: $uid, noteTitle: $noteTitle, creationDate: $creationDate, noteContent: $noteContent, colorId: $colorId)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.noteTitle == noteTitle &&
        other.creationDate == creationDate &&
        other.noteContent == noteContent &&
        other.colorId == colorId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        noteTitle.hashCode ^
        creationDate.hashCode ^
        noteContent.hashCode ^
        colorId.hashCode;
  }

  static Note empty() {
    return Note(
      uid: '',
      noteTitle: '',
      creationDate: '',
      noteContent: '',
      colorId: 0,
    );
  }
}
