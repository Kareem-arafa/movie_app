import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/trans/translations.dart';

import 'package:alice/alice.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/store.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/features/settings/settings_option.dart';
import 'package:movie_app/features/settings/settings_option_page.dart';
import 'package:movie_app/features/settings/text_scale.dart';
import 'package:movie_app/features/settings/theme.dart';
import 'package:movie_app/data/db/database_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/features/movie/movie_view.dart';

Future<Null> main() async {
  var store = await createStore();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(store));
  });
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingsOptions _options;
  Alice alice = Alice(showNotification: true);

  @override
  void initState() {
    super.initState();
    DatabaseClient();
    _options = new SettingsOptions(
      theme: AppTheme().appTheme,
      textScaleFactor: appTextScaleValues[0],
      platform: defaultTargetPlatform,
    );
    SharedPreferences.getInstance().then((prefs) {
      var isDark = prefs.getBool("isDark") ?? false;
      if (isDark) {
        AppTheme.configure(ThemeName.DARK);
        setState(() {
          _options = _options.copyWith(theme: AppTheme().appTheme);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'movie_app',
          debugShowCheckedModeBanner: false,
         // home: MovieView(),
          routes: _routes(),
          //theme: _options.theme.copyWith(platform: _options.platform),
          /*builder: (BuildContext context, Widget child) {
            return new Directionality(
              textDirection: _options.textDirection,
              child: _applyTextScaleFactor(child),
            );
          }*/
          /*localizationsDelegates: [
            const TranslationsDelegate(),*//* const Locale('zh', 'CH'),
            const Locale('en', 'US'),*//*
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [

          ]*/
        ));
  }


  Widget _applyTextScaleFactor(Widget child) {
    return new Builder(
      builder: (BuildContext context) {
        return new MediaQuery(
          data: MediaQuery.of(context).copyWith(
                textScaleFactor: _options.textScaleFactor.scale,
              ),
          child: child,
        );
      },
    );
  }

  void _handleOptionsChanged(SettingsOptions newOptions) {
    setState(() {
      _options = newOptions;
    });
  }

  Map<String, WidgetBuilder> _routes() {
    return <String, WidgetBuilder>{

     "/": (_) => new MovieView(),
    };
  }
}