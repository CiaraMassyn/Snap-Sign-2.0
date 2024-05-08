import 'package:flutter/material.dart';
import 'package:flutter_snapsign/screens/document_edit_page.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DocumentPreviewPage extends StatelessWidget {
  final String pdfUrl;
  final String filePath;

  DocumentPreviewPage({Key? key, required this.pdfUrl, required this.filePath}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false, 
      ),
      body: Stack(
        children: [
          Center(
            child: PDFView(
              filePath: filePath,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      'Back to Upload',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _editDocument(context, filePath);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      'Edit Document',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editDocument(BuildContext context, String filePath) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentEditPage(filePath: filePath),
      ),
    );
  }
}
