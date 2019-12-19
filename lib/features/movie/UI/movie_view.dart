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

class MovieView extends StatelessWidget {
  MovieView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieViewModel>(
      distinct: true,
      converter: (store) => MovieViewModel.fromStore(store),
      builder: (context, viewModel) => MovieViewContent(
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

class _MovieViewContentState extends State<MovieViewContent> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  ScrollController _scrollController = new ScrollController();
  TabController _tabController;

  bool isLoading = false;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync:this);
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
        title:Text("Movie app"),
        bottom:  TabBar(

          tabs: [
            Tab(text: 'Popular'),
            Tab(text: 'Now playing'),
            Tab(text: 'Upcoming'),
            Tab(text: 'top rated'),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,),
          bottomOpacity: 1,
      ),
      key: _scaffoldKey,
      body: TabBarView(
        children: <Widget>[
         Popular(),
        // NowPlaying(),
          nowplayinView(),
          buildCustomScrollView(),
          TopRatedView(),
        ],
        controller: _tabController,
      )
      //buildCustomScrollView(),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  GridView buildCustomScrollView() {
    return GridView.builder(
      itemCount: this.widget.viewModel.moviemodels.length + 1,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == this.widget.viewModel.moviemodels.length) {
          return _buildProgressIndicator();
        } else {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${this.widget.viewModel.moviemodels[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(
                    title: this.widget.viewModel.moviemodels[index].title,
                    posterUrl:
                        this.widget.viewModel.moviemodels[index].posterPath,
                    description:
                        this.widget.viewModel.moviemodels[index].overview,
                    releaseDate:
                        this.widget.viewModel.moviemodels[index].releaseDate,
                    voteAverage: this
                        .widget
                        .viewModel
                        .moviemodels[index]
                        .voteAverage
                        .toString(),
                    movieId: this.widget.viewModel.moviemodels[index].id,
                  );
                }));
              },
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }
}


