// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_snapsign/screens/document_edit_page.dart';
// import 'package:flutter_snapsign/screens/document_view_page.dart';

// class UploadPage extends StatefulWidget {
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }

// class _UploadPageState extends State<UploadPage> {
//   String? _filePath;
//   String? _fileName;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Page'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickDocument,
//               child: Text('Upload PDF'),
//             ),
//             SizedBox(height: 20),
//             if (_filePath != null) ...[
//               Text(
//                 'Selected File: $_fileName',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_filePath != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DocumentPreviewPage(filePath: _filePath!, pdfUrl: '',),
//                       ),
//                     );
//                   } else {
//                     // Handle the case where no file is selected
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('No file selected')),
//                     );
//                   }
//                 },
//                 child: Text('View PDF'),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   void _pickDocument() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         _filePath = result.files.single.path!;
//         _fileName = result.files.single.name!;
//       });
//     }
//   }

//   void _editDocument() {
//   if (_filePath != null) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DocumentEditPage(filePath: _filePath!),
//       ),
//     );
//   } else {
//     // Handle the case where no file is selected
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('No file selected')),
//     );
//   }
// }

// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _filePath;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickDocument,
              child: Text('Upload PDF'),
            ),
            SizedBox(height: 20),
            if (_filePath != null) ...[
              Text(
                'Selected File: $_fileName',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_filePath != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentPreviewPage(filePath: _filePath!),
                      ),
                    );
                  } else {
                    // Handle the case where no file is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No file selected')),
                    );
                  }
                },
                child: Text('View PDF'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
        _fileName = result.files.single.name!;
      });
    }
  }
}

class DocumentPreviewPage extends StatelessWidget {
  final String filePath;

  DocumentPreviewPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Preview'),
      ),
      body: Center(
        child: PDFView(
          filePath: filePath,
          // Optionally, you can add more configurations here
          // For example: zoomOptions, scrollDirection, etc.
          // Check flutter_pdfview documentation for more options
        ),
      ),
    );
  }
}