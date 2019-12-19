import 'package:flutter/material.dart';
import 'movie_details.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_app/redux/app/app_state.dart';



class Popular extends StatelessWidget {
  Popular({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieViewModel>(
      distinct: true,
      converter: (store) => MovieViewModel.fromStore(store),
      builder: (context, viewModel) => PopularMovie(
        viewModel: viewModel,
      ),
    );
  }
}

class PopularMovie extends StatefulWidget {
  final MovieViewModel viewModel;
  PopularMovie({Key key, this.viewModel}) : super(key: key);

  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;


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
@override
  void initState() {
    // TODO: implement initState
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
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
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
