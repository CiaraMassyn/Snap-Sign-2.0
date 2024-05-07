import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DocumentEditPage extends StatefulWidget {
  final String filePath;

  DocumentEditPage({required this.filePath});

  @override
  _DocumentEditPageState createState() => _DocumentEditPageState();
}

class _DocumentEditPageState extends State<DocumentEditPage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2, 
    penColor: Colors.black, 
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Editing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Signature(
              controller: _controller,
              backgroundColor: Colors.grey[200]!,
              height: 200, 
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  child: Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: _saveDocument,
                  child: Text('Save Document'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Upload'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDocument() {
    final signatureImage = _controller.toPngBytes();
    Navigator.pop(context); 
  }
}
