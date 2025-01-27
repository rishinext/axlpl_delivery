import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Widget body;
  final appBar;
  const CommonScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: themes.lightWhite,
      body: body,
    );
  }
}
