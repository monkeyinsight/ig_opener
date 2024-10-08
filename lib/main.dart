import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MaterialApp.router(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color.fromRGBO(46, 48, 53, 1),
      secondary: const Color.fromRGBO(46, 48, 53, 1),
    )
  ),
  routerConfig: router
));

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key, required this.url});

  final String url;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    debugPrint('url: https://ig.monkeyinsight.com/p/' + widget.url + '/');
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://ig.monkeyinsight.com/p/' + widget.url + '/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(46, 48, 53, 1),
      appBar: null,
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(46, 48, 53, 1),
          appBar: null,
          body: const Text(':)'),
        );
      },
      routes: [
        GoRoute(
          path: '/reel/:url',
          builder: (context, state) {
            final String url = state.pathParameters['url'] ?? '';
            debugPrint('url: ' + url);
            return WebViewApp(url: url);
          }
        ),
        GoRoute(
          path: '/p/:url',
          builder: (context, state) {
            final String url = state.pathParameters['url'] ?? '';
            debugPrint('url: ' + url);
            return WebViewApp(url: url);
          }
        ),
      ]
    ),
  ],
);

