import 'package:flutter/material.dart';
import 'package:flutter_snapsign/screens/document_view_page.dart';

class SignaturePadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Pad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add signature pad widget here
            ElevatedButton(
              onPressed: () {
                // Save signature and navigate to preview screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentPreviewPage(pdfUrl: '', filePath: '',),
                  ),
                );
              },
              child: Text('Save Signature'),
            ),
          ],
        ),
      ),
    );
  }
}
