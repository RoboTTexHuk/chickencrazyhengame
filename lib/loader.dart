import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:activity_ring/activity_ring.dart';

// Список фильтров для блокировки контента
final adBlockFilters = [
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

class CustomWebView extends StatefulWidget {
  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  bool showLoader = true; // Показывать лоадер по умолчанию
  late InAppWebViewController browserController;
  final List<ContentBlocker> adBlockerRules = [];

  @override
  void initState() {
    super.initState();

    // Добавляем правила блокировки рекламы
    for (final filter in adBlockFilters) {
      adBlockerRules.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: filter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    // Блокировка уведомлений о cookies
    adBlockerRules.add(ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
        ContentBlockerTriggerResourceType.RAW
      ]),
      action: ContentBlockerAction(
          type: ContentBlockerActionType.BLOCK, selector: ".notification"),
    ));

    // Скрытие элементов о конфиденциальности
    adBlockerRules.add(ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: ".cookie", resourceType: [
        ContentBlockerTriggerResourceType.RAW
      ]),
      action: ContentBlockerAction(
          type: ContentBlockerActionType.CSS_DISPLAY_NONE,
          selector: ".privacy-info"),
    ));

    // Скрытие баннеров и рекламы
    adBlockerRules.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));

    // Настройка цвета статус-бара
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
              url: WebUri("https://keyapp.birdsappgame.click/r4v5MR"), // URL страницы
            ),
            initialSettings: InAppWebViewSettings(
              disableDefaultErrorPage: true,
              contentBlockers: adBlockerRules,
            ),
            onWebViewCreated: (controller) {
              browserController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                showLoader = true; // Показать лоадер при загрузке
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                showLoader = false; // Скрыть лоадер после загрузки
              });
            },
          ),

          // Лоадер с кольцом (activity_ring)
          if (showLoader)
            Center(
              child: Ring(
                percent: 0.75, // Процент заполнения кольца (от 0.0 до 1.0)
                color: RingColorScheme(
                  ringColor: Colors.blue, // Цвет кольца
                  backgroundColor: Colors.grey.shade300, // Цвет фона кольца
                  gradient: true),

                radius: 50.0, // Радиус кольца
              ),
            ),
        ],
      ),
    );
  }
}