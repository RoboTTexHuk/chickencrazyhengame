import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:activity_ring/activity_ring.dart';
final Filltler = [
  ".*.doubleclick.net/.*",
  ".*.ads.pubmatic.com/.*",
  ".*.googlesyndication.com/.*",
  ".*.google-analytics.com/.*",
  ".*.adservice.google.*/.*",
  ".*.adbrite.com/.*",
  ".*.exponential.com/.*",
  ".*.quantserve.com/.*",
  ".*.scorecardresearch.com/.*",
  ".*.zedo.com/.*",
  ".*.adsafeprotected.com/.*",
  ".*.teads.tv/.*",
  ".*.outbrain.com/.*",
];


class WebViewWithLoader extends StatefulWidget {
  @override
  _WebViewWithLoaderState createState() => _WebViewWithLoaderState();
}

class _WebViewWithLoaderState extends State<WebViewWithLoader> {
  bool isLoading = true; // Показывать лоадер по умолчанию
  late InAppWebViewController webViewController;
  final List<ContentBlocker> contentBlockers = [];
@override
  void initState() {
  for (final adUrlFilter in Filltler) {
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: adUrlFilter,
        ),
        action: ContentBlockerAction(
          type: ContentBlockerActionType.BLOCK,
        )));
  }

  contentBlockers.add(ContentBlocker(
    trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
      //   ContentBlockerTriggerResourceType.IMAGE,

      ContentBlockerTriggerResourceType.RAW
    ]),
    action: ContentBlockerAction(
        type: ContentBlockerActionType.BLOCK, selector: ".notification"),
  ));

  contentBlockers.add(ContentBlocker(
    trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
      //   ContentBlockerTriggerResourceType.IMAGE,

      ContentBlockerTriggerResourceType.RAW
    ]),
    action: ContentBlockerAction(
        type: ContentBlockerActionType.CSS_DISPLAY_NONE,
        selector: ".privacy-info"),
  ));
  // apply the "display: none" style to some HTML elements
  contentBlockers.add(ContentBlocker(
      trigger: ContentBlockerTrigger(
        urlFilter: ".*",
      ),
      action: ContentBlockerAction(
          type: ContentBlockerActionType.CSS_DISPLAY_NONE,
          selector: ".banner, .banners, .ads, .ad, .advert")));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // InAppWebView
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri("https://keyapp.birdsappgame.click/r4v5MR"), // Замените на нужный URL
            ),
            initialSettings: InAppWebViewSettings(
              disableDefaultErrorPage: true,
              contentBlockers: contentBlockers,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true; // Показать лоадер при загрузке
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false; // Скрыть лоадер после загрузки
              });
            },
          ),

          // Лоадер с кольцом (activity_ring)
          if (isLoading)
            Center(
              child: Ring(
                percent: 0.75, // Обязательный параметр percent (от 0.0 до 1.0)
                color: RingColorScheme(
                  ringColor: Colors.blue, // Цвет кольца
                  backgroundColor: Colors.grey.shade300, // Цвет фона кольца
                  gradient:true, // Без градиента
                ),
                radius: 50.0, // Радиус кольца
              ),
            ),
        ],
      ),
    );
  }
}