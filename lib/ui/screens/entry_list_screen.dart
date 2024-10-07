// lib/screens/entry_list_screen.dart

import 'package:crudapp/bloc/entry_bloc.dart';
import 'package:crudapp/bloc/entry_event.dart';
import 'package:crudapp/bloc/entry_state.dart';
import 'package:crudapp/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'entry_form_screen.dart';

class EntryListScreen extends StatelessWidget {
  const EntryListScreen({super.key});

  void _navigateToForm(BuildContext context, {EntryModel? entry}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EntryFormScreen(entry: entry),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('Entries List'),
      ),
      body: BlocBuilder<EntryBloc, EntryState>(
        builder: (context, state) {
          if (state is EntryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EntryLoaded) {
            if (state.entries.isEmpty) {
              return const Center(child: Text('No entries found.'));
            }
            return ListView.builder(
              itemCount: state.entries.length,
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                return ListTile(
                  title: Text(entry.name),
                  subtitle: Text(entry.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(context, entry: entry),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<EntryBloc>().add(DeleteEntry(entry.id!));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is EntryError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Press + to add a new entry'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
