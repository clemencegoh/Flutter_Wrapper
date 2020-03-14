// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


// class SimpleWebView extends StatefulWidget {
//   SimpleWebView({
//     Key key,
//   }): super(key: key);

//   static const routeName = '/webView';

//   @override
//   WebViewLoadingState createState() => WebViewLoadingState();
// }


// class WebViewLoadingState extends State<SimpleWebView> {
//   final _webViewPlugin = FlutterWebviewPlugin();

//   @override
//   void initState() {
//     super.initState();
//     // on pressing back button, exiting the screen instead of showing loading symbol
//     _webViewPlugin.onDestroy.listen((_) {
//       if (Navigator.canPop(context)) {
//         // exiting the screen
//         Navigator.of(context).pop();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final WebviewFromScannerArgs arguments = ModalRoute.of(context).settings.arguments;

//     String webURL = "https://www.google.com/";

//     if (arguments != null) {
//       webURL = arguments.websiteURL;
//     }

//     // WillPopScope will prevent loading
//     return WillPopScope(
//         child: WebviewScaffold(
//           url: webURL,
//           withZoom: false,
//           withLocalStorage: true,
//           withJavascript: true,
//           appCacheEnabled: true,
//           appBar: AppBar(
//             title: Text("Flutter Browser"),
//           ),
//         ),
//         onWillPop: () {
//           return _webViewPlugin.close();
//         }
//     );
//   }
// }

// class WebviewFromScannerArgs {
//   final String websiteURL;

//   WebviewFromScannerArgs(this.websiteURL);
// }