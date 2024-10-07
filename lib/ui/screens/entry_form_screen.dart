// lib/screens/entry_form_screen.dart

import 'package:crudapp/bloc/entry_bloc.dart';
import 'package:crudapp/bloc/entry_event.dart';
import 'package:crudapp/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryFormScreen extends StatefulWidget {
  final EntryModel? entry;

  const EntryFormScreen({super.key, this.entry});

  @override
  _EntryFormScreenState createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;

  @override
  void initState() {
    super.initState();
    _name = widget.entry?.name ?? '';
    _description = widget.entry?.description ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final entry = EntryModel(
        id: widget.entry?.id,
        name: _name,
        description: _description,
      );

      if (widget.entry == null) {
        context.read<EntryBloc>().add(AddEntry(entry));
      } else {
        context.read<EntryBloc>().add(UpdateEntry(entry));
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Entry' : 'Add Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (val) => _name = val!,
                validator: (val) => val == null || val.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => _description = val!,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
