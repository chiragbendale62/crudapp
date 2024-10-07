// lib/models/entry.dart

import 'package:equatable/equatable.dart';

class EntryModel extends Equatable {
  final int? id;
  final String name;
  final String description;

  const EntryModel({this.id, required this.name, required this.description});

  // Convert a Entry into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // Convert a Map into a Entry.
  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  EntryModel copyWith({int? id, String? name, String? description}) {
    return EntryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, name, description];
}
