import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator_app/styles/custom_theme.dart';
import 'package:meme_generator_app/views/select_meme.dart';

void main() {
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caps Oluştur',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: SelectMeme(),
    );
  }
}
