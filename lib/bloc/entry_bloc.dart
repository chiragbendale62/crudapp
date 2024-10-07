// lib/bloc/entry_bloc.dart

import 'package:crudapp/repositories/entry_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'entry_event.dart';
import 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final EntryRepository repository;

  EntryBloc({required this.repository}) : super(EntryInitial()) {
    on<LoadEntries>(_onLoadEntries);
    on<AddEntry>(_onAddEntry);
    on<UpdateEntry>(_onUpdateEntry);
    on<DeleteEntry>(_onDeleteEntry);
  }

  Future<void> _onLoadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    try {
      final entries = await repository.fetchEntries();
      emit(EntryLoaded(entries));
    } catch (e) {
      emit(const EntryError("Failed to load entries"));
    }
  }

  Future<void> _onAddEntry(AddEntry event, Emitter<EntryState> emit) async {
    if (state is EntryLoaded) {
      try {
        await repository.addEntry(event.entry);
        add(LoadEntries());
      } catch (e) {
        emit(const EntryError("Failed to add entry"));
      }
    }
  }

  Future<void> _onUpdateEntry(UpdateEntry event, Emitter<EntryState> emit) async {
    if (state is EntryLoaded) {
      try {
        await repository.updateEntry(event.entry);
        add(LoadEntries());
      } catch (e) {
        emit(const EntryError("Failed to update entry"));
      }
    }
  }

  Future<void> _onDeleteEntry(DeleteEntry event, Emitter<EntryState> emit) async {
    if (state is EntryLoaded) {
      try {
        await repository.deleteEntry(event.id);
        add(LoadEntries());
      } catch (e) {
        emit(const EntryError("Failed to delete entry"));
      }
    }
  }
}
