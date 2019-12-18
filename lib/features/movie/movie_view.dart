import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/features/movie/movie_details.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'package:movie_app/redux/app/app_state.dart';

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

class _MovieViewContentState extends State<MovieViewContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  @override
  void initState() {
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
    var widget;

    widget = buildCustomScrollView();
    return Scaffold(
      key: _scaffoldKey,
      body: widget,
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
    //var imagePath = "assets/images/flower2.png";
  /*  return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: this.widget.viewModel.moviemodels.length+1,
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
      staggeredTileBuilder: (int index) =>new StaggeredTile.count(2, index== this.widget.viewModel.moviemodels.length? 2 : 1),
    );*/
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

/*class MovieGridDelegate extends SpanableSliverGridDelegate {
  MovieGridDelegate() : super(2, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0);

  @override
  int getCrossAxisSpan(int index) {
    if (index % 5 == 0) return 2;

    return 1;
  }

  @override
  double getMainAxisExtent(int index) {
//    if(index == 0)
//      return 320.0;
//
//    if(index == 1 || index == 10)
//      return 250.0;

    return 220.0;
  }
}*/

/*
class _ProductItem extends StatelessWidget {
  const _ProductItem({Key key, @required this.product, this.onPressed})
      : assert(product != null),
        super(key: key);

  final int product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Card(
        elevation: 2.0,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration:
                          BoxDecoration(color: Theme.of(context).canvasColor),
                      child: Text("￥12.0")),
                ),
                Container(
                  foregroundDecoration: BoxDecoration(
                      border: Border.all(color: Colors.lightGreen)),
                  height: 144.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Hero(
                    tag: "123 $product",
                    child: Image.asset(
                      "assets/products/shirt.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 24.0,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 24.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              "assets/images/flower2.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text("name $product"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
*/
