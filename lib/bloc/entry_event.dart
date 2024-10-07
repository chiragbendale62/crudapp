// lib/bloc/entry_event.dart

import 'package:crudapp/models/entry_model.dart';
import 'package:equatable/equatable.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();

  @override
  List<Object?> get props => [];
}

class LoadEntries extends EntryEvent {}

class AddEntry extends EntryEvent {
  final EntryModel entry;

  const AddEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

class UpdateEntry extends EntryEvent {
  final EntryModel entry;

  const UpdateEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

class DeleteEntry extends EntryEvent {
  final int id;

  const DeleteEntry(this.id);

  @override
  List<Object?> get props => [id];
}
