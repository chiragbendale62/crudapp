// integration_test/app_test.dart

import 'package:crudapp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CRUD operations test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify that the list is empty initially
    expect(find.text('No entries found.'), findsOneWidget);

    // Tap the add button
    final Finder addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Enter name and description
    await tester.enterText(find.bySemanticsLabel('Name'), 'Test Entry');
    await tester.enterText(find.bySemanticsLabel('Description'), 'This is a test.');

    // Submit the form
    final Finder submitButton = find.text('Add');
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify the entry is added
    expect(find.text('Test Entry'), findsOneWidget);
    expect(find.text('This is a test.'), findsOneWidget);

    // Tap the edit button
    final Finder editButton = find.byIcon(Icons.edit);
    expect(editButton, findsOneWidget);
    await tester.tap(editButton);
    await tester.pumpAndSettle();

    // Update the name and description
    await tester.enterText(find.bySemanticsLabel('Name'), 'Updated Entry');
    await tester.enterText(find.bySemanticsLabel('Description'), 'This is an updated test.');

    // Submit the form
    final Finder updateButton = find.text('Update');
    await tester.tap(updateButton);
    await tester.pumpAndSettle();

    // Verify the entry is updated
    expect(find.text('Updated Entry'), findsOneWidget);
    expect(find.text('This is an updated test.'), findsOneWidget);
    expect(find.text('Test Entry'), findsNothing);
    expect(find.text('This is a test.'), findsNothing);

    // Tap the delete button
    final Finder deleteButton = find.byIcon(Icons.delete);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify the entry is deleted
    expect(find.text('No entries found.'), findsOneWidget);
  });
}
