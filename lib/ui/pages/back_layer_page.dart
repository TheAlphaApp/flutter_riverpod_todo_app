import 'package:flutter/material.dart';
import 'package:flutter_riverpod_todo_app/ui/pages/about_us_page.dart';
import 'package:flutter_riverpod_todo_app/ui/pages/backup_and_restore.dart';
import 'package:flutter_riverpod_todo_app/ui/pages/instructions_page.dart';
import 'package:flutter_riverpod_todo_app/utils/storage.dart';

class BackLayerPage extends StatelessWidget {
  const BackLayerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 4)
          // color: Theme.of(context).primaryColor,
          ),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text('Backup & Restore'),
            leading: const Icon(Icons.restore),
            onTap: () {
              Storage storage = LocalStorage();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BackupAndRestorePage(
                    storage: storage,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Instructions'),
            leading: const Icon(Icons.info_outline_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InstructionPage(),
                ),
              );
            },
          ),
          ListTile(
            focusColor: Colors.red,
            leading: const Icon(Icons.verified_user),
            title: const Text('About US'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
