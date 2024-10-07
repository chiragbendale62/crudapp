import 'package:crudapp/bloc/entry_bloc.dart';
import 'package:crudapp/bloc/entry_event.dart';
import 'package:crudapp/repositories/entry_repository.dart';
import 'package:crudapp/ui/screens/entry_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryRepository repository = EntryRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EntryBloc(repository: repository)..add(LoadEntries()),
        ),
      ],
      child: MaterialApp(
        title: 'CRUD App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EntryListScreen(),
      ),
    );
  }
}
