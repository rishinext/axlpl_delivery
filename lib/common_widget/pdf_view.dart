import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contract'),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
        onPageChanged: (PdfPageChangedDetails details) {
          print('Page changed: ${details.newPageNumber}');
        },
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('Document loaded');
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print('Failed to load PDF: ${details.error}');
        },
      ),
    );
  }
}
