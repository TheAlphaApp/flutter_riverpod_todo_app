import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../widgets/app_title.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? headline6 = Theme.of(context).textTheme.headline6;
    TextStyle? bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          leadingTitle: 'FAQs',
        ),
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to add a todo?',
                style: headline6,
              ),
              Text(
                'Tap on the big box "What\'s needs to be done?" given above on the homepage. And just type your todo and then press enter.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to mark a todo as completed?',
                style: headline6,
              ),
              Text(
                'Tap on the circle icon button leading the todo name.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to permanently delete a todo?',
                style: headline6,
              ),
              Text(
                'Just swipe the todo from any direction.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to pin a todo',
                style: headline6,
              ),
              Text(
                'Tap on the pin icon button trailing the todo name. It will be pinned to the Pinned tab.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to edit a todo?',
                style: headline6,
              ),
              Text(
                'Just tap on the todo title and type whatever you want.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to take backup of my todos?',
                style: headline6,
              ),
              Text(
                'Go to \'Backup and Restore\' page and just tap the big \'Create Backup\' button. Your backups will be saved on this folder "/Android/data/$appName/files/". Don\'t forget to give the storage permission to app.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to restore backup?',
                style: headline6,
              ),
              Text(
                'Go to \'Backup and Restore\' page and then tap the big \'List of backup files\' button. You will be navigated to the \'Backup List\' page where you will find all the backups created by time and date. Tap on the backup file title and then tap on the \'Restore\'. Your data is now restored.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to share backup file?',
                style: headline6,
              ),
              Text(
                'Go to \'Backup and Restore\' page and then tap the big \'List of backup files\' button. You will be navigated to the \'Backup List\' page where you will find all the backups created by time and date. Tap the share icon next to backup file title. Share wherever you want to share in json file format.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'How to restore backup file from storage?',
                style: headline6,
              ),
              Text(
                'Go to \'Backup and Restore\' page and just tap the big \'Restore backup from storage\' button. Then, just choose a valid json file and you\'re done.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Where can I find my created backup files in storage?',
                style: headline6,
              ),
              Text(
                'Go to this location in your file manager "/Android/data/$appName/files/". You will find all the created backup files in this folder.',
                style: bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
