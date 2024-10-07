// lib/repository/entry_repository.dart

import 'package:crudapp/models/entry_model.dart';
import 'package:crudapp/services/database_helper.dart';

class EntryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<EntryModel>> fetchEntries() async {
    return await _databaseHelper.getEntries();
  }

  Future<void> addEntry(EntryModel entry) async {
    await _databaseHelper.insertEntry(entry);
  }

  Future<void> updateEntry(EntryModel entry) async {
    await _databaseHelper.updateEntry(entry);
  }

  Future<void> deleteEntry(int id) async {
    await _databaseHelper.deleteEntry(id);
  }
}
