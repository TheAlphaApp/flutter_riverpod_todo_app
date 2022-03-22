import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../models/list_of_todo_model.dart';
import 'constants.dart';

abstract class Storage {
  Future<File?> writeData(ListOfTodoModel listOfTodoModel);
  Future<ListOfTodoModel?> readData(File selectedFile);
  Future<ListOfTodoModel?> readFromFilePicker();
  Future<List<String>> getListOfBackups();
  void share(String path);
}

class LocalStorage extends Storage {
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    var path = directory?.path;
    return path!;
  }

  Future<File> get _localFile async {
    DateTime now = DateTime.now();
    final path = await _localPath;
    return File('$path/backup-$now.json');
  }

  @override
  Future<List<String>> getListOfBackups() async {
    List<String> listOfFiles = [];
    final directory = await getExternalStorageDirectory();
    List<FileSystemEntity> allFiles = directory?.listSync() ?? [];
    for (var files in allFiles) {
      listOfFiles.add(files.path);
    }
    return listOfFiles;
  }

  @override
  Future<File?> writeData(ListOfTodoModel listOfTodoModel) async {
    // 3
    if (!await Permission.storage.request().isGranted) {
      return Future.value(null);
    }

    final file = await _localFile;
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    if (listOfTodoModel.data.isNotEmpty) {
      Map<String, dynamic> decodeOptions = listOfTodoModel.toJson();
      String encodedData = jsonEncode(
        ListOfTodoModel.fromJson(decodeOptions),
      );
      return file.writeAsString(encodedData);
    } else {
      return file.writeAsString(emptyJsonStringData);
    }
  }

  @override
  Future<ListOfTodoModel> readData(
    File selectedFile,
  ) async {
    // 1
    try {
      final jsonContents = await selectedFile.readAsString(); // 3
      Map<String, dynamic> jsonResponse = jsonDecode(jsonContents); // 4
      ListOfTodoModel listOfTodoModel = ListOfTodoModel.fromJson(jsonResponse);
      return listOfTodoModel; // 5
    } catch (e) {
      // If encountering an empty array
      return ListOfTodoModel(data: []);
    }
  }

  @override
  Future<ListOfTodoModel?> readFromFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    // 1
    if (result == null || !result.files.single.path!.endsWith('.json')) {
      return null;
    }

    File file = File(result.files.single.path!); // 3
    var listOfTodoModel = readData(file); // 4
    writeData(await listOfTodoModel);
    return listOfTodoModel;
  }

  @override
  void share(String path) async {
    // 1
    Share.shareFiles([path], text: 'Back up'); // 2
  }
}
