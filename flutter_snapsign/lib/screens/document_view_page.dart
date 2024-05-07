import 'package:flutter/material.dart';
import 'package:flutter_snapsign/screens/dashboard_page.dart';
import 'package:flutter_snapsign/screens/document_edit_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentPreviewPage extends StatelessWidget {
  final String pdfUrl;
  final String filePath;

  const DocumentPreviewPage({Key? key, required this.pdfUrl, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _downloadPdf(pdfUrl);
              },
              child: Text('Download Document'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentEditPage(filePath: filePath),
                  ),
                );
              },
              child: Text('Edit Document'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadPdf(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
