import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CommonPdfView extends StatelessWidget {
  final link;
  CommonPdfView({super.key, this.link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppbar('Invoice PDF'),
        body: Container(child: SfPdfViewer.network(link)));
  }
}
