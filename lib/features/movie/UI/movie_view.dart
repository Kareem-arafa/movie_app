import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'movieScreen.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';

class MovieView extends StatefulWidget {
  final MovieViewModel viewModel;

  MovieView({Key key, this.viewModel}) : super(key: key);

  @override
  _MovieViewContentState createState() => _MovieViewContentState();
}

class _MovieViewContentState extends State<MovieView>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;

  bool isLoading = false;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void didUpdateWidget(MovieView oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration.zero, () {});
  }

  void showError(String error) {
    final snackBar = SnackBar(content: Text(error));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie app"),
        actions: <Widget>[
          FlatButton(
            child: Text('Favorite'),
            onPressed: (){
              Navigator.pushNamed(context,'Favorite');
            },
          )
        ],
        leading: Icon(
          Icons.home,
          color: Colors.white,
        ),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Popular'),
            Tab(text: 'Now playing'),
            Tab(text: 'top rated'),
            Tab(text: 'Upcoming'),
          ],
          controller: _tabController,
          indicatorColor: Colors.amber,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      key: _scaffoldKey,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MovieScreen(type: describeEnum(MovieType.popular)),
          MovieScreen(type: describeEnum(MovieType.now_playing)),
          MovieScreen(type: describeEnum(MovieType.top_rated)),
          MovieScreen(type: describeEnum(MovieType.upcoming)),
        ],
      ),

      //buildCustomScrollView(),
    );
  }
}
