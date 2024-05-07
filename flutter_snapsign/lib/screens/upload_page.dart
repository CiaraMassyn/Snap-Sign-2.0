import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _filePath;
  String? _fileName;
  TextEditingController _textEditingController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDocument,
              child: Text('Upload Document'),
            ),
            SizedBox(height: 20),
            if (_filePath != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextField(
                  controller: _textEditingController,
                  readOnly: false,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Start typing here...',
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
            SizedBox(height: 20),
            if (_fileName != null)
              ElevatedButton(
                onPressed: _downloadDocument,
                child: Text('Download Document'),
              ),
          ],
        ),
      ),
    );
  }

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'doc', 'docx'], // Add allowed extensions
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
        _fileName = result.files.single.name!;
      });

      // Load the file contents into the text field
      final file = File(_filePath!);
      String contents = await file.readAsString();
      _textEditingController.text = contents; // Set text field content
    }
  }

  void _saveChanges() {
    String editedDocument = _textEditingController.text;
    print(editedDocument);
  }

  void _downloadDocument() async {
    String editedDocument = _textEditingController.text;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/$_fileName');
    
    await file.writeAsString(editedDocument);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Document downloaded to: ${file.path}'),
      ),
    );
  }
}