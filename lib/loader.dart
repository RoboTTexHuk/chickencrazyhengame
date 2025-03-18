import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:activity_ring/activity_ring.dart';
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

  @override
}

  @override
  void initState() {
          trigger: ContentBlockerTrigger(
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

      trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
        ContentBlockerTriggerResourceType.RAW
      ]),
      action: ContentBlockerAction(
          type: ContentBlockerActionType.BLOCK, selector: ".notification"),
    ));

      trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
        ContentBlockerTriggerResourceType.RAW
      ]),
      action: ContentBlockerAction(
          type: ContentBlockerActionType.CSS_DISPLAY_NONE,
          selector: ".privacy-info"),
    ));
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // InAppWebView
          InAppWebView(
            initialUrlRequest: URLRequest(
            ),
            initialSettings: InAppWebViewSettings(
              disableDefaultErrorPage: true,
            ),
            onWebViewCreated: (controller) {
            },
            onLoadStart: (controller, url) {
              setState(() {
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
              });
            },
          ),

          // Лоадер с кольцом (activity_ring)
            Center(
              child: Ring(
                color: RingColorScheme(
                  ringColor: Colors.blue, // Цвет кольца
                  backgroundColor: Colors.grey.shade300, // Цвет фона кольца
                ),
                radius: 50.0, // Радиус кольца
              ),
            ),
        ],
      ),
    );
  }
}