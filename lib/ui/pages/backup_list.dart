import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_todo_app/models/list_of_todo_model.dart';
import 'package:flutter_riverpod_todo_app/providers/todo_list_provider.dart';
import 'package:flutter_riverpod_todo_app/utils/storage.dart';
import 'package:flutter_riverpod_todo_app/ui/widgets/app_title.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackupList extends ConsumerWidget {
  const BackupList(
      {required this.listOfFiles, required this.storage, Key? key})
      : super(key: key);
  final Storage storage;
  final List<String> listOfFiles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _createAlert(ListOfTodoModel listOfTodoModel) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Restore this backup?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(todoListProvider.notifier)
                  ..overrideData(listOfTodoModel)
                  ..saveData();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Data Restored"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(
                'Restore',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          leadingTitle: 'Backup',
          trailingTitle: 'List',
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
        ],
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: listOfFiles.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () async {
                    ListOfTodoModel? listOfTodoModel = await storage.readData(
                      File(listOfFiles[index]),
                    );
                    if (listOfTodoModel != null) {
                      _createAlert(listOfTodoModel);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data is Empty!!!!!"),
                        ),
                      );
                    }
                  },
                  title: Text(
                    listOfFiles[index].substring(listOfFiles[index].length - 38,
                        listOfFiles[index].length),
                  ),
                  leading: const Icon(Icons.restore_rounded),
                  trailing: TextButton(
                    onPressed: () => storage.share(listOfFiles[index]),
                    child: const Icon(Icons.share),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
