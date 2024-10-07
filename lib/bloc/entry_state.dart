// lib/bloc/entry_state.dart

import 'package:crudapp/models/entry_model.dart';
import 'package:equatable/equatable.dart';

abstract class EntryState extends Equatable {
  const EntryState();

  @override
  List<Object?> get props => [];
}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryLoaded extends EntryState {
  final List<EntryModel> entries;

  const EntryLoaded(this.entries);

  @override
  List<Object?> get props => [entries];
}

class EntryError extends EntryState {
  final String message;

  const EntryError(this.message);

  @override
  List<Object?> get props => [message];
}
