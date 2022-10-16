import 'dart:io';

import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;

  const WebviewPage({super.key, required this.url});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LINK',
          style: CustomTheme.appBarTitle,
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_) => setState(() => isLoading = false),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
