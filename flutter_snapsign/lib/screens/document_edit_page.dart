import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
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

  bool _isSignaturePadOpen = false;
  Offset _signaturePosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Center(
            child: Stack(
              children: [
                PDFView(
                  filePath: widget.filePath,
                ),
                if (_isSignaturePadOpen) _buildSignaturePadOverlay(),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Back to Upload', style: TextStyle(color: Colors.green)),
                ),
                ElevatedButton(
                  onPressed: _isSignaturePadOpen ? null : _saveDocument,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text('Save Document', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSignaturePadOpen = true;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Add Signature', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignaturePadOverlay() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSignaturePadOpen = false;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                height: 200,
                color: Colors.white,
                child: Stack(
                  children: [
                    Signature(
                      controller: _controller,
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text('Clear', style: TextStyle(color: Colors.red)),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isSignaturePadOpen = false;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text('Close', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isSignaturePadOpen = false;
                            _signaturePosition = Offset(100, 100); //Line change
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveDocument() async {
    final signatureImage = await _controller.toPngBytes();

    final Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      final File file = File('${directory.path}/signed_document.pdf');
      await file.writeAsBytes(signatureImage!);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Successfully saved'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement download logic here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('Download', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, ModalRoute.withName('/')); 
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}