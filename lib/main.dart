import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/store.dart';
import 'package:movie_app/features/movie/UI/movie_view.dart';

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

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'movie_app',
          debugShowCheckedModeBanner: false,
          // home: MovieView(),
          theme: ThemeData.dark(),
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




  Map<String, WidgetBuilder> _routes() {
    return <String, WidgetBuilder>{

      "/": (_) => new MovieView(),
    };
  }
}