import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebViewLoadingState extends StatefulWidget {
  @override
  _WebViewLoadingState createState() => _WebViewLoadingState();
}


class _WebViewLoadingState extends State<WebViewLoadingState> {
  final _webViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    // on pressing back button, exiting the screen instead of showing loading symbol
    _webViewPlugin.onDestroy.listen((_) {
      if (Navigator.canPop(context)) {
        // exiting the screen
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope will prevent loading
    return WillPopScope(
        child: WebviewScaffold(
          url: "https://www.google.com",
          withZoom: false,
          withLocalStorage: true,
          withJavascript: true,
          appCacheEnabled: true,
          appBar: AppBar(
            title: Center( child: Text("My Browser")),
          ),
        ),
        onWillPop: () {
          return _webViewPlugin.close();
        }
    );
  }
}