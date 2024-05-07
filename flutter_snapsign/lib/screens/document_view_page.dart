import 'package:flutter/material.dart';
import 'package:flutter_snapsign/screens/dashboard_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentPreviewPage extends StatelessWidget {
  final String pdfUrl;

  const DocumentPreviewPage({Key? key, required this.pdfUrl, required String filePath}) : super(key: key);

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
            // Add PDF preview widget here
            ElevatedButton(
              onPressed: () {
                _downloadPdf(pdfUrl);
              },
              child: Text('Download Document'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to home page
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
