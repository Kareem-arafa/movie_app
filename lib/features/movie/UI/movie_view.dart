import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/features/movie/UI/movie_details.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'package:movie_app/features/now%20playin/now%20playin_view.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'popular.dart';
import 'package:movie_app/features/topRated/topRared_view.dart';
import 'package:movie_app/features/upComing/upComing_view.dart';

class MovieView extends StatelessWidget {
  MovieView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieViewModel>(
      distinct: true,
      converter: (store) => MovieViewModel.fromStore(store),
      builder: (context, viewModel) =>
          MovieViewContent(
            viewModel: viewModel,
          ),
    );
  }
}

class MovieViewContent extends StatefulWidget {
  final MovieViewModel viewModel;

  MovieViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _MovieViewContentState createState() => _MovieViewContentState();
}

const double _fabHalfSize = 28.0;

class _MovieViewContentState extends State<MovieViewContent>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  ScrollController _scrollController = new ScrollController();
  TabController _tabController;

  bool isLoading = false;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    this.widget.viewModel.getMovieModels(true);
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this.widget.viewModel.getMovieModels(false);
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MovieViewContent oldWidget) {
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
          leading: Icon(Icons.home, color: Colors.white,),
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
          children: <Widget>[
            Popular(),
            nowplayinView(),
            TopRatedView(),
            UpComingView(),
          ],
          controller: _tabController,
        )
      //buildCustomScrollView(),
    );
  }

}



